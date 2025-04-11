import os
import pandas as pd
import anthropic
from dotenv import load_dotenv
from pathlib import Path
from PyPDF2 import PdfReader
from scripts.system_propt import SYSTEM_PROMPT

# Cargar variables de entorno
load_dotenv()

# Configurar cliente de Anthropic
api_key = os.getenv('ANTHROPIC_API_KEY')
if not api_key:
    raise ValueError(
        "No se encontró la clave API de Anthropic. Por favor, configura ANTHROPIC_API_KEY en el archivo .env")

client = anthropic.Anthropic(api_key=api_key)


def process_file(file, prompt_template):
    file_path = file.name
    file_extension = os.path.splitext(file_path)[1].lower()

    try:
        if file_extension in ['.xls', '.xlsx']:
            # Read Excel file
            df = pd.read_excel(file_path)
            text_content = df.to_csv(index=False, encoding='utf-8', sep=';')
            return executeCloudeModel(text_content, prompt_template, file_path)

        elif file_extension == '.pdf':
            # Read PDF file
            reader = PdfReader(file_path)
            text = ""
            for page in reader.pages:
                text += page.extract_text() + "\n"
            return executeCloudeModel(text, prompt_template, file_path)

        else:
            return f"Unsupported file type: {file_extension}"
    except Exception as e:
        return f"Error processing file: {str(e)}"


def executeCloudeModel(file_data, prompt_template, file_path):
    try:
        messages = [
            {
                "role": "user",
                "content": [
                    {
                        "type": "text",
                        "text": f"{prompt_template}\n\nDatos:\n{file_data}"
                    }
                ]
            }
        ]

        response = client.messages.create(
            model="claude-3-7-sonnet-20250219",
            max_tokens=20000,
            temperature=0,
            system=SYSTEM_PROMPT,
            messages=messages
        )

        # Procesar la respuesta para quitar las comillas triples
        response_text = response.content[0].text
        response_text = response_text.strip()
        if response_text.startswith('```') and response_text.endswith('```'):
            response_text = response_text[3:-3].strip()

        # Obtener el nombre base del archivo
        base_name = Path(file_path).stem
        output_filename = f"{base_name}_resultado.csv"

        return response_text, output_filename

    except Exception as e:
        raise e


if __name__ == "__main__":
    # Ejemplo de uso directo
    try:
        # Ruta del archivo a procesar
        file_path = "SANITARIOS 1.pdf"  # Cambia esto por la ruta real
        prompt = "Procesa los datos y genera un CSV según el formato especificado."

        result = process_file(file_path, prompt)
        print(result)
    except Exception as e:
        print(f"Error: {str(e)}")
