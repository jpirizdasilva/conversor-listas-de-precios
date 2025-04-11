@echo off
echo Iniciando Conversor de Listas de Precios CSV
echo =========================================

REM Verificar permisos de administrador
net session >nul 2>&1
if %errorLevel% neq 0 (
    echo Error: Este script requiere privilegios de administrador
    echo Por favor, ejecuta el script como administrador
    pause
    exit /b 1
)

REM Verificar acceso a directorios necesarios
dir /a-d . >nul 2>&1
if %errorLevel% neq 0 (
    echo Error: No hay acceso al directorio actual
    pause
    exit /b 1
)

@REM REM Verificar si existe el archivo .env
@REM if not exist .env (
@REM     echo Error: No se encontró el archivo .env
@REM     echo Por favor, crea un archivo .env con tu API key de Anthropic
@REM     echo Formato: ANTHROPIC_API_KEY=tu-api-key-aquí
@REM     pause
@REM     exit /b 1
@REM )

:: Obtener el directorio donde está el script .bat
set "SCRIPT_DIR=%~dp0"

:: Activar el entorno virtual (usando comillas para manejar espacios)
if exist "%SCRIPT_DIR%venv\Scripts\activate.bat" (
    call "%SCRIPT_DIR%venv\Scripts\activate.bat"
) else (
    echo Error: No se pudo activar el entorno virtual
    echo Verifica que el directorio venv existe y tiene los permisos correctos
    pause
    exit /b 1
)

:: Ejecutar la aplicación desde el directorio correcto
python "%SCRIPT_DIR%app.py"

if errorlevel 1 (
    echo Error: No se pudo ejecutar la aplicación
    pause
) else (
    echo Aplicación finalizada correctamente
)

:: Desactivar el entorno virtual
deactivate

pause 