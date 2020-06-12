<#

.SYNOPSIS
This tool is used to remotely push our DML IoT files and settings to the IoT device for ARM\Hydra

.DESCRIPTION
This tool uses Powershell Remoting to push our DML IoT files and Firewall rules to the IoT device for ARM\Hydra.

.EXAMPLE
.\Install-DMLContent.ps1 -contentPath "X:\IoTDrivers_Workspace" -destPath "C:\Data\Users\Win10IOT\IoT_Content"  -username "win10IOT" -password "p@ssw0rd" -ipAddress "192.168.1.100"

#>

param(
  [string] $contentPath = "C:\data\deploy\simulation\AnalyticalDoorStatus.txt",
  [string] $destPath= "C:\Data\Deploy\AnalyticalDoorStatus.txt",
  [string] $destPath1= "C:\Data\AnalyticalDoorStatus.txt",   #samir added#
  [string] $username = "Administrator",
  [string] $password = "p@ssw0rd",
  [ipaddress] $ipAddress = "192.168.1.205",
  [switch] $help
)


#Set-PSDebug -Trace 1

$secstr = New-Object -TypeName System.Security.SecureString
$password.ToCharArray() | ForEach-Object {$secstr.AppendChar($_)}
$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $username, $secstr

$IoTBoard = New-PSSession -ComputerName $ipAddress -Credential $cred

Write-Host "Connecting to the IoT Device..."

Invoke-Command $IotBoard -ScriptBlock {rm C:\Data\AnalyticalDoorStatus.txt} -EA SilentlyContinue     #samir added#

# Copy the IoT files
try {
   Write-Host "Copying ReagentFiles from $contentPath to $destPath on the IoT Device..."
   Copy-Item -Path $contentPath -Destination $destPath1 -Recurse -Force -ToSession $IoTBoard    #samir modified so that we copy file in different location and not in working directly#
   Invoke-Command $IoTBoard -ScriptBlock {Move-Item -Path C:\Data\AnalyticalDoorStatus.txt -Destination C:\Data\Deploy\AnalyticalDoorStatus.txt -Force}   #samir added#

}
catch {
   Write-Error "Failed to copy content to the IoT Device."
   Return 1
}

Write-Host "Successfully copied the files to the IoT Device!" -ForegroundColor Green


# Close out the Powershell Remoting Session
Exit-PSSession
Return 0