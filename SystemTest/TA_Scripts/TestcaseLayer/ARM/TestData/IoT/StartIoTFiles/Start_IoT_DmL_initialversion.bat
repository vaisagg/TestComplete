
set scriptFolderPath=%~dp0

REM setting the tittle of the console window
title StartIoT

powershell.exe -NoExit -ExecutionPolicy Bypass -File %~dp0Start_IoT_DmL.ps1



