# Deploying Apache Spark Using Bitnami Helm Chart

This guide provides step-by-step instructions to download and extract the Apache Spark Helm chart from Bitnami.

## Step 1: Add the Bitnami Helm Repository

Add the official Bitnami Helm repository to your Helm configuration:

```bash
helm repo add bitnami https://charts.bitnami.com/bitnami
helm repo update
```

This ensures you have access to the latest Bitnami Helm charts.

## Step 2: Pull the Spark Helm Chart

Download and extract the Spark Helm chart using the following command:

```bash
helm pull bitnami/spark --untar
```

This will download and extract the chart into a folder named `spark` in your current working directory.

🚀Now lets run gitlab cicd to deplopy throug argocd (/applications/spark.yaml)

## Link spark helmchart with argocd

```sh
 kubectl apply -f applications/spark.yaml
 ```