<#

.SYNOPSIS
This tool is used to remotely push our DML IoT files and settings to the IoT device for ARM\Hydra

.DESCRIPTION
This tool uses Powershell Remoting to push our DML IoT files and Firewall rules to the IoT device for ARM\Hydra.

.EXAMPLE
.\Install-DMLContent.ps1 -contentPath "X:\IoTDrivers_Workspace" -destPath "C:\Data\Users\Win10IOT\IoT_Content"  -username "win10IOT" -password "p@ssw0rd" -ipAddress "192.168.1.100"

#>

param(
  [string] $contentPath1 = "F:\SystemTest\TA_Scripts\TestcaseLayer\ARM\TestData\AppConfigFiles\ReagentLoadQuery\AncillaryBarcodes.txt",
  [string] $contentPath2 = "F:\SystemTest\TA_Scripts\TestcaseLayer\ARM\TestData\AppConfigFiles\ReagentLoadQuery\CHInputBarcodes.txt",
  [string] $contentPath3 = "F:\SystemTest\TA_Scripts\TestcaseLayer\ARM\TestData\AppConfigFiles\ReagentLoadQuery\PrimaryBarcodes.txt",
  [string] $destPath1= "C:\Data\Deploy\AncillaryBarcodes.txt",
  [string] $destPath2= "C:\Data\Deploy\CHInputBarcodes.txt",   #samir added#
  [string] $destPath3= "C:\Data\Deploy\PrimaryBarcodes.txt", 
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

Invoke-Command $IotBoard -ScriptBlock {rm C:\Data\Deploy\AncillaryBarcodes.txt} -EA SilentlyContinue     #samir added#
Invoke-Command $IotBoard -ScriptBlock {rm C:\Data\Deploy\CHInputBarcodes.txt} -EA SilentlyContinue
Invoke-Command $IotBoard -ScriptBlock {rm C:\Data\Deploy\PrimaryBarcodes.txt} -EA SilentlyContinue
# Copy the IoT files
try {
   Write-Host "Copying ReagentFiles from $contentPath to $destPath on the IoT Device..."
   Copy-Item -Path $contentPath1 -Destination $destPath1 -Recurse -Force -ToSession $IoTBoard    #samir modified so that we copy file in different location and not in working directly#
   Copy-Item -Path $contentPath2 -Destination $destPath2 -Recurse -Force -ToSession $IoTBoard
   Copy-Item -Path $contentPath3 -Destination $destPath3 -Recurse -Force -ToSession $IoTBoard
}
catch {
   Write-Error "Failed to copy content to the IoT Device."
   Return 1
}

Write-Host "Successfully copied the files to the IoT Device!" -ForegroundColor Green


# Close out the Powershell Remoting Session
Exit-PSSession
Return 0