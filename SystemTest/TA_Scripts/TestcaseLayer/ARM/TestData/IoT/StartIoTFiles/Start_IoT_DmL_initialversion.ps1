<#

.SYNOPSIS
This tool is used to remotely push our DML IoT files and settings to the IoT device for ARM\Hydra

.DESCRIPTION
This tool uses Powershell Remoting to push our DML IoT files and Firewall rules to the IoT device for ARM\Hydra.

.EXAMPLE
.\Install-DMLContent.ps1 -contentPath "X:\IoTDrivers_Workspace" -destPath "C:\Data\Users\Win10IOT\IoT_Content"  -username "win10IOT" -password "p@ssw0rd" -ipAddress "192.168.1.100"

#>

param(
  [string] $contentPath = "C:\Siemens\ARM\Bin\Configuration\Simulator\MechanismEmulationConfig.txt",
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
try {
   Write-Host "Stopping any previous DML process.."
   Invoke-Command $IoTBoard -ScriptBlock {Get-Process "StartDML_IoT" | Stop-Process -Force} -EA SilentlyContinue
   Write-Host "Successfully Stopped the DML process IoT Device!" -ForegroundColor Green 
   Invoke-Command $IoTBoard -ScriptBlock {rm C:\data\deploy\startIot.txt} -EA SilentlyContinue
   Invoke-Command $IoTBoard -ScriptBlock {rm C:\data\deploy\startIotlogs.txt} -EA SilentlyContinue
   Invoke-Command $IoTBoard -ScriptBlock {rm C:\data\deploy\MechanismEmulationConfig.txt} -EA SilentlyContinue
}
catch {
   Write-Error "Failed to execute command."
   Return 1
}

# Start DML process on IoT
try {
 
   Write-Host "Copying MechanismEmulationConfig file from $contentPath to $destPath on the IoT Device..."
   Copy-Item -Path $contentPath -Destination $destPath -Recurse -Force -ToSession $IoTBoard


   Write-Host "Starting DML process.."
   # Invoke-Command $IoTBoard -ScriptBlock {& 'C:\data\deploy\StartDML_IoT.exe' | Tee-Object "C:\data\deploy\Log.txt"}
    
# Invoke-Command $IoTBoard -ScriptBlock {& "C:\data\deploy\StartDML_IoT.exe" > c:\data\deploy\log.txt}
  Invoke-Command $IoTBoard -ScriptBlock {Start-Process c:\data\deploy\StartDML_IoT.exe -RedirectStandardOutput C:\data\deploy\startIot.txt }
   

   Write-Host "Waiting till configurations are downloaded"
   Start-Sleep -s 90


$file="F:\InstrumentOutput\startIotlogs.txt"
$searchtest="Configuration complete"

$sourcepath= "C:\data\deploy\startIotlogs.txt"
$destpath="F:\InstrumentOutput\startIotlogs.txt"
rm $file -EA SilentlyContinue

Write-Host "Copying the file.."

#Copying logs into another file as remote copying doesnt not work if file is open. Running command on IoT board
Invoke-Command $IotBoard -ScriptBlock {Copy-Item c:\data\deploy\startIot.txt -Destination c:\data\deploy\startIotlogs.txt -Force }

Copy-Item -Path $sourcepath -Destination $destpath -FromSession $IotBoard

if (Test-Path $destpath)

   {
       if (Get-Content $file | Select-String $searchtest -Quiet)
       {   

           Write-Host "string present"
       
       }
       
       else
       
       {
          Write-Host "string not present"
       
       }
   
   }
   

   else 
   {
        Write-Host "File is not present"
   
   
   }

 #Exit-PSHostProcess


}
catch {
   Write-Error "Failed to start DML process."
   Return 1
}

Write-Host "Successfully Started the DML process IoT Device!" -ForegroundColor Green



# Close out the Powershell Remoting Session
# Exit-PSSession 

