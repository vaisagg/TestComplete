set scriptFolderPath=%~dp0

title CopyFilesInIoT

powershell.exe -ExecutionPolicy Bypass -File %~dp0CopySensorFile_IOT.ps1

