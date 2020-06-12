#=============================================================================  
#
# FILE:        TestExecutionDriver.ps1
# COMPANY:     Siemens  
# VERSION:     0.01  
# DESCRIPTION: Invokes different workflow scripts for automated test execution
#=============================================================================

##########################################################################
### Step 1: Check test execute already installed else trigger new installation
### Step 2: Connect to License Server and trigger test execution
########################################################################## 

param([String]$TestResultFolder)

function WriteLogEx($Message)
{
    $LogFile = $TestResultFolder + "\TestExecLog.log"
    $CurrentDateTime = Get-Date -UFormat "%Y%m%d %H:%M:%S"
    $CurrentDateTime + "  " + $Message | Out-File $LogFile -Append 
}

function CreateResutFileEx($Result)
{ 
    $Result | Out-File $global:ResultOverviewFile
    "Check logs at: $TestResultFolder" | Out-File $global:ResultOverviewFile -Append 
}

##########################################################################
### Check availability of Installable 
## and trigger Test Framework Installation
########################################################################## 
function InstallTestFramework($Installable, $InstallationPath)
{
    WriteLogEx "INFO -> Installing Test Framework"
    Try 
    { 
        if(Test-Path $Installable)
        {
            $Argument = '/z"-silentmode-NoSamples-NoIntegr-NoWeb-NoMobile-Path:' + $InstallationPath + '"'

            $process = Start-Process `
                -file  $Installable `
                 -arg $Argument `
                   -Verb runAs `
                    -passthru 

            $process.WaitForExit()
            if($process.ExitCode -ne 0)
            {
                WriteLogEx "ERROR -> Installation of Test Framework Failed."
                return $false      
            } 
            else
            {
                WriteLogEx "INFO -> Test Framework Installation Sucessful" 
            }
        }
        else 
        {
            WriteLogEx "ERROR -> Test Framework Installable not available"
            return $false  
        }
    }
    catch
    {
        $myLogInfo = "Exception occured : $_
    					  $($_.InvocationInfo.ScriptName)($($_.InvocationInfo.ScriptLineNumber)): $($_.InvocationInfo.Line)"   
        WriteLogEx "ERROR -> $myLogInfo"                     
        return $false  
    }
}


function EnableTestFrameworkRemoting()
{
    try
    {
        netsh advfirewall firewall delete rule name="Enable TestCompleteService12"
        #netsh advfirewall firewall add rule name="Enable TestCompleteService12" dir=in program="C:\Program Files (x86)\SmartBear\TestComplete 12\Bin\TestCompleteService12.exe" remoteip=localsubnet action=allow 
        netsh advfirewall firewall add rule name="Enable TestCompleteService12" dir=in action=allow program="C:\Program Files (x86)\SmartBear\TestExecute 12\Bin\TestCompleteService12.exe" enable=yes
        return $true 
    }
    catch
    {
        $myLogInfo = "Exception occured : $_
    					  $($_.InvocationInfo.ScriptName)($($_.InvocationInfo.ScriptLineNumber)): $($_.InvocationInfo.Line)"   
        WriteLogEx "ERROR -> $myLogInfo"                     
        return $false  
    }
}


Try 
{
    $TestExecEnv = 'F:\SystemTest\CI_Scripts\CI_Scripts\Config\TestExecEnv.xml'
    if(-Not(Test-Path $TestExecEnv))
    {
        # WriteLog  "ERROR -> Test execution config file (F:\Installer\Files\CI_Scripts\Config\TestExecEnv.xml) does not exist!, Exiting..."
        return $false 
    }
    $xmlConfigNode = [xml](get-content -Path $TestExecEnv)
    $NodeInfo = $xmlConfigNode.TestFramework.TestExecute
    $global:ResultOverviewFile = $NodeInfo.ResultOverviewFile
    ##############################################
    ## Create New ResultFolder for test execution
    ##############################################
    new-item -path $TestResultFolder -ItemType directory -Force
    
             
    ##########################################################################
    # Check test execute already installed else trigger new installation
    ########################################################################## 


    WriteLogEx  "INFO -> Checking existance of Test Framework Installation"
    $TestFrameworkExecutable = $NodeInfo.Executable
    if(Test-Path $TestFrameworkExecutable)
    {
        WriteLogEx  "INFO -> Test Framework Installation exists"
    }
    else 
    {
        WriteLogEx  "INFO -> Starting Test Framework Installation"
        $retValue = InstallTestFramework $NodeInfo.Installable $NodeInfo.InstallationPath
       
        if($retValue -eq $false)
        {
            WriteLogEx  "ERROR -> Test Framework Installation Failed!, Exiting..."
            CreateResutFileEx "FAIL" 
            return $false 
        }
    }

    ##########################################################################
    # Connect to License Server and trigger test execution
    ##########################################################################
    WriteLogEx  "INFO -> Connecting to License Server"
    $LicenseFile = $NodeInfo.LicenseFile
    $TargetLocation = $NodeInfo.LicenseTarget
    $TestSelector = $NodeInfo.TestSelector
    $Executable = $NodeInfo.Executable

    if(Test-Path $LicenseFile)
    {
        Copy-Item $LicenseFile $TargetLocation
        WriteLogEx  "INFO -> Successfully Connected to License Server"
    }
    else 
    {
        WriteLogEx "ERROR -> Test Framework License file doesn't exist!, Exiting..."
        CreateResutFileEx "FAIL" 
        return $false 
    }

    WriteLogEx  "INFO -> Enabling Test Framework Remoting"
    $retValue = EnableTestFrameworkRemoting
    if($retValue -eq $true)
    {
        WriteLogEx  "INFO -> Enabling Test Framework Remoting - Sucessful"
        CreateResutFileEx "PASS" 
        return $true 
    }
    else
    {
        WriteLogEx  "ERROR -> Enabling test framework remoting Failed!, Exiting..."
        CreateResutFileEx "FAIL" 
        return $false 
    }
}
catch
{
    $myLogInfo = "Exception occured : $_
					  $($_.InvocationInfo.ScriptName)($($_.InvocationInfo.ScriptLineNumber)): $($_.InvocationInfo.Line)"   
    WriteLogEx "ERROR -> $myLogInfo"
    WriteLogEx "ERROR -> Test execution aborted!"
    CreateResutFileEx "FAIL" 
    return $false  
}