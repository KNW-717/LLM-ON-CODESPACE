import gradio as gr
import ollama

# Gestione deterministica della memoria
current_model = None

def chat_engine(message, history, model_name):
    global current_model
    
    # Unload del modello precedente se cambiato
    if current_model is not None and current_model != model_name:
        try:
            # Impostando keep_alive a 0 forziamo lo svuotamento della RAM
            ollama.generate(model=current_model, keep_alive=0)
            print(f"♻️ RAM Liberata: {current_model} rimosso.")
        except Exception as e:
            print(f"⚠️ Errore unload: {e}")
            
    current_model = model_name

    try:
        response = ollama.chat(
            model=model_name,
            messages=[{'role': 'user', 'content': message}],
            stream=True
        )
        
        partial_message = ""
        for chunk in response:
            if 'message' in chunk and 'content' in chunk['message']:
                partial_message += chunk['message']['content']
                yield partial_message
    except Exception as e:
        yield f"❌ Errore sistema: {str(e)}"

# UI Design
with gr.Blocks(theme=gr.themes.Soft()) as demo:
    gr.Markdown("# 🤖 AI Engineering Lab")
    gr.Markdown("Interfaccia remota ottimizzata per CPU 4-core e 16GB RAM.")
    
    with gr.Row():
        model_selector = gr.Dropdown(
            choices=["phi3:mini", "dolphin-mistral"], 
            value="phi3:mini", 
            label="Seleziona Modello (Solo uno attivo in RAM)"
        )
    
    chat = gr.ChatInterface(
        fn=chat_engine, 
        additional_inputs=[model_selector]
    )

if __name__ == "__main__":
    demo.launch(server_name="0.0.0.0", server_port=7860)
