set scriptFolderPath=%~dp0


title CopyFilesInIoT

powershell.exe -ExecutionPolicy Bypass -File %~dp0Copyfilesin_IOT.ps1

sqlcmd -S %computername% -d MM -E -i %~dp0Reagent_Import.sql
pause
