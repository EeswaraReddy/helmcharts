# Argo CD Installation Using Helm

## Adding the Argo CD Helm Repository
Run the following command to add the Argo CD Helm repository:
## prequiste deploy secrets 
Pantherlab-tls yaml to deploy
kubectl apply -f cert-tlstermination.yaml

```sh
helm repo add argo https://argoproj.github.io/argo-helm
helm repo update
helm pull argo/argo-cd --untar

```
## Customised Values
Copy values.yaml fie as values-dev.yaml
Update as  values as required

## Installing Argo CD with Helm
To install Argo CD in the `argocd` namespace:

```sh

helm install argocd argo/argo-cd --namespace dev-argocd 

run kubectl apply -f ingress.yaml to apply ingress 
```

## Retrieving the Admin Password
After installation, retrieve the Argo CD admin password using:

```sh
kubectl get secret -n dev-argocd argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 --decode
```

## Accessing the Argo CD UI


https://46.xxxxx:30080/


Then, open a browser and go to:


Login using the username `admin` and the retrieved password.

## Uninstalling Argo CD
To uninstall Argo CD, run:

```sh
helm uninstall argocd -n argocd
kubectl delete namespace argocd
```
## Gitlab connectvity setup with Argocd
# Connecting ArgoCD to GitLab Using SSH Keys

This guide explains how to connect ArgoCD to your GitLab repository (`progressive-mind-infra/Chimera`) using SSH keys for secure access. Follow these steps to set up the integration.

### Step 1: Connect ArgoCD to GitLab Using SSH Keys

### 1.1 Generate an SSH Key Pair

Generate an SSH key pair on your local machine or wherever you manage ArgoCD:

```bash
ssh-keygen -t ed25519 -C "argocd@gitlab" -f argocd-key
```

This creates:
- `argocd-key` (private key)
- `argocd-key.pub` (public key)

For simplicity, leave the passphrase empty. For production, consider adding a passphrase for security.

### 1.2 Add the Public Key to GitLab

Add the public key to your GitLab repository:

1. Navigate to [GitLab Repository](https://gitlab.com/progressive-mind-infra/Chimera).
2. Go to **Settings > Repository > Deploy Keys**.
3. Click **Add Deploy Key**:
   - **Title:** `argocd`
   - **Key:** Paste the contents of `argocd-key.pub` (e.g., `ssh-ed25519 AAAAC3Nza... argocd@gitlab`)
   - **Grant write access:** Check this box if you want ArgoCD to push changes (optional, not required here).
4. Click **Add key** to save.

### nstall argocd cli

   curl -sSL -o argocd-linux-amd64 https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
   sudo install -m 555 argocd-linux-amd64 /usr/local/bin/argocd

### 1.3 Log Into ArgoCD

Log into your ArgoCD instance, which is exposed via NodePort:

#### Get the NodePort and node IP:
```bash
kubectl get svc argocd-server -n argocd
kubectl get nodes -o wide
```

Example output: NodePort might be `32456`, and a node IP might be `192.168.1.100`.

#### Access ArgoCD:
```
https://192.168.1.100:32456
```

#### Log in using the ArgoCD CLI:
```bash
argocd login 192.168.1.100:32456 --insecure --username admin --password $(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)
```

Replace `192.168.1.100:32456` with your actual node IP and NodePort.

### 1.4 Add the GitLab Repository to ArgoCD with SSH

Add the `progressive-mind-infra/Chimera` repository to ArgoCD using its SSH URL:

```bash
argocd repo add git@gitlab.com:progressive-mind-infra/Chimera.git --ssh-private-key-path ./argocd-key
```

Ensure the `argocd-key` private key file is in your current directory. If it’s elsewhere, provide the full path (e.g., `/path/to/argocd-key`).

### 1.5 Verify Connection

Verify that ArgoCD can connect to the GitLab repository:

```bash
argocd repo list
```

Expected output should include:
```
TYPE  NAME  REPO                                               CONNECTION STATE
git         git@gitlab.com:progressive-mind-infra/Chimera.git  Succeeded
```

If **Connection State** is `Succeeded`, the setup is complete.


