# Lanzador de SQL Server y SSMS para Windows

Abre SQL Server Management Studio (SSMS) y, si hace falta, inicia el motor local de SQL Server. Al cerrar la ventana de SSMS que abrió, el lanzador intenta detener el servicio únicamente si su comando de arranque tuvo éxito. Está pensado para una instancia local de prácticas. Usa una sola copia del lanzador a la vez y cierra tus consultas antes de salir.

## 1. Instala SQL Server y SSMS

1. Si ya tienes el motor de SQL Server, pasa al siguiente apartado. Si empiezas desde cero, descarga SQL Server Developer para desarrollo y pruebas, o Express para una instalación ligera. [Descargas de SQL Server](https://www.microsoft.com/sql-server/sql-server-downloads)
2. En el instalador, si eliges una instalación personalizada, selecciona **Database Engine Services**. Anota el nombre de la instancia y agrega tu usuario de Windows como administrador de SQL Server si el asistente te lo ofrece. [Guía de instalación del motor](https://learn.microsoft.com/sql/database-engine/install-windows/install-sql-server-from-the-installation-wizard-setup)
3. Instala SSMS 22 por separado. Ejecuta `vs_SSMS.exe` y elige **Install** en Visual Studio Installer. [Instalación de SSMS](https://learn.microsoft.com/en-us/ssms/install/install)

## 2. Descarga y extrae los archivos

En GitHub, elige **Code → Download ZIP**. Extrae el ZIP en una carpeta local de tu cuenta, por ejemplo `Documentos\LanzadorSQL`. Deja `LanzadorSQL.vbs` y `SSMS.bat` juntos. El primero busca el segundo en su misma carpeta y solicita permisos de administrador mediante UAC.

## 3. Comprueba los valores de SSMS.bat

Abre `SSMS.bat` con el Bloc de notas. Para ver el nombre real del servicio, abre PowerShell y ejecuta:

```powershell
Get-Service -Name 'MSSQLSERVER','MSSQL$*' -ErrorAction SilentlyContinue
```

- Instancia predeterminada. Usa `MSSQLSERVER` como nombre del servicio y `localhost` como nombre del servidor en SSMS.
- Instancia con nombre. Por ejemplo, para `SQLEXPRESS` cambia `SQL_SERVICE` a `MSSQL$SQLEXPRESS` y conéctate a `localhost\SQLEXPRESS`.

El valor predeterminado de `SSMS_EXE` apunta a `C:\Program Files\Microsoft SQL Server Management Studio 22\Release\Common7\IDE\Ssms.exe`. Si tu instalación usa otra ruta, localiza `Ssms.exe` desde las propiedades del acceso directo de SSMS en el menú Inicio y copia la ruta del ejecutable. Conserva la forma `set "SSMS_EXE=ruta completa"` al guardar.

## 4. Abre SSMS y prueba la conexión

1. Haz doble clic en `LanzadorSQL.vbs` y acepta el aviso de UAC.
2. En SSMS, elige **Database Engine**, introduce el nombre del servidor del paso anterior y selecciona **Windows Authentication**.
3. Conéctate y ejecuta `SELECT @@SERVERNAME;` en una consulta nueva. [Conexión y consultas con SSMS](https://learn.microsoft.com/sql/ssms/quickstarts/ssms-connect-query-sql-server)
4. Cierra la ventana que abrió el lanzador. Abre `services.msc` y revisa el estado del servicio. Si ya estaba en ejecución antes de abrir el lanzador, debe seguir activo. Si el lanzador lo inició y pudo detenerlo, aparecerá detenido.

## Si algo falla

- **El lanzador no abre SSMS.** Comprueba que ambos archivos estén juntos y que sus extensiones sean `.vbs` y `.bat`. Revisa `SSMS_EXE`. Para ver los mensajes de diagnóstico, abre **Símbolo del sistema** como administrador y ejecuta `SSMS.bat` desde la carpeta extraída.
- **SSMS abre pero no se conecta.** Revisa el estado del servicio, el nombre de la instancia y si tu usuario tiene acceso al motor.
- **Windows bloquea VBScript.** Si tu equipo lo permite, ejecuta `SSMS.bat` desde una consola de administrador. En un equipo administrado, consulta al responsable de TI si necesitas habilitarlo.

La lógica de apagado se verificó con arranque simulado exitoso y fallido. El ciclo completo con SQL Server y UAC queda para la prueba del paso 4.
