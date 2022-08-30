#!/bin/bash
set -eou pipefail

## Header Start

# Current Script
currentScript=${BASH_SOURCE[0]}
currentScriptPath="$( cd "$( dirname "${currentScript}" )" >/dev/null 2>&1 && pwd )"
currentScriptShortPath=$(echo "${currentScriptPath}" | awk '{split($0, a, "/scripts/"); print a[2]}')

# Cluster Config
if [[ ! -z $(find ./cluster-config.yaml 2> /dev/null) ]]; then
    clusterConfigPath=$(echo ./cluster-config.yaml | head -n 1 | xargs realpath 2> /dev/null)
else
    clusterConfigPath=$(eval find ./$(printf "{$(echo %{1..7}q,)}" | sed 's/ /\.\.\//g') -maxdepth 1 -name cluster-config.yaml | head -n 1 | xargs realpath 2> /dev/null) || true
fi
if [[ -z "${clusterConfigPath}" ]] ; then
    echo "Stopping ${currentScript}"
    echo "This script requires to be in a cluster context, but cluster-config.yaml not found in parent directories"
    exit 0
fi

clusterConfigDirPath=$(dirname ${clusterConfigPath} | xargs realpath)
helmfilePath="${clusterConfigDirPath}/helmfile.yaml"
tmpFolder="${clusterConfigDirPath}/.kube-core/.tmp"

# Cluster Scripts
if [[ ! -z $(find ${currentScriptPath}/scripts-config.yaml 2> /dev/null) ]]; then
    scriptsConfigPath=$(echo ${currentScriptPath}/scripts-config.yaml | head -n 1 | xargs realpath 2> /dev/null)
else
    scriptsConfigPath=$(eval find "${currentScriptPath}"/$(printf "{$(echo %{1..7}q,)}" | sed 's/ /\.\.\//g') -maxdepth 1 -name scripts-config.yaml | head -n 1 | xargs realpath)
fi
scriptsConfigDirPath=$(dirname ${scriptsConfigPath} | xargs realpath)

defaultClusterConfigPath=${scriptsConfigDirPath}/default-cluster-config.yaml
corePath=$(echo ${scriptsConfigDirPath}/../.. | xargs realpath)
coreTmpFolder="${corePath}/.kube-core/.tmp"

# Loading scripts
eval "$(${scriptsConfigDirPath}/src/includes.sh)"

# Loading default-cluster-config.yaml
clusterConfigVars=$(parse_yaml ${defaultClusterConfigPath})
clusterConfigVars=$(echo "${clusterConfigVars}" | sed "s|\./|${clusterConfigDirPath}/|")
eval "${clusterConfigVars}"

# Loading cluster-config.yaml
clusterConfigVars=$(parse_yaml ${clusterConfigPath})
clusterConfigVars=$(echo "${clusterConfigVars}" | sed "s|\./|${clusterConfigDirPath}/|")
eval "${clusterConfigVars}"

# Loading scripts-config.yaml
paths=$(parse_yaml ${scriptsConfigPath})
absolutePaths=$(echo "${paths}" | sed "s|\./|${scriptsConfigDirPath}/|")
eval "${absolutePaths}"

check_requirements
prepare_workspace
check_context "${cluster_config_context}"
# check_args "$@"
## Header End



log_debug "${project_name} - Installing Cluster"

configPath=${config_path}
localPath=${localConfig_path}

# By default, applies patches & doesn't regenerate secrets
arg1=${1:-"none"}
arg2=${2:-"none"}
arg3=${3:-"patch"}

commandArgs="${arg1} ${arg2} ${arg3}"

helmfileArgs=""
gitOpsArgs=""

log_debug "${project_name} - Installing Cluster"

echo "Getting kubeconfig..."
${scripts_cloud_gcp_setup_kubeconfig_path}

if [[ "${install_velero}" == "true" ]]
then
    echo "Setup Velero Buecket & SA"
    ${scripts_cloud_gcp_setup_velero_path}

    helmfileArgs="${helmfileArgs} -l name=velero"
    gitOpsArgs="${gitOpsArgs} -f ${config_path}/velero"
fi

if [[ "${install_externaldns}" == "true" ]]
then
    echo "Setup DNS SA"
    ${scripts_cloud_gcp_setup_dns_path}

    helmfileArgs="${helmfileArgs} -l name=external-dns"
    gitOpsArgs="${gitOpsArgs} -f ${config_path}/external-dns"
