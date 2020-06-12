param (
    [switch]$PCM_Shutdown = $false
 )

Write-Host "Shutting down connections to SqlServer"
osql -S "(local)" -b -E -n -i "KillAllConnections.sql" > C:\TrinidadData\KillDBOpenConnectionsErrorLog.txt
switch ($LASTEXITCODE)
  {
  	  1 {
  	  	  Write-Host "Retrying to shutdown connections to SqlServer"
  	  	  osql -S "(local)" -b -E -n -i "KillAllConnections.sql" > C:\TrinidadData\KillDBOpenConnectionsErrorLog.txt 
  	    }
  }

Function EndPSS{Get-PSSession | Remove-PSSession}

Write-Host "Start shutdown of processes"

Stop-Process -ProcessName   TriPlanner                                 -ErrorAction SilentlyContinue -Force
Stop-Process -ProcessName   SampleMoverMediator                        -ErrorAction SilentlyContinue -Force
Stop-Process -ProcessName   TriCCModuleManager                         -ErrorAction SilentlyContinue -Force
Stop-Process -ProcessName   TriCCDeviceManager                         -ErrorAction SilentlyContinue -Force
Stop-Process -ProcessName   Webmonitor                                 -ErrorAction SilentlyContinue -Force
Stop-Process -ProcessName   TriSystemInstrumentManager                 -ErrorAction SilentlyContinue -Force
Stop-Process -ProcessName   NUnitGUI                                   -ErrorAction SilentlyContinue -Force
Stop-Process -ProcessName   TriUserInterface                           -ErrorAction SilentlyContinue -Force
Stop-Process -ProcessName   CanFlash                                   -ErrorAction SilentlyContinue -Force
Stop-Process -ProcessName   WSMControllerApp                           -ErrorAction SilentlyContinue -Force
Stop-Process -ProcessName   DANSrv                                     -ErrorAction SilentlyContinue -Force
Stop-Process -ProcessName   ModbusSvr                                  -ErrorAction SilentlyContinue -Force
Stop-Process -ProcessName   THC_Pid                                    -ErrorAction SilentlyContinue -Force
Stop-Process -ProcessName   ATC                                        -ErrorAction SilentlyContinue -Force
Stop-Process -ProcessName   LvDiagnostics                              -ErrorAction SilentlyContinue -Force
Stop-Process -ProcessName   InstrumentCheck                            -ErrorAction SilentlyContinue -Force
Stop-Process -ProcessName   InstrumentTest                             -ErrorAction SilentlyContinue -Force
Stop-Process -ProcessName   SaveAllImages                              -ErrorAction SilentlyContinue -Force
Stop-Process -ProcessName   FruHistoryManager                          -ErrorAction SilentlyContinue -Force
Stop-Process -ProcessName   DBManager                                  -ErrorAction SilentlyContinue -Force
Stop-Process -ProcessName   CC.Service                                 -ErrorAction SilentlyContinue -Force
Stop-Process -ProcessName   Eventd                                     -ErrorAction SilentlyContinue -Force
Stop-Process -ProcessName   Event                                      -ErrorAction SilentlyContinue -Force
Stop-Process -ProcessName   DMd                                        -ErrorAction SilentlyContinue -Force
Stop-Process -ProcessName   DM                                         -ErrorAction SilentlyContinue -Force
Stop-Process -ProcessName   DBMd                                       -ErrorAction SilentlyContinue -Force
Stop-Process -ProcessName   DBMaintenance                              -ErrorAction SilentlyContinue -Force
Stop-Process -ProcessName   UIW.Reports.ReportsManagerService          -ErrorAction SilentlyContinue -Force
Stop-Process -ProcessName   IMd                                        -ErrorAction SilentlyContinue -Force
Stop-Process -ProcessName   IM                                         -ErrorAction SilentlyContinue -Force
Stop-Process -ProcessName   SIMd                                       -ErrorAction SilentlyContinue -Force
Stop-Process -ProcessName   SIM.Service                                -ErrorAction SilentlyContinue -Force
Stop-Process -ProcessName   DL.Service                                 -ErrorAction SilentlyContinue -Force
Stop-Process -ProcessName   RAMP                                       -ErrorAction SilentlyContinue -Force
Stop-Process -ProcessName   RAMP.Service                               -ErrorAction SilentlyContinue -Force
Stop-Process -ProcessName   UIW.Maintenance.ShellMonitor.Debug         -ErrorAction SilentlyContinue -Force
Stop-Process -ProcessName   Shell                                      -ErrorAction SilentlyContinue -Force
Stop-Process -ProcessName   SampleMoverMediator                        -ErrorAction SilentlyContinue -Force
Stop-Process -ProcessName   TriDLModuleManager                         -ErrorAction SilentlyContinue -Force
Stop-Process -ProcessName   TriModuleDisplay                           -ErrorAction SilentlyContinue -Force
Stop-Process -ProcessName   RTM                                        -ErrorAction SilentlyContinue -Force
Stop-Process -ProcessName   osk                                        -ErrorAction SilentlyContinue -Force
Stop-Process -ProcessName   OnScreenKeyboard                           -ErrorAction SilentlyContinue -Force
Stop-Process -ProcessName   RemoteModuleAccess                         -ErrorAction SilentlyContinue -Force
Stop-Process -ProcessName   SaveAllImages                              -ErrorAction SilentlyContinue -Force
Stop-Process -ProcessName   TOrangeService                             -ErrorAction SilentlyContinue -Force
Stop-Process -ProcessName   ARMConsole		                           -ErrorAction SilentlyContinue -Force
Stop-Process -ProcessName   DLARMConsole	                           -ErrorAction SilentlyContinue -Force
Write-Host "Write the event log"

eventcreate /l system /t information /id 1000 /so "KillAll.bat" /d "Run Kill All"

if ($PCM_Shutdown) 
{
	Write-Host "Shutdown PCM Applications"
	Stop-Process -ProcessName   Controller                                 -ErrorAction SilentlyContinue -Force
	Stop-Process -ProcessName   SH.ModuleManager                           -ErrorAction SilentlyContinue -Force
	Stop-Process -ProcessName   SHE                                        -ErrorAction SilentlyContinue -Force
	Stop-Process -ProcessName   PCM.DrawerVisionSystemWcfServiceConsole    -ErrorAction SilentlyContinue -Force
	Stop-Process -ProcessName   TCSM.ServiceHost                           -ErrorAction SilentlyContinue -Force
	Stop-Process -ProcessName   VMM.ServiceHost                            -ErrorAction SilentlyContinue -Force
	Stop-Process -ProcessName   Planner.ServiceHost                        -ErrorAction SilentlyContinue -Force
	Stop-Process -ProcessName   HLCSimulator                               -ErrorAction SilentlyContinue -Force
	
	Write-Host "About to kill the command line"
	Read-Host "Press Enter to continue"
	Stop-Process -ProcessName   Cmd                                        -ErrorAction SilentlyContinue -Force
	Stop-Process -ProcessName   "powershell"                               -ErrorAction SilentlyContinue -Force

}
else 
{
	Write-Host "Don't shutdown PCM"
}