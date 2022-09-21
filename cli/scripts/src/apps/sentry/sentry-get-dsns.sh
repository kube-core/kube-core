## Docs Start ##
## Generates Sentry DSNs for proejct. Args: projectName appName apiKey
## Docs End ##

projectName=$1
appName=$2
apiKey=$3

dsn=$(curl -s https://sentry.${cluster_config_domain}/api/0/projects/sentry/${projectName}-${appName}/keys/ -H "Authorization: Bearer ${apiKey}" | jq -r '.[0].dsn.public')

split1=$(echo "$dsn" | awk '{split($0,a,"@"); print a[1]}')
dsn_key=$(echo "$split1" | awk '{split($0,a,"//"); print a[2]}')

split2=$(echo "$dsn" | awk '{split($0,a,"@"); print a[2]}')
dsn_id=$(echo "$split2" | awk '{split($0,a,"/"); print a[2]}')

data=$(cat <<EOF
devops-tools:
  full_dsn: ${dsn}
  dsn: ${dsn_key}
  id: ${dsn_id}
EOF
)
echo "$data"
