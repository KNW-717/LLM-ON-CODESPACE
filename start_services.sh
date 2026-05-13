#!/bin/bash
hash -r

echo "🚀 Inizializzazione Laboratorio AI..."

# 1. Avvio Tailscale in modalità userspace (per container)
sudo mkdir -p /var/run/tailscale /var/cache/tailscale /var/lib/tailscale
sudo tailscaled --tun=userspace-networking --socks5-server=localhost:1055 &
sleep 2

# 2. Connessione alla Mesh VPN
if [ -z "$TAILSCALE_AUTH_KEY" ]; then
    echo "⚠️ TAILSCALE_AUTH_KEY non trovata nei Secrets. Accesso remoto disabilitato."
else
    sudo tailscale up --authkey="${TAILSCALE_AUTH_KEY}" --hostname=codespace-ai --accept-dns=false
fi

# 3. Avvio Motore AI
nohup ollama serve > /tmp/ollama.log 2>&1 &

# 4. Avvio Web GUI (Gradio)
nohup python3 scripts/web_gui.py > /tmp/gui.log 2>&1 &

echo "✅ Sistema pronto sulla porta 7860"
