# Conversor de Documentos a CSV con IA

Esta herramienta permite convertir archivos PDF y Excel a formato CSV utilizando el modelo Claude 3 Sonnet de Anthropic.

## Requisitos

- Python 3.8 o superior
- Una clave API de Anthropic

## Instalación

1. Clona este repositorio o descarga los archivos

2. Crea un entorno virtual (recomendado):
```bash
python -m venv venv
source venv/bin/activate  # En Linux/Mac
venv\Scripts\activate     # En Windows
```

3. Instala las dependencias:
```bash
pip install -r requirements.txt
```

4. Crea un archivo `.env` en el directorio raíz y añade tu clave API de Anthropic:
```
ANTHROPIC_API_KEY=tu_clave_api_aquí
```

## Uso

1. Ejecuta la aplicación:
```bash
python app.py
```

2. Abre tu navegador web en la dirección que aparece en la consola (generalmente http://localhost:7860)

3. En la interfaz web:
   - Sube tu archivo PDF o Excel
   - Ingresa el prompt template que define cómo se deben procesar los datos
   - Haz clic en "Submit"

4. La herramienta procesará el archivo y generará un archivo `resultado.csv` con la salida

## Formatos soportados

- PDF (.pdf)
- Excel (.xlsx, .xls)

## Notas

- El prompt template debe especificar claramente cómo se deben procesar los datos y el formato esperado del CSV
- El archivo de salida se guardará como `resultado.csv` en el directorio de la aplicación 