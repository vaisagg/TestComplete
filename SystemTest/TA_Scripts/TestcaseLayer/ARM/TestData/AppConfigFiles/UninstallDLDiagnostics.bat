
title UninstallDLDiagnostics
set scriptFolderPath=%~dp0

powershell.exe -ExecutionPolicy Bypass -File %~dp0UninstallDLDiagnostics.ps1
pause