else
    echo "WARNING: Not installing external-dns. Removing config inherited from generation"
    rm -rf ${secrets_path}/replicated/external-dns/secrets/dns-admin.yaml
fi

if [[ "${install_gcr}" == "true" ]]
then
    echo "Setup GCR SA"
    ${scripts_cloud_gcp_setup_gcr_path}
else
    echo "WARNING: Not installing gcr"
fi

if [[ "${install_certmanager}" == "true" ]]
then
    helmfileArgs="${helmfileArgs} -l name=cert-manager -l name=cluster-issuers"
    gitOpsArgs="${gitOpsArgs} -f ${config_path}/cert-manager"
else
    echo "WARNING: Not installing cert-manager. Removing config inherited from generation"
    rm -rf ${secrets_path}/replicated/cert-manager/secrets/dns-admin.yaml
fi

if [[ "${install_sealedsecrets}" == "true" ]]
then

    helmfileArgs="${helmfileArgs} -l name=sealed-secrets"
    gitOpsArgs="${gitOpsArgs} -f ${config_path}/sealed-secrets"

    helmfileArgs="${helmfileArgs} -l name=replicator"
    gitOpsArgs="${gitOpsArgs} -f ${config_path}/replicator"

else
    echo "WARNING: Not installing sealed-secrets. Removing config inherited from generation"
fi

if [[ "${install_tekton}" == "true" ]]
then
    ${scripts_cloud_gcp_setup_tekton_path}
    ${scripts_cloud_gcp_setup_tekton_storage_path}
    ${scripts_cloud_gcp_setup_tekton_git_path}

    helmfileArgs="${helmfileArgs} -l name=tekton"
    gitOpsArgs="${gitOpsArgs} -f ${config_path}/tekton-pipelines"

else
    echo "WARNING: Not installing tekton. Removing config inherited from generation"
fi

if [[ "${install_flux}" == "true" ]]
then
    echo "Installing Flux2..."
    echo "WARNING: Flux2 is installed with kubectl !"
    # kubectl apply -R -f ${localConfig_path}/flux-system --wait

    # Flux2 is "manually" installed, whatever the install type
    # Uncomment the following lines if you implement it as a Chart or config/flux-system from template

    helmfileArgs="${helmfileArgs} -l name=flux"
    gitOpsArgs="${gitOpsArgs} -f ${config_path}/flux-system"


    # if [[ "${install_full}" == "true" ]]
    # then
        # echo "WARNING: install_full check is disabled for this step !"
        # echo "WARNING: Applying flux-system manifests with kubectl !"
        # kubectl apply -f ${localConfig_path}/flux-system/namespace.yaml || true
        # kubectl apply -R -f ${localConfig_path}/flux-system || true
    # fi

else
    echo "WARNING: Not installing flux. Removing config inherited from generation"
    # rm -rf ${localConfig_path}/flux-system
fi




${scripts_cluster_setup_pre_install_path}

echo "WARNING: Cleaning config path before first build/install !"
rm -rf ${config_path}
mkdir -p ${config_path}


# Installing

if [[ "${install_type}" == "helmfile" && "${install_full}" == "true" ]]
then
    # echo "First installing CRDs..."
    # echo "WARNING: Non Helm Managed CRDs will be destroyed first!"
    # kubectl delete -R -f ${crds_path} || true
    # crdsToDelete=$(${scripts_gitops_utils_get_helm_managed_path} "kind: CustomResourceDefinition")
    # echo "${crdsToDelete}" | xargs -i kubectl delete -f '{}'
    # echo "Done deleting Non Helm Managed CRDs !"


    # Applying CRDs
    echo "Installing CRDs !"
    ${scripts_cluster_apply_crds_path}

    echo "Installing required services..."
    echo "WARNING: Services are installed with Helmfile !"

    cd ${clusterConfigDirPath}
    helmfile -f ${helmfilePath} ${helmfileArgs} apply
    cd -
    echo "Done installing required services !"


    # SealedSecrets
    if [[ "${install_sealedsecrets}" == "true" ]]
    then
        echo "Getting SealedSecrets certificate"
        ${scripts_cluster_setup_sealedsecrets_get_certificate_path}
    fi

    echo "Generating secrets for the first install !"


    ${scripts_gitops_replicated_secrets_path}

    ${scripts_gitops_secrets_path}
    echo "Secrets generated !"

    # Applying Secrets - Has to be after helmfile apply because of sealed secrets requirement
    ${scripts_cluster_apply_secrets_path}

fi

