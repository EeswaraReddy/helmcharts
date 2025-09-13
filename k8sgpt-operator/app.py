import gradio as gr
import subprocess
import os
import re

def run_k8sgpt(namespace, query):
    cmd = "k8sgpt analyze --backend ollama --explain"
    if namespace and namespace != "all":
        cmd += f" --namespace {namespace}"
    if query:
        cmd += f" --filter {query}"
    result = subprocess.run(cmd, shell=True, capture_output=True, text=True)
    output = result.stdout or result.stderr
    
    # Format output with colors
    # Color errors red
    output = re.sub(r'(\*\*Error:\*\*[^\n]+)', r'<span style="color:red">\1</span>', output)
    # Color solutions green
    output = re.sub(r'(\*\*Solution:\*\*[^\n]+(?:\n\s*\d\..+)+)', r'<span style="color:green">\1</span>', output, flags=re.MULTILINE)
    return output

os.system("k8sgpt auth add --backend ollama --baseurl http://ollama.ollama.svc.cluster.local:11434 --model gemma:2b")
os.system("k8sgpt auth set-default ollama")

with gr.Blocks() as demo:
    gr.Markdown("# K8sGPT Web Interface")
    gr.Markdown("""
    ## Useful Links
    - [Keycloak](https://deviam.pantherslabs.com)
    - [ArgoCD](https://devargocd.pantherslabs.com)
    - [Documentation](https://progressivemindsinfra.atlassian.net/wiki/spaces/PE/pages/884746/Platform+Engineering)
    - [GitLab Infra](https://gitlab.com/progressive-mind-infra/Chimera)
    - [Platform Jira](https://progressivemindsinfra.atlassian.net/jira/software/projects/PEC/boards/1)
    - [K8s Dashboard for Admins](https://platform.pantherslabs.com/)
    - [API Gateway](https://devapi.pantherslabs.com)
    """)
    namespace = gr.Dropdown(
        label="Namespace",
        choices=[
            "all",
            "dashboard",
            "default",
            "dev-apiservices",
            "dev-apisix",
            "dev-argocd",
            "dev-keycloak",
            "dev-kyverno",
            "dev-monitoring",
            "dev-openebs",
            "dev-postgresql",
            "dev-raycluster",
            "dev-vault",
            "ingress-nginx",
            "k8sgpt",
            "keycloak",
            "kube-node-lease",
            "kube-public",
            "kube-system",
            "ollama",
            "platformapp",
            "trino"
        ],
        value="all"
    )
    query = gr.Textbox(label="Query (e.g., Pod, Deployment)", placeholder="Leave blank for full analysis")
    output = gr.HTML(label="Results")
    submit = gr.Button("Analyze")
    submit.click(fn=run_k8sgpt, inputs=[namespace, query], outputs=output)

demo.launch(server_name="0.0.0.0", server_port=7860)