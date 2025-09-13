#!/bin/bash

# Exit on error
set -e

echo "Starting Superset setup..."

# Check if kubectl is available
if ! command -v kubectl &> /dev/null; then
    echo "kubectl is not installed. Please install it first."
    exit 1
fi

# Check if helm is available
if ! command -v helm &> /dev/null; then
    echo "helm is not installed. Please install it first."
    exit 1
fi

# Add the Superset Helm repository if not already added
echo "Adding Superset Helm repository..."
helm repo add superset https://apache.github.io/superset
helm repo update

# Create namespace if it doesn't exist
echo "Creating namespace if it doesn't exist..."
kubectl create namespace superset --dry-run=client -o yaml | kubectl apply -f -

# Install/upgrade Superset using Helm
echo "Installing/upgrading Superset..."
helm upgrade --install superset superset/superset \
    --namespace superset \
    --values values.yaml \
    --wait

# Wait for pods to be ready
echo "Waiting for Superset pods to be ready..."
kubectl wait --for=condition=ready pod -l app.kubernetes.io/name=superset -n superset --timeout=300s

# Get the Superset pod name
SUPERSET_POD=$(kubectl get pods -n superset -l app.kubernetes.io/name=superset -o jsonpath="{.items[0].metadata.name}")

# Verify PostgreSQL connection
echo "Verifying PostgreSQL connection..."
kubectl exec -n superset $SUPERSET_POD -- python3 -c "
import socket
s = socket.socket()
s.settimeout(5)
result = s.connect_ex(('chimera-postgresql', 5432))
print('PostgreSQL connection successful' if result == 0 else f'PostgreSQL connection failed with error code {result}')
"

# Setup port forwarding in background
echo "Setting up port forwarding..."
echo "To access Superset UI, run: kubectl port-forward svc/superset 8088:8088 -n superset"
echo "Keep the port-forward terminal window open while using Superset"
echo "When done, press Ctrl+C in the port-forward terminal to stop"

echo "Superset setup completed!"
echo "You can access the Superset UI at http://localhost:8088"
echo "Default credentials:"
echo "Username: admin"
echo "Password: admin"
echo ""
echo "To add the Chimera database in Superset UI, use this SQLAlchemy URI:"
echo "postgresql://chimera_user:chimera_pass@chimera-postgresql:5432/chimera_db" 