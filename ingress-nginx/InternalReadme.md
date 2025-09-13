# Deploying ingress-nginx Using Bitnami Helm Chart

This guide provides step-by-step instructions to download and extract the Apache Spark Helm chart from Bitnami.

## Step 1: Add the Bitnami Helm Repository

Add the official Bitnami Helm repository to your Helm configuration:

```bash
helm repo add ingress-nginx https://kubernetes.github.io/ingress-nginx
helm repo update
```

This ensures you have access to the latest Bitnami Helm charts.

## Step 2: Pull the Spark Helm Chart

Download and extract the Spark Helm chart using the following command:

```bash
helm pull ingress-nginx/ingress-nginx --version 4.11.2
tar -xzf ingress-nginx-4.11.2.tgz
```

This will download and extract the chart into a folder named `ingress-nginx` in your current working directory.

🚀Now lets run gitlab cicd to deplopy throug argocd (/applications/ingress-nginx.yaml)

## Link ingress helmchart with argocd

```sh
 kubectl apply -f applications/ingress-nginx.yaml
 ```