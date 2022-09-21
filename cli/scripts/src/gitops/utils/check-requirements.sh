#!/bin/bash
set -eou pipefail
## Docs Start ##
## Checks if all kube-core requirements are met and enforces required folder structure
## Docs End ##

# pip install argparse
# TODO: Reimplement with proper versions
prepare_workspace() {

    if [[ ! -z "${clusterConfigDirPath}" ]]; then
        mkdir -p ${clusterConfigDirPath}/config
        mkdir -p ${clusterConfigDirPath}/helmfiles
        mkdir -p ${clusterConfigDirPath}/local
        mkdir -p ${clusterConfigDirPath}/local/build
        mkdir -p ${clusterConfigDirPath}/local/config
        mkdir -p ${clusterConfigDirPath}/local/crds
        mkdir -p ${clusterConfigDirPath}/local/configmaps
        mkdir -p ${clusterConfigDirPath}/local/configmaps/input
        mkdir -p ${clusterConfigDirPath}/local/configmaps/output
        mkdir -p ${clusterConfigDirPath}/local/configmaps/manifests
        mkdir -p ${clusterConfigDirPath}/local/configmaps/replicated
        mkdir -p ${clusterConfigDirPath}/local/secrets
        mkdir -p ${clusterConfigDirPath}/local/secrets/input
        mkdir -p ${clusterConfigDirPath}/local/secrets/output
        mkdir -p ${clusterConfigDirPath}/local/secrets/manifests
        mkdir -p ${clusterConfigDirPath}/local/secrets/replicated
        mkdir -p ${clusterConfigDirPath}/local/overlays
        mkdir -p ${clusterConfigDirPath}/local/patches
        mkdir -p ${clusterConfigDirPath}/test
        mkdir -p ${clusterConfigDirPath}/policy/base
        mkdir -p ${clusterConfigDirPath}/policy/custom
    fi

}

check_requirements() {

    if ! which git >/dev/null; then
        echo "git is not installed, please install it"
        exit 2
    fi

    if ! which python >/dev/null; then
        echo "python is not installed, please install it (v3.9.0)"
        exit 2
    fi

    if ! which node >/dev/null; then
        echo "node is not installed, please install it"
        echo "Ubuntu:"
        echo "curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -"
        echo "sudo apt-get install -y nodejs"
        exit 2
    fi

    if ! which jq >/dev/null; then
        echo "jq is not installed, please install it"
        echo "apt-get install jq"
        exit 2
    fi

    if ! which yq >/dev/null; then
        echo "yq is not installed, please install it"
        echo "wget -q https://github.com/mikefarah/yq/releases/download/v4.25.1/yq_linux_amd64 -O /usr/local/bin/yq"
        exit 2
    fi

    if ! which kubectl >/dev/null; then
        echo "kubectl is not installed, please install it"
        echo "arkade get kubectl"
        exit 2
    fi

    if ! which helm >/dev/null; then
        echo "helm is not installed, please install it"
        echo "binenv install helm 3.8.0"
        exit 2
    fi

    # if [[ -z $(helm diff version) ]] >/dev/null; then
    #     echo "helm diff is not installed, please install it"
    #     echo "helm plugin install https://github.com/databus23/helm-diff"
    #     exit 2
    # fi

    if ! which helmfile >/dev/null; then
        echo "helmfile is not installed, please install it"
        echo "wget -q https://github.com/roboll/helmfile/releases/download/v0.144.0/helmfile_linux_386 -O helmfile"
        exit 2
    fi

    if ! which kubeseal >/dev/null; then
        echo "binenv install kubeseal 0.18.1"
        exit 2
    fi

    if ! which gcloud >/dev/null; then
        echo "gcloud is not installed, please install it"
        echo "curl -sSL https://sdk.cloud.google.com | bash"
        exit 2
    fi

    if ! which gsutil >/dev/null; then
        echo "gsutil is not installed, please install it"
        echo "curl -sSL https://sdk.cloud.google.com | bash"
        exit 2
    fi

    if ! which kustomize >/dev/null; then
        echo "kustomize is not installed, please install it (v4.4.0)"
        echo "binenv install kustomize 4.5.5"
        exit 2
    fi

    # Carvel
    if ! which vendir >/dev/null; then
        echo "vendir is not installed, please install it"
        echo "curl -L https://carvel.dev/install.sh | bash"
        exit 2
    fi

    if ! which ytt >/dev/null; then
        echo "ytt is not installed, please install it (v0.30.0)"
        echo "curl -L https://carvel.dev/install.sh | bash"
        exit 2
    fi

    if ! which kbld >/dev/null; then
        echo "kbld is not installed, please install it (v0.30.0)"
        echo "curl -L https://carvel.dev/install.sh | bash"
        exit 2
    fi

    # kube-core
    # if ! which argparse >/dev/null; then
    #     echo "argparse is not installed, please install it"
    #     echo "pip install argparse==1.4.0"
    #     exit 2
    # fi

    if ! which plop >/dev/null; then
        echo "plop is not installed, please install it"
        echo "npm install -g plop@3.1.0"
        exit 2
    fi

}
