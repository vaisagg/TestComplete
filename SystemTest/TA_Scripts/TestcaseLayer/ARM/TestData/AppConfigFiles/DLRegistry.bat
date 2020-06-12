ECHO on	
	
echo (4) Update Registry	

reg add "HKLM\SOFTWARE\SIEMENS\TRINIDAD" /V ConfigSimulate                   /t REG_DWORD /d 1 /f
reg add "HKLM\SOFTWARE\SIEMENS\TRINIDAD" /V ModuleType                       /t REG_SZ    /d DirectLoad /f
reg add "HKLM\SOFTWARE\SIEMENS\TRINIDAD" /V SampleHandlingHardware         /t REG_SZ /d DirectLoad /f
