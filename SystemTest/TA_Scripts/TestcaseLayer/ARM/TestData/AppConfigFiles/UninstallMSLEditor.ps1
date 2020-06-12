
<#

.SYNOPSIS
This tool is used to uninstall MSL Editor for ARM\Hydra

.DESCRIPTION
This tool uses Powershell to uninstall MSL Editor for ARM\Hydra.

.EXAMPLE
.\UninstallMSLEditor.ps1 -contentPath "X:\IoTDrivers_Workspace" -destPath "C:\Data\Users\Win10IOT\IoT_Content"  -username "win10IOT" -password "p@ssw0rd" -ipAddress "192.168.1.100"

#>

try 
{
Get-AppxPackage ‘MSLEditor’  | Remove-AppxPackage
Write-Host "Successfully Uninstalled MSL Editor!" -ForegroundColor Green

}

catch
{
  Write-Error "MSL Editor Uninstalltion failed or Editor does not exit!" -ForegroundColor Green

}

Exit

