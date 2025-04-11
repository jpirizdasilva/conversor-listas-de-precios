@echo off
echo Limpiando instalación anterior...
echo =========================================

REM Desactivar entorno virtual si está activo
if defined VIRTUAL_ENV (
    echo Desactivando entorno virtual...
    call venv\Scripts\deactivate.bat
)

REM Esperar un momento para asegurar que se desactivó
timeout /t 2 /nobreak > nul

REM Eliminar carpeta venv
if exist venv (
    echo Eliminando entorno virtual anterior...
    rmdir /s /q venv
)

REM Eliminar archivos temporales
if exist temp_docs (
    echo Eliminando archivos temporales...
    rmdir /s /q temp_docs
)

REM Eliminar archivos de caché de Python
if exist __pycache__ (
    echo Eliminando archivos de caché...
    rmdir /s /q __pycache__
)

REM Eliminar archivo de log si existe
if exist app.log (
    echo Eliminando archivo de log...
    del app.log
)

echo.
echo Limpieza completada. Ahora ejecuta install.bat para reinstalar todo.
echo.
pause 