if [[ "${install_type}" == "gitops" ]]
then
    echo "WARNING: GitOps install is not yet fully implemented."
    echo "WARNING: Required stuff will be generated, then it's up to you !"
    # echo "Installing SealedSecrets"
    # ${scripts_cluster_setup_sealedsecrets_install_path}
    echo "GitOps - Generating Dependencies"
    echo "${scripts_gitops_helmfile_path} ${helmfileArgs}"
    ${scripts_gitops_helmfile_path} ${helmfileArgs}

    if [[ "${install_full}" == "true"  ]]
    then
        echo "GitOps - Applying dependencies"
        echo "WARNING: Applying pre-compiled dependencies with kubectl apply !"
        kubectl apply -R ${gitOpsArgs}
        echo "GitOps - Done applying dependencies"
    fi
    # Hack: Applies 2 times for namespaces that need time
    # TODO: Find a fix
    # kubectl apply -R ${gitOpsArgs}
    # Secrets
fi

# If gitops & non interactive, we need to build flux first
if [[ "${install_gitops}" == "true" &&  ! "${install_interactive}" == "true" ]]
then
    echo "WARNING: Non interactive gitops install is not tested yet !"
    echo "WARNING: Use at your own risk :) !"

    mkdir -p ${localConfig_path}/flux-system/sources
    mkdir -p ${localConfig_path}/flux-system/kustomizations

    flux create source git k8s-cluster-${cluster_config_name} \
        --url=${gitops_repository} \
        --branch=${gitops_ref} \
        --interval=${gitops_refresh} \
        --private-key-file ${gitops_ssh_key} \
        --export ${localConfig_path}/flux-system/sources

    flux create kustomization k8s-cluster-${cluster_config_name}-full \
        --source=GitRepository/k8s-cluster-${cluster_config_name} \
        --path=".${gitops_path}" \
        --prune=true \
        --interval=${gitops_refresh} \
        --validation=client \
        --export ${localConfig_path}/flux-system/kustomizations

fi

echo "Building cluster for the first time !"
if [[ ${install_sealedsecrets} == "true" ]]
then
    echo "Building cluster with secrets"
    ${scripts_build_path} secrets
    echo "Done building cluster for the first time !"
else
    echo "WARNING: Building cluster withhout secrets, handle them yourself !"
    ${scripts_build_path}
fi

if [[ "${install_type}" == "gitops" ]]
then
    echo "WARNING: GitOps install is not yet fully implemented."
    echo "WARNING: Required stuff will be generated, then it's up to you !"
    # echo "Installing SealedSecrets"
    # ${scripts_cluster_setup_sealedsecrets_install_path}

    if [[ "${install_full}" == "true"  ]]
    then
        echo "GitOps - Applying all manifests"
        echo "WARNING: Applying all manifests with kubectl apply !"
        kubectl apply -R -f ${config_path}
        echo "GitOps - Done applying all manifests"
    fi

    if [[ "${gitops_autocommit}" == "true"  ]]
    then
        echo "GitOps - Autocommit..."
        echo "WARNING: ${config_path} will be added and committed !"

        cd ${clusterConfigDirPath}
        echo "Pulling..."
        git pull

        git status

        echo "Adding config files..."

        git add ${config_path}

        if [[ ${install_sealedsecrets} == "true" ]]
        then
            echo "Adding generated secrets..."
            git add ${secrets_path}/output

        fi


        echo "Commiting..."
        git commit -m "gitops: Install regeneration (cluster/setup/install.sh)"

        echo "Pushing..."
        git push
        cd -

        echo "Autocommit done !"
    fi
fi


if [[ "${install_type}" == "helmfile" && "${install_full}" == "true" ]]
then

    # Applying everything
    ${scripts_cluster_apply_path}

fi

# GitOps Setup
if [[ "${install_gitops}" == "true" &&  "${install_interactive}" == "true" ]]
then

    if [[ "${install_interactive}" == "true" ]]
    then

        flux create source git k8s-cluster-${cluster_config_name} \
            --url=${gitops_repository} \
            --branch=${gitops_ref} \
            --interval=${gitops_refresh} \
            --private-key-file ${gitops_ssh_key}

        flux create kustomization k8s-cluster-${cluster_config_name}-full \
            --source=GitRepository/k8s-cluster-${cluster_config_name} \
            --path=".${gitops_path}" \
            --prune=true \
            --interval=${gitops_refresh} \
            --validation=client
    fi
fi


echo "Done installing, have fun ! :)"

${scripts_cluster_setup_post_install_path}
