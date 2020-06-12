<#

.SYNOPSIS
This tool is used to stop DML process on IoT device for ARM\Hydra

.DESCRIPTION
This tool uses Powershell Remoting to stop DML process on IoT device for ARM\Hydra

.EXAMPLE
.\Install-DMLContent.ps1 -contentPath "X:\IoTDrivers_Workspace" -destPath "C:\Data\Users\Win10IOT\IoT_Content"  -username "win10IOT" -password "p@ssw0rd" -ipAddress "192.168.1.100"

#>

param(
  [string] $contentPath = "C:\Siemens\ARM\Bin\IoT_Content\Deploy\MechanismEmulationConfig.txt",
  [string] $destPath= "C:\Data\Deploy",
  [string] $username = "Administrator",
  [string] $password = "p@ssw0rd",
  [ipaddress] $ipAddress = "192.168.1.205",
  [switch] $help
)


#Set-PSDebug -Trace 1



$secstr = New-Object -TypeName System.Security.SecureString
$password.ToCharArray() | ForEach-Object {$secstr.AppendChar($_)}
$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $username, $secstr
$path = "C:\data\deploy\"

$IoTBoard = New-PSSession -ComputerName $ipAddress -Credential $cred

Write-Host "Connecting to the IoT Device..."


# Stop any running DML process on IoT
try 
{
   Write-Host "Stopping any previous DML process.."
   Invoke-Command $IoTBoard -ScriptBlock {Get-Process "StartDML_IoT" | Stop-Process -Force} -EA SilentlyContinue
   Write-Host "Successfully Stopped the DML process IoT Device!" -ForegroundColor Green 
   }
catch 
{
   Write-Error "Failed to execute command."
   Return 1
}

Write-Host "Successfully Stopped the DML process IoT Device!" -ForegroundColor Green



# Close out the Powershell Remoting Session
Exit-PSSession 

