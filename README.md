# Remote AI Engineering Lab (Ollama + Gradio + Tailscale)

Questo progetto permette di trasformare un **GitHub Codespace** (4 core, 16GB RAM) in un laboratorio AI remoto, accessibile da qualsiasi dispositivo (tablet, smartphone, PC) tramite una rete mesh VPN sicura.

## 🚀 Caratteristiche Principali
- **Efficienza Hardware**: Ottimizzato per girare su CPU senza GPU dedicata (formato GGUF).
- **Gestione Dinamica RAM**: Logica di auto-unload che mantiene attivo un solo modello alla volta per non saturare i 16GB di RAM.
- **Accesso Remoto**: Integrazione con Tailscale per bypassare firewall e port-forwarding pubblici.
- **Multi-Modello**: Supporto pre-configurato per `Phi-3 Mini` (logica/tecnico) e `Dolphin-Mistral` (creativo/uncensored).

## 🛠️ Requisiti
- Un account GitHub con accesso a **Codespaces**.
- Un account **Tailscale** (opzionale, per accesso remoto).

## 📥 Installazione (Fork & Setup)

1. **Effettua il Fork**: Clicca sul pulsante `Fork` in alto a destra per copiare questa repository nel tuo account.
2. **Configura i Segreti**:
   - Vai in `Settings` -> `Secrets and variables` -> `Codespaces`.
   - Aggiungi un nuovo segreto chiamato `TAILSCALE_AUTH_KEY`.
   - Inserisci la tua Auth Key generata dal pannello di controllo di Tailscale.
3. **Avvia il Codespace**:
   - Clicca sul tasto verde `Code` -> `Codespaces` -> `Create codespace on main`.
   - Attendi la build (verranno installati Ollama, Tailscale e i modelli).

## 🖥️ Utilizzo

### Accesso Locale
Una volta avviato, VS Code mostrerà un popup per aprire la porta **7860**. Puoi usare la chat direttamente nel browser del tuo PC.

### Accesso Remoto (Tablet/Smartphone)
1. Apri il terminale nel Codespace e digita: `tailscale ip -4`.
2. Sul tuo tablet (con Tailscale attivo), apri il browser e digita: `http://[IP-OTTENUTO]:7860`.

## 🧠 Gestione della Memoria
Il sistema è progettato per preservare le risorse per altri task di ingegneria (es. compilazione codice C/C++):
- **Unload Automatico**: Al cambio modello, quello precedente viene rimosso dalla RAM.
- **Comandi Manuali**: 
  - `ollama stop [modello]` per liberare RAM istantaneamente.
  - `top` o `htop` per monitorare il carico sui 4 core.

## 📄 Licenza
Distribuito sotto licenza MIT. Libero di essere modificato e condiviso.
