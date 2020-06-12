
set scriptFolderPath=%~dp0

REM setting the tittle of the console window
title StopIoTProcess

powershell.exe -ExecutionPolicy Bypass -File %~dp0StopIoTProcess.ps1



