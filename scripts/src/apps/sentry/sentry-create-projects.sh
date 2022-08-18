projectName=$1
appName=$2
apiKey=$3

curl https://sentry.${cluster_config_domain}/api/0/teams/sentry/${projectName}/projects/ \
 -H "Authorization: Bearer ${apiKey}" \
 -H 'Content-Type: application/json' \
 -d '{"name":"${projectName}-${appName}","slug":"${projectName}-${appName}", "platform":"node-express"}'
