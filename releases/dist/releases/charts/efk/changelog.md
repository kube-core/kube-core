# 1.1.0

- Add basic handling for repository & snapshot lifecycle policy creation through the chart using either S3 or GCS

# 1.0.1

- Add kube version constraint

# 1.0.0

- Update dependencies to latest
- Upgrade to helm3

# 0.4.1

- Fix log4j issue [CVE-2021-44228](https://cve.mitre.org/cgi-bin/cvename.cgi?name=CVE-2021-44228)

# 0.4.0

- Add elastic search prometheus metrics exporter

# 0.3.0

 - Add clusterName variable for templation in fluent-bit configmap

# 0.2.0

- Add fluent-bit configmap templated with watchedNamespace in values
- Add env variable to kibana for index pattern templating

# 0.1.0

- Init efk from elasticsearch fluent-bit fluentd kibana and metricbeat
