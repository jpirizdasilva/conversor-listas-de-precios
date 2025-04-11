@echo off
echo Limpiando instalación anterior...
echo =========================================

REM Desactivar entorno virtual si está activo
if defined VIRTUAL_ENV (
    call deactivate
)

REM Eliminar carpeta venv
if exist venv (
    echo Eliminando entorno virtual anterior...
    rmdir /s /q venv
)

