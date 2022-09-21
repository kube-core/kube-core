#!/bin/bash
## Docs Start ##
## A lib of utils to setup cloud resources
## Docs End ##
set -eou pipefail

gcloud_iam_sa_create() {
    serviceAccount="${cluster_config_name}-${1}"
    log_info "Creating SA: ${serviceAccount}"
    if [[ "${LOG_LEVEL}" == "DEBUG" || "${LOG_LEVEL}" == "INSANE" ]]; then
        gcloud iam service-accounts create ${serviceAccount} --project ${cloud_project}  || true
    else
        gcloud iam service-accounts create ${serviceAccount} --project ${cloud_project} &> /dev/null || true
    fi
}

gcloud_iam_sa_delete() {
    serviceAccount="${cluster_config_name}-${1}"
    log_info "Deleting SA: ${serviceAccount}"
    gcloud iam service-accounts delete --quiet ${serviceAccount}@${cloud_project}.iam.gserviceaccount.com --project ${cloud_project} || true
}

gcloud_iam_add_policy_bindings() {
    serviceAccount="${cluster_config_name}-${1}"
    shift
    roles=$(echo $@)

    log_info "Binding roles: [${roles}] to ${serviceAccount}"
    for role in $roles; do
        if [[ "${LOG_LEVEL}" == "DEBUG" || "${LOG_LEVEL}" == "INSANE" ]]; then
            gcloud projects add-iam-policy-binding ${cloud_project} --member=serviceAccount:${serviceAccount}@${cloud_project}.iam.gserviceaccount.com --role=${role}
        else
                gcloud projects add-iam-policy-binding ${cloud_project} --member=serviceAccount:${serviceAccount}@${cloud_project}.iam.gserviceaccount.com --role=${role} &> /dev/null
        fi
    done
}


gcloud_iam_sa_delete_keys() {
    serviceAccount="${cluster_config_name}-${1}"

    log_info "Deleting all keys for SA: ${serviceAccount}"
    keys=$(gcloud iam service-accounts keys list --iam-account=${serviceAccount}@${cloud_project}.iam.gserviceaccount.com | tail -n +2 | awk '{print $1}')
    if [[ "${LOG_LEVEL}" == "DEBUG" || "${LOG_LEVEL}" == "INSANE" ]]; then
        while read i; do gcloud iam service-accounts keys delete --iam-account=${serviceAccount}@${cloud_project}.iam.gserviceaccount.com --quiet $i ;done <<< "$keys" || true
    else
        while read i; do gcloud iam service-accounts keys delete --iam-account=${serviceAccount}@${cloud_project}.iam.gserviceaccount.com --quiet $i &> /dev/null ;done <<< "$keys" || true
    fi
}

gcloud_iam_sa_create_key() {
    serviceAccount="${cluster_config_name}-${1}"
    # For the SA Key, we don't want the cluster prefix by default, as the secret generated from it is already scoped to the cluster
    credentialsFile="${secrets_path}/input/${1}.json"

    log_info "Generating a new key for: ${serviceAccount}"
    if [[ "${LOG_LEVEL}" == "DEBUG" || "${LOG_LEVEL}" == "INSANE" ]]; then
        gcloud iam service-accounts keys create ${credentialsFile} --iam-account ${serviceAccount}@${cloud_project}.iam.gserviceaccount.com || true
    else
        gcloud iam service-accounts keys create ${credentialsFile} --iam-account ${serviceAccount}@${cloud_project}.iam.gserviceaccount.com &> /dev/null || true
    fi

    if [[ ! -f "${credentialsFile}" ]]; then
        log_error "Credentials generation failed!"
        exit 1
    else
        log_info "Key for ${serviceAccount} generated at: ${credentialsFile}"
    fi
}

gcloud_prepare_apis() {
    # enable Kubernetes API
    gcloud --project ${cloud_project} services enable container.googleapis.com && true

    # enable Compute API
    gcloud --project ${cloud_project} services enable compute.googleapis.com && true

    # # enable CloudSQL API
    # gcloud --project ${cloud_project} services enable sqladmin.googleapis.com && true

    # # enable Redis API
    # gcloud --project ${cloud_project} services enable redis.googleapis.com && true

    # # enable Service Networking API
    # gcloud --project ${cloud_project} services enable servicenetworking.googleapis.com && true
}

