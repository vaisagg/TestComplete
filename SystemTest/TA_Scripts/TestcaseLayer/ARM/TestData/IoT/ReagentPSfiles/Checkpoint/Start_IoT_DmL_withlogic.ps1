<#

.SYNOPSIS
This tool is used to remotely push our DML IoT files and settings to the IoT device for ARM\Hydra

.DESCRIPTION
This tool uses Powershell Remoting to push our DML IoT files and Firewall rules to the IoT device for ARM\Hydra.

.EXAMPLE
.\Install-DMLContent.ps1 -contentPath "X:\IoTDrivers_Workspace" -destPath "C:\Data\Users\Win10IOT\IoT_Content"  -username "win10IOT" -password "p@ssw0rd" -ipAddress "192.168.1.100"

#>

param(
  
  [string] $destPath= "C:\Data\Deploy",
  [string] $username = "Administrator",
  [string] $password = "p@ssw0rd",
  [ipaddress] $ipAddress = "192.168.1.8",
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
}
catch {
   Write-Error "Failed to execute command."
   Return 1
}

# Start DML process on IoT
try {
   Write-Host "Starting DML proces.."
   # Invoke-Command $IoTBoard -ScriptBlock {& 'C:\data\deploy\StartDML_IoT.exe' | Tee-Object "C:\data\deploy\Log.txt"}
    
# Invoke-Command $IoTBoard -ScriptBlock {& "C:\data\deploy\StartDML_IoT.exe" > c:\data\deploy\log.txt}
   Invoke-Command $IoTBoard -ScriptBlock {Start-Process c:\data\deploy\StartDML_IoT.exe -RedirectStandardOutput C:\data\deploy\log2.txt}
   
   Start-Sleep -s 25


$file="F:\InstrumentOutput\IoTlog.txt"
$searchtest="request failed"
$searchtest1="configuration complete"

$sourcepath= "C:\data\deploy\log3.txt"
$destpath="F:\InstrumentOutput\IoTlog.txt"

Write-Host "Copying the file.."

#Copying logs into another fiile as remote copying doesnt not work if file is open. Running command on IoT board
Invoke-Command $IotBoard -ScriptBlock {Copy-Item c:\data\deploy\log2.txt -Destination c:\data\deploy\log3.txt -Force }

Copy-Item -Path $sourcepath -Destination $destpath -FromSession $IotBoard

if (Test-Path $destpath)

   {
       if (Get-Content $file | Select-String $searchtest -Quiet)
       {   

           Write-Host "request failure string present"
           
           Exit-PSHostProcess
       }
       
       else
       
       {
          Write-Host "request failure string not present"
       
       }
   
   }
   

   else 
   {
        Write-Host "File is not present"
   
   
   }

   if (Test-Path $destpath)
   {

       if (Get-Content $file | Select-String $searchtest1 -Quiet)
       {   

           Write-Host "configuration complete string present"
       
       }
       
       else
       
       {
          Write-Host "configuration complete string not present"
          Exit-PSHostProcess
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
#Return 0