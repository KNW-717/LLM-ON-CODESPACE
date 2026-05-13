FROM mcr.microsoft.com/devcontainers/python:3.11-bookworm

ENV DEBIAN_FRONTEND=noninteractive

# 1. Installazione dipendenze di sistema e tool ingegneristici
RUN apt-get update && apt-get install -y --no-install-recommends \
    curl git build-essential cmake wget pkg-config zstd \
    binutils-arm-none-eabi gcc-arm-none-eabi \
    && apt-get clean && rm -rf /var/lib/apt/lists/*

# 2. Installazione Tailscale
RUN curl -fsSL https://tailscale.com/install.sh | sh

# 3. Installazione Ollama (motore GGUF)
RUN curl -fsSL https://ollama.com/install.sh | sh

# 4. Librerie Python (AI & Data Science)
RUN pip install --no-cache-dir ollama huggingface_hub hf_transfer numpy scipy matplotlib gradio

ENV HF_HUB_ENABLE_HF_TRANSFER=1
EXPOSE 11434 7860
