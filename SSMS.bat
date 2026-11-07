@echo off
setlocal
set "SQL_SERVICE=MSSQLSERVER"
set "SSMS_EXE=C:\Program Files\Microsoft SQL Server Management Studio 22\Release\Common7\IDE\Ssms.exe"

if not exist "%SSMS_EXE%" (
    echo No se encontro Ssms.exe. Revisa la ruta SSMS_EXE.
    exit /b 1
)

echo Iniciando el motor de SQL Server...
set "SQL_STARTED="
net start "%SQL_SERVICE%" && set "SQL_STARTED=1"

echo Abriendo SQL Server Management Studio...
start /wait "" "%SSMS_EXE%"

if defined SQL_STARTED (
    echo Apagando el motor de SQL Server...
    net stop "%SQL_SERVICE%"
)
