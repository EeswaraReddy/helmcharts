FROM python:3.9-slim
WORKDIR /app
COPY app.py .
RUN pip install gradio subprocess-run
RUN apt-get update && apt-get install -y curl && \
    curl -LO https://github.com/k8sgpt-ai/k8sgpt/releases/download/v0.4.14/k8sgpt_Linux_x86_64.tar.gz && \
    tar -xzf k8sgpt_Linux_x86_64.tar.gz && \
    mv k8sgpt /usr/local/bin/ && \
    chmod +x /usr/local/bin/k8sgpt
CMD ["python", "app.py"]