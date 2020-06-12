
<#

.SYNOPSIS
This tool is used to remotely push our DML IoT files and settings to the IoT device for ARM\Hydra

.DESCRIPTION
This tool uses Powershell Remoting to push our DML IoT files and Firewall rules to the IoT device for ARM\Hydra.

.EXAMPLE
.\Install-DMLContent.ps1 -contentPath "X:\IoTDrivers_Workspace" -destPath "C:\Data\Users\Win10IOT\IoT_Content"  -username "win10IOT" -password "p@ssw0rd" -ipAddress "192.168.1.100"

#>

try 
{
Get-AppxPackage ‘DiagnosticsClient’  | Remove-AppxPackage
Write-Host "Successfully Uninstalled Diagnostics Client!" -ForegroundColor Green

}

catch
{
  Write-Error "Diagnostics Client Uninstalltion failed or Client does not exit!" -ForegroundColor Green

}

Exit

