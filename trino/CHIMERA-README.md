# Trino Helm Cluster
* Initial chart is from https://github.com/trinodb/charts
* This chart values-chimera.yaml file is modified according to our use case.
* Get the image tag from this https://hub.docker.com/r/trinodb/trino/tags
* vault-injector has to inject the secrets as env variables.
* Set the POSTGRES_URL values as env variable
