set scriptFolderPath=%~dp0

title CopyFilesInIoT

powershell.exe -ExecutionPolicy Bypass -File %~dp0QBU_PrimaryBarcodes.ps1


PAUSE

