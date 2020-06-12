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
  [ipaddress] $ipAddress = "192.168.1.205",
  [switch] $help
)


#Set-PSDebug -Trace 1



$secstr = New-Object -TypeName System.Security.SecureString
$password.ToCharArray() | ForEach-Object {$secstr.AppendChar($_)}
$cred = new-object -typename System.Management.Automation.PSCredential -argumentlist $username, $secstr
$path = "C:\data\deploy\"

$IotBoard1 = New-PSSession -ComputerName $ipAddress -Credential $cred

Write-Host "Connecting to the IoT Device..."

# Stop any running DML process on IoT


# Start DML process on IoT
try {
 
   

   Write-Host "Waiting till configuration download is complete"
  


$file="F:\InstrumentOutput\startIotlogs1.txt"
$cnvrt_file="F:\InstrumentOutput\startIotlogs.txt"
$searchtest="Configuration complete"

$sourcepath= "C:\data\startIotlogs.txt"
$destpath="F:\InstrumentOutput\startIotlogs1.txt"
rm $file -EA SilentlyContinue
rm $cnvrt_file -EA SilentlyContinue


Write-Host "Copying the file.."

#Copying logs into another file as remote copying doesnt not work if file is open. Running command on IoT board
Invoke-Command $IotBoard1 -ScriptBlock {Copy-Item c:\data\deploy\startIot.txt -Destination c:\data\startIotlogs.txt -Force}

Copy-Item -Path $sourcepath -Destination $destpath -FromSession $IotBoard1

# File conversion into ascii format so that test complete can read the contents.
Get-Content $file |  Set-Content -Encoding ascii $cnvrt_file

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
Exit-PSSession
Return 0