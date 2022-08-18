
Mysql-backups
===========

A Helm chart for kubernetes cronjob to do mysql-backup


## Configuration

The following table lists the configurable parameters of the Mysql-backups chart and their default values.

| Parameter                | Description             | Default        |
| ------------------------ | ----------------------- | -------------- |
| `mySqlBackup.schedule` | (Required) Cronjob schedule | `"0 08 * * *"` |
| `mySqlBackup.backupCreateDatabaseStatement` | (Optional - default false) Adds the CREATE DATABASE and USE statements to the MySQL backup by explicitly specifying the --databases flag (see here). | `false` |
| `mySqlBackup.backupAdditionalParams` | (Optional) Additional parameters to add to the mysqldump command. | `""` |
| `mySqlBackup.backupTimestamp` | (Optional) Date string to append to the backup filename (date format). Leave unset if using S3 Versioning and date stamp is not required. | `"_%Y_%m_%d"` |
| `mySqlBackup.backupCompress` | (Optional) (true/false) Enable or disable gzip backup compression - (Default False). | `false` |
| `mySqlBackup.backupCompressLevel` | (Optional - default 9) Set the gzip level used for compression. | `"9"` |
| `mySqlBackup.agePublicKey` | (Optional) Public key used to encrypt backup with FiloSottile/age. Leave blank to disable backup encryption. | `""` |
| `mySqlBackup.targetDatabaseHost` | (Required) Hostname or IP address of the MySQL Host. | `"localhost"` |
| `mySqlBackup.targetDatabasePort` | (Optional) Port MySQL is listening on (Default: 3306). | `"3306"` |
| `mySqlBackup.targetAllDatabases` | (Optional - default false) Set to true to ignore TARGET_DATABASE_NAMES and dump all non-system databases. | `"false"` |
| `mySqlBackup.targetDatabaseNames` | (Required unless TARGET_ALL_DATABASES is true) Name of the databases to dump. This should be comma seperated (e.g. database1,database2). | `""` |
| `mySqlBackup.targetDatabaseUser` | (Required) Username to authenticate to the database with. | `""` |
| `mySqlBackup.targetDatabasePassword.existingSecret` | (Required) Password to authenticate to the database with. Should be configured using a Secret in Kubernetes. | `""` |
| `mySqlBackup.targetDatabasePassword.secretKey` | (Required) | `""` |
| `mySqlBackup.backupProvider` | (Optional) The backend to use for storing the MySQL backups. Supported options are gcp (default) or aws | `"gcp"` |
| `mySqlBackup.gcpGcloudAuth.existingSecret` | (Required for GCP Backend) Base64 encoded service account key exported as JSON. Secret content itself need to be b64enc. Example of how to generate: base64 ~/service-key.json | `""` |
| `mySqlBackup.gcpGcloudAuth.secretKey` | (Required) | `""` |
| `mySqlBackup.gcpBucketName` | (Required for GCP Backend) The name of GCP GCS bucket. | `""` |
| `mySqlBackup.gcpBucketBackupPath` | (Required for GCP Backend) Path the backup file should be saved to in GCS. E.g. /database/myblog/backups. Do not put a trailing / or specify the filename. | `""` |
| `mySqlBackup.awsAccessKeyId` | (Required for AWS Backend) AWS IAM Access Key ID. | `""` |
| `mySqlBackup.awsSecretAccessKey.existingSecret` | (Required for AWS Backend) AWS IAM Secret Access Key. Should have very limited IAM permissions (see below for example) and should be configured using a Secret in Kubernetes. | `""` |
| `mySqlBackup.awsSecretAccessKey.secretKey` | (Required) | `""` |
| `mySqlBackup.awsDefaultRegion` | (Required for AWS Backend) Region of the S3 Bucket (e.g. eu-west-2). | `""` |
| `mySqlBackup.awsBucketName` | (Required for AWS Backend) The name of the S3 bucket. | `""` |
| `mySqlBackup.awsBucketBackupPath` | (Required for AWS Backend) Path the backup file should be saved to in S3. E.g. /database/myblog/backups. Do not put a trailing / or specify the filename. | `""` |
| `mySqlBackup.awsS3Endpoint` | (Optional) The S3-compatible storage endpoint (for MinIO/other cloud storage) bucket. | `""` |
| `mySqlBackup.slackEnabled` | (Optional) (true/false) Enable or disable the Slack Integration (Default False). | `false` |
| `mySqlBackup.slackUsername` | (Optional) (true/false) Username to use for the Slack Integration (Default: kubernetes-cloud-mysql-backup). | `false` |
| `mySqlBackup.slackChannel` | (Required if Slack enabled) Slack Channel the WebHook is configured for. | `""` |
| `mySqlBackup.slackWebhookUrl.existingSecret` | (Required if Slack enabled) What is the Slack WebHook URL to post to? Should be configured using a Secret in Kubernetes. | `""` |
| `mySqlBackup.slackWebhookUrl.secretKey` | (Required) | `""` |
