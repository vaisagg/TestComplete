rem  *******************************************************************
rem    This batch file is only for instruments/emulators with installed SW.
rem	Not for use on developer workstations unless the paths below are updated
rem    This is a temp solution until the VMM and Planner directories are
rem	included in the installation (pull or push)
rem  *******************************************************************


title KillAll
call C:\Siemens\Installation\Tools\killall.bat /PCM_Shutdown
REM call c:\Siemens\PCM_Shutdown.bat