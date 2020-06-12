set scriptFolderPath=%~dp0

powershell.exe -ExecutionPolicy Bypass Set-NetIPsecRule -DisplayName "Cert-Int-CA" -Enabled False