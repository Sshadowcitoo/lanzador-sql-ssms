Option Explicit

Dim folder, shell
folder = CreateObject("Scripting.FileSystemObject").GetParentFolderName(WScript.ScriptFullName)

Set shell = CreateObject("Shell.Application")
shell.ShellExecute "cmd.exe", "/d /c .\SSMS.bat", folder, "runas", 0
