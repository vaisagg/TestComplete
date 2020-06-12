<#

.SYNOPSIS
This tool is used to remotely push our DML IoT files and settings to the IoT device for ARM\Hydra

.DESCRIPTION
This tool uses Powershell Remoting to push our DML IoT files and Firewall rules to the IoT device for ARM\Hydra.

.EXAMPLE
.\Install-DMLContent.ps1 -contentPath "X:\IoTDrivers_Workspace" -destPath "C:\Data\Users\Win10IOT\IoT_Content"  -username "win10IOT" -password "p@ssw0rd" -ipAddress "192.168.1.100"

#>

param(
  
  [string] $contentPath = "C:\data\deploy\simulation\AnalyticalDoorStatus.txt"
  
  )

#verify the file in IOT
$file = "C:\data\deploy\simulation\AnalyticalDoorStatus.txt"
$searchtext = "0 CCAutoLoaderStationDoor"

if (Test-Path $file)
{
    if (Get-Content $file | Select-String $searchtext -Quiet)
    {
       Write-Host "Copied files exists in IoT Device!" -ForegroundColor Green
        #text exists in file
    }
    else
    {
       Write-Host "Copied files does not exists in IoT Device!" -ForegroundColor Red
        #text does not exist in file
    }
}
else
{
    Write-Host "File does not exist in IoT Device!" -ForegroundColor Red
#file does not exist
}