gcloud_prepare_sa_roles() {

log_info "Creating a gcrAdmin role..."
if [[ "${LOG_LEVEL}" == "DEBUG" || "${LOG_LEVEL}" == "INSANE" ]]; then
    gcloud iam roles create gcrAdmin --project ${cloud_project} --permissions=storage.objects.get,storage.objects.create,storage.objects.list,storage.objects.update,storage.objects.delete,storage.buckets.create,storage.buckets.get,cloudbuild.builds.get,cloudbuild.builds.list || true
else
gcloud iam roles create gcrAdmin --project ${cloud_project} --permissions=storage.objects.get,storage.objects.create,storage.objects.list,storage.objects.update,storage.objects.delete,storage.buckets.create,storage.buckets.get,cloudbuild.builds.get,cloudbuild.builds.list &> /dev/null || true
fi

log_info "Creating a gcsAdmin role..."
if [[ "${LOG_LEVEL}" == "DEBUG" || "${LOG_LEVEL}" == "INSANE" ]]; then
    gcloud iam roles create gcsAdmin --project ${cloud_project} --permissions=storage.objects.get,storage.objects.create,storage.objects.list,storage.objects.update,storage.objects.delete,storage.buckets.create,storage.buckets.get || true
else
gcloud iam roles create gcsAdmin --project ${cloud_project} --permissions=storage.objects.get,storage.objects.create,storage.objects.list,storage.objects.update,storage.objects.delete,storage.buckets.create,storage.buckets.get &> /dev/null || true
fi

log_info "Creating a velero role..."
if [[ "${LOG_LEVEL}" == "DEBUG" || "${LOG_LEVEL}" == "INSANE" ]]; then
    gcloud iam roles create velero --project ${cloud_project} --permissions=compute.disks.get,compute.disks.create,compute.disks.createSnapshot,compute.snapshots.get,compute.snapshots.create,compute.snapshots.useReadOnly,compute.snapshots.delete,compute.zones.get || true
else
gcloud iam roles create velero --project ${cloud_project} --permissions=compute.disks.get,compute.disks.create,compute.disks.createSnapshot,compute.snapshots.get,compute.snapshots.create,compute.snapshots.useReadOnly,compute.snapshots.delete,compute.zones.get &> /dev/null || true
fi
}

gcloud_destroy_sa_config() {
    commands=$(echo "${serviceAccountsConfig}" | yq -o json | jq -r -M -c '.serviceAccounts[] | "\(.name) \(.roles|@sh)"' | sed 's/"//g' | sed "s/'//g")

    while read commandArgs; do
        command=$(echo gcloud_iam_sa_delete $commandArgs)
        log_debug $command
        $command
        log_debug "--"
    done <<< "$commands"
}
gcloud_generate_sa_config() {

commands=$(echo "${serviceAccountsConfig}" | yq -o json | jq -r -M -c '.serviceAccounts[] | "\(.name) \(.roles|@sh)"' | sed 's/"//g' | sed "s/'//g")

while read commandArgs; do
    command=$(echo gcloud_iam_sa_create $commandArgs)
    log_debug $command
    $command

    command=$(echo gcloud_iam_add_policy_bindings $commandArgs)
    log_debug $command
    $command

    command=$(echo gcloud_iam_sa_delete_keys $commandArgs)
    log_debug $command
    $command

    command=$(echo gcloud_iam_sa_create_key $commandArgs)
    log_debug $command
    $command

    log_debug "---"
done <<< "$commands"

}

make_bucket() {
    bucketName=${1}
    gsutil mb -b on --pap enforced -l ${cloud_default_location} -p ${cloud_project} gs://${cluster_config_name}-${bucketName} || true
}

gcloud_setup_velero_bucket() {
    make_bucket velero-backups || true
    gsutil iam ch serviceAccount:${cluster_config_name}-velero@${cloud_project}.iam.gserviceaccount.com:objectAdmin gs://${cluster_config_name}-velero-backups || true
}

gcloud_setup_thanos_bucket() {
    make_bucket thanos-storage || true
    gsutil iam ch serviceAccount:${cluster_config_name}-thanos@${cloud_project}.iam.gserviceaccount.com:objectAdmin gs://${cluster_config_name}-thanos-storage || true
}

gcloud_setup_tekton_bucket() {
    make_bucket tekton-storage || true
    gsutil iam ch serviceAccount:${cluster_config_name}-tekton@${cloud_project}.iam.gserviceaccount.com:objectAdmin gs://${cluster_config_name}-tekton-storage || true
}

gcloud_setup_generate_thanos_secret() {

secret=$(cat <<EOF
apiVersion: v1
kind: Secret
metadata:
  name: thanos-objstore
stringData:
  objstore.yml: |-
    type: GCS
    config:
      bucket: "${cluster_config_name}-thanos-storage"
      service_account: |-
        $(cat "${secrets_path}/input/thanos.json" | jq -c)
EOF
)

echo "$secret" > "${secrets_path}/manifests/thanos-objstore.yaml"
if [[ ! -f "${secrets_path}/manifests/thanos-objstore.yaml" ]]; then
    log_error "Secret generation failed!"
    exit 1
else
    log_info "Secret for Thanos generated at: ${secrets_path}/manifests/thanos-objstore.yaml"
fi

}
