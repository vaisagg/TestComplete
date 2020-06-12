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

function IncludeScript($FileName)
{ 
    $Invocation = (Get-Variable MyInvocation -Scope 1).Value 
    return Join-Path (Split-Path $Invocation.MyCommand.Path) $FileName -resolve
} 

.(IncludeScript ".\CommonUtils.ps1")
.(IncludeScript ".\TestFrameworkLib.ps1")

function Initialize()
{
    Try 
    {
        ################################################################
        ## Check existance of TestExecEnv.xml file and load reqd params
        ################################################################
 #tbd       $TestExecEnv = IncludeScript ".\Config\TestExecEnv.xml"
        $TestExecEnv = 'F:\SystemTest\CI_Scripts\Config\TestExecEnv.xml'
        if(-Not(Test-Path $TestExecEnv))
        {
            # WriteLog  "ERROR -> Test execution config file (F:\Installer\Files\CI_Scripts\Config\TestExecEnv.xml) does not exist!, Exiting..."
            return $false 
        }
        $xmlConfigNode = [xml](get-content -Path $TestExecEnv)
        $global:ConfigNodeInfo = $xmlConfigNode.TestFramework.TestExecute

        ##############################################
        ## Create New ResultFolder for test execution
        ##############################################
        $CurrentDateTime = Get-Date -UFormat "%Y%m%d_%H%M"
        $TestResultFolder = "TestRun_" + $CurrentDateTime 
        new-item -path $global:ConfigNodeInfo.TestResults -name $TestResultFolder -type "directory"
        $global:TCResultPath = $global:ConfigNodeInfo.TestResults + "\" + $TestResultFolder 
        $global:ResultOverviewFile = $global:ConfigNodeInfo.ResultOverviewFile
        WriteLog "New log directory created $global:TCResultPath"
        
        ################################################################
        ## Check existance of BuildInstrumentsInfo.xml file and load reqd params
        ################################################################
        $DeploymentInfo = $global:ConfigNodeInfo.DeploymentInfoFile
        if(-Not(Test-Path $DeploymentInfo))
        {
            WriteLog  "ERROR -> Deployment Info file (F:\Installer\Files\BuildInstrumentsInfo.xml) does not exist!, Exiting..."
            return $false 
        }
        $xmlDeploymentNodeInfo = [xml](get-content -Path $DeploymentInfo)
        $global:DeploymentNodeInfo = $xmlDeploymentNodeInfo.InstrumentsInfo.Instruments.Instrument
        
        # ExecutionMode kept for supporting deployments outside CI in future 
        $global:ExecutionMode = "CI"
        WriteLog "Initialize Sucessful"
        return $true
    }
    catch [Exception] 
    {
        $myLogInfo = "Exception occured : $_
					  $($_.InvocationInfo.ScriptName)($($_.InvocationInfo.ScriptLineNumber)): $($_.InvocationInfo.Line)"
		WriteLog "ERROR -> $myLogInfo"   
        return $false  
    }
}

Try 
{
    $retValue = Initialize
    if($retValue -eq $false)
    {
        WriteLog  "ERROR -> Initialize Failed!, Exiting..."
        CreateResutFile "FAIL" 
        return $false 
    }
    
    $retValue = DeployTestTargets
    if($retValue -eq $false)
    {
        WriteLog  "ERROR -> DeployTestTargets Failed!, Exiting..."
        CreateResutFile "FAIL" 
        return $false 
    } 
      
     
    $retValue = StageTestComplete
    if($retValue -eq $false)
    {
        WriteLog  "ERROR -> StageTestComplete Failed!, Exiting..."
        CreateResutFile "FAIL" 
        return $false 
    }  

    # StageTestComplete on PCC Node
    $TestFrameworkInstaller = $global:ConfigNodeInfo.TestFrameworkInstaller
    $TaskPath = "$TestFrameworkInstaller -TestResultFolder $global:TCResultPath"
    Invoke-Expression $TaskPath 
     
   <#
    $retValue = SyncNodes
    if($retValue -eq $false)
    {
        WriteLog  "ERROR -> SyncNodes Failed!, Exiting..."
        CreateResutFile "FAIL" 
        return $false 
    } 
    #>
    $retValue = ExecuteTests
    if($retValue -eq $false)
    {
        WriteLog  "ERROR -> ExecuteTests Failed!, Exiting..."
        CreateResutFile "FAIL" 
        return $false 
    }  
    <#
    $retValue = ExportTestResults
    if($retValue -eq $false)
    {
        WriteLog  "ERROR -> ExportTestResults Failed!, Exiting..."
        CreateResutFile "FAIL" 
        return $false 
    }      
    #> 
    
    CreateResutFile "PASS"
}
catch
{
    $myLogInfo = "Exception occured : $_
					  $($_.InvocationInfo.ScriptName)($($_.InvocationInfo.ScriptLineNumber)): $($_.InvocationInfo.Line)"   
    WriteLog "ERROR -> $myLogInfo"
    WriteLog "ERROR -> Test execution aborted!"
    CreateResutFile "FAIL" 
    return $false  
}