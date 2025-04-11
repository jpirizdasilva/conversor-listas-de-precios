import gradio as gr
from scripts.cloudeModel import process_file
import tempfile
import os


def process_and_create_file(file, prompt_template):
    try:
        if not file:
            raise gr.Error("Por favor, sube un archivo.")

        # Procesar el archivo y obtener el contenido y nombre del CSV
        csv_content, filename = process_file(file, prompt_template)
        
        # Crear archivo temporal
        temp_dir = tempfile.gettempdir()
        temp_path = os.path.join(temp_dir, filename)
        
        # Guardar el contenido en el archivo temporal
        with open(temp_path, 'w', encoding='utf-8', newline='') as f:
            f.write(csv_content)
        
        return [
            temp_path,
            "Archivo procesado exitosamente. Haga clic en el botón de descarga para obtener el CSV."
        ]
    except Exception as e:
        raise gr.Error(f"Error al procesar: {str(e)}")


def create_interface():
    with gr.Blocks() as iface:
        gr.Markdown("# Conversor de Listas de Precios a CSV")
        
        with gr.Row():
            with gr.Column():
                file_input = gr.File(
                    label="Subir archivo (Excel o PDF)",
                )
                prompt_input = gr.Textbox(
                    label="Instrucciones adicionales (opcional)",
                    value="Procesa los datos y genera un CSV según el formato especificado."
                )
                submit_btn = gr.Button("Procesar")

            with gr.Column():
                file_output = gr.File(label="Archivo CSV generado")
                output_text = gr.Textbox(label="Estado")

        submit_btn.click(
            fn=process_and_create_file,
            inputs=[file_input, prompt_input],
            outputs=[file_output, output_text]
        )

    return iface


if __name__ == "__main__":
    try:
        iface = create_interface()
        iface.launch(
            server_name="localhost",
            server_port=7860,
            show_error=True,
            inbrowser=True,
            debug=True
        )
    except Exception as e:
        print(f"Error al iniciar la aplicación. Revisa la consola para más detalles.")
