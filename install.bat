@echo off
echo Instalando Conversor de Listas de Precios CSV
echo =========================================

REM Verificar si Python está instalado
python --version > nul 2>&1
if errorlevel 1 (
    echo Error: Python no está instalado.
    echo Por favor, instala Python 3.8 o superior desde https://www.python.org/downloads/
    echo Asegúrate de marcar la opción "Add Python to PATH" durante la instalación.
    pause
    exit /b 1
)

REM Verificar si existe requirements.txt
if not exist "%~dp0requirements.txt" (
    echo Error: No se encontró el archivo requirements.txt
    echo Asegúrate de que el archivo esté en el mismo directorio que install.bat
    pause
    exit /b 1
)

REM Verificar si existe el archivo .env
if not exist "%~dp0.env" (
    echo Error: No se encontró el archivo .env
    echo Por favor, crea el archivo .env con el siguiente contenido:
    echo ANTHROPIC_API_KEY=tu_clave_api_aqui
    pause
    exit /b 1
)

REM Eliminar entorno virtual si existe
if exist venv (
    echo Eliminando entorno virtual anterior...
    rmdir /s /q venv
)

REM Crear entorno virtual
echo Creando entorno virtual...
python -m venv venv
if errorlevel 1 (
    echo Error al crear el entorno virtual.
    pause
    exit /b 1
)

REM Activar entorno virtual
echo Activando entorno virtual...
call venv\Scripts\activate.bat

REM Copiar archivo .env al entorno virtual
echo Copiando archivo .env al entorno virtual...
copy "%~dp0.env" "venv\.env" > nul
if errorlevel 1 (
    echo Error al copiar el archivo .env
    pause
    exit /b 1
)

REM Actualizar pip
echo Actualizando pip...
python -m pip install --upgrade pip

REM Instalar dependencias una por una
echo Instalando dependencias...
pip install anthropic==0.7.8
pip install gradio==4.19.2
pip install pandas==2.2.1
pip install python-dotenv==1.0.1
pip install openpyxl==3.1.2
pip install python-docx==1.1.0
pip install PyPDF2==3.0.1

REM Verificar instalación de gradio
python -c "import gradio" 2>nul
if errorlevel 1 (
    echo Error: Gradio no se instaló correctamente.
    echo Intentando reinstalar...
    pip uninstall -y gradio
    pip install gradio==4.19.2
)

REM Crear directorios necesarios
if not exist temp_docs (
    echo Creando directorio para archivos temporales...
    mkdir temp_docs
)

if not exist resultados (
    echo Creando directorio para resultados...
    mkdir resultados
)

echo.
echo Instalación completada exitosamente!
echo.
echo Pasos siguientes:
echo 1. Verifica que tu API key esté correctamente configurada en el archivo .env
echo 2. Ejecuta 'run.bat' para iniciar la aplicación
echo.
pause 