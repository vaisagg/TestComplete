
title UninstallDiagnostics
set scriptFolderPath=%~dp0

powershell.exe -ExecutionPolicy Bypass -File %~dp0UninstallDiagnostics.ps1

pause