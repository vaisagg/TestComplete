set scriptFolderPath=%~dp0

title CopyFilesInIoT

powershell.exe -ExecutionPolicy Bypass -File %~dp0CopySupplySensorState_IOT.ps1

