#=============================================================================  
#
# FILE:        InstallTestFramework.ps1
# COMPANY:     Siemens  
# VERSION:     0.01  
# DESCRIPTION: Installs test framework 
#=============================================================================

function ExecuteTests()
{
    Try 
    {
        WriteLog "INFO -> Start execution of Test Scripts"

        $TestSelectorFile = $global:ConfigNodeInfo.TestSelector
        $TestExec = $global:ConfigNodeInfo.Executable

        WriteLog "INFO -> Checking existance of Test Selector file"
        if(-Not(Test-Path $TestSelectorFile))
        {
            WriteLog "ERROR -> Test selector file not available; exiting!"
            return $false  
        }


        $TestExecCmd = '"' + $TestExec + '"'
        $ConfiguredTests = [xml](get-content -Path $TestSelectorFile)
        foreach( $NodeInfo in $ConfiguredTests.Tests.Test)
        {
            
            $Project = $NodeInfo.ProjectName
	        $UnitName = $NodeInfo.UnitName
	        $TestName=$NodeInfo.TestName
            
            if($NodeInfo.UnitName -ne 'NA')
            {
                $TCResultFile = $global:TCResultPath + "\" + $NodeInfo.TestName + ".MHT"
                $TCErrorLogFile = $global:TCResultPath + "\" + $NodeInfo.TestName + ".log"
                $TestExecArgument = '"' + $NodeInfo.TestSource + '"' + ' /r /p:' + $Project + ' /t:"Script|'+ $UnitName +'|'+ $TestName +'" /e /ExportLog:' + $TCResultFile + ' /SilentMode /ErrorLog:' + $TCErrorLogFile + ' /Timeout:' + $NodeInfo.Timeout
            }
            else
            {
                $TCResultFile = $global:TCResultPath + "\" + $NodeInfo.ProjectName + ".MHT"
                $TCErrorLogFile = $global:TCResultPath + "\" + $NodeInfo.ProjectName + ".log"
                $TestExecArgument = '"' + $NodeInfo.TestSource + '"' + ' /r /p:' + $Project + ' /e /ExportLog:' + $TCResultFile + ' /SilentMode /ErrorLog:' + $TCErrorLogFile + ' /Timeout:' + $NodeInfo.Timeout
            }

            #$TestExecArgument = '"' + $NodeInfo.TestSource + '"' + ' /r /p:' + $Project + ' /u:'+ $UnitName +' /rt:'+ $TestName +' /e /ExportLog:' + $TCResultFile + ' /SilentMode /ErrorLog:' + $TCErrorLogFile + ' /Timeout:' + $NodeInfo.Timeout
            #$TestExecArgument = '"' + $NodeInfo.TestSource + '"' + ' /r /p:' + $Project + ' /t:"Script|'+ $UnitName +'|'+ $TestName +'" /e /ExportLog:' + $TCResultFile + ' /SilentMode /ErrorLog:' + $TCErrorLogFile + ' /Timeout:' + $NodeInfo.Timeout
            $myLogInfo = "INFO -> " + $TestExecArgument
            WriteLog $myLogInfo

            $TestExecProcess = Start-Process `
                        -file  $TestExecCmd `
                         -arg $TestExecArgument `
                            -Verb runAs `
                            -passthru
        
                        
            $TestExecProcess.WaitForExit()

            if($TestExecProcess.ExitCode -ne 0)
            {
                $myLogInfo = "INFO -> Error in executing test " + $NodeInfo.TestSource
                WriteLog $myLogInfo
                return $false
            } 
            $myLogInfo = "INFO -> Test execution sucessful for test " + $NodeInfo.TestSource 
            WriteLog $myLogInfo
        }

        WriteLog "INFO -> Test Scripts execution completed"
        return $true
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

}


    
function DeployTestTargets()
{
    WriteLog "DeployTestTargets - Start"
    Try 
    {
        [string[]]$NodeTypes = "SH", "CH", "IM"
        foreach($Node in $NodeTypes )  
        {
            $retValue = ExecuteScript $Node "DeployTestTargets"
            if($retValue -eq $false)
            {
                WriteLog  "ERROR -> DeployTestTargets on $Node Failed!, Exiting..."
                return $false 
            }
        }
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

function StageTestComplete()
{
    Try 
    {
        [string[]]$NodeTypes = "SH", "CH", "IM"
        foreach($Node in $NodeTypes )  
        {
            WriteLog "StageTestComplete on $Node  Started"
            $retValue = ExecuteScript $Node "StageTestComplete"
            if($retValue -eq $false)
            {
                WriteLog  "ERROR -> StageTestComplete on $Node Failed!, Exiting..."
                return $false 
            }
        }
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

function SyncNodes()
{
    WriteLog "SyncNodes - Start"
    Try 
    {
        [string[]]$NodeTypes = "SH", "CH", "IM", "PCC"
        foreach($Node in $NodeTypes )  
        {
            $retValue = ExecuteScript $Node "SyncNodes"
            if($retValue -eq $false)
            {
                WriteLog  "ERROR -> SyncNodes on $Node Failed!, Exiting..."
                return $false 
            }
        }
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

function ExportTestResults()
{
}

function ExecuteScript($InstrumentType, $Operation)
{
    Try 
    {
        foreach( $InstrumentInfo in $global:DeploymentNodeInfo)
        {
            if($InstrumentInfo.TYPE -eq $InstrumentType)
            {
               if($Operation -eq "DeployTestTargets")
               {
                    [string[]]$FoldersToBeCopied = "\CI_Scripts", "\TA_Scripts"
                    foreach($Folder in $FoldersToBeCopied)  
                    {
                    
                        $SourceFolder = $global:ConfigNodeInfo.TestTargetsPath + $Folder
                        $TargetFolder = "\\" + $InstrumentInfo.IP + "\" + $global:ConfigNodeInfo.TestTargetsPath + $Folder
                        $TargetFolder = $TargetFolder -replace ':', '$'
                        CopyDiretory $SourceFolder $TargetFolder $false
                    } 
                    return $true
               }
               if($Operation -eq "StageTestComplete")
               {
                    $TaskName = "StageTestComplete"
                    $UserName = "Siemensserviceuser"
                    $UserPWD = "Siemens1234567!"
                
                    $TestFrameworkInstaller = $global:ConfigNodeInfo.TestFrameworkInstaller
                    $TaskPath = "$TestFrameworkInstaller -TestResultFolder $global:TCResultPath"
                    $TaskTime = ([datetime]::Now).AddMinutes(2);
                    $Time = $TaskTime.ToString("HH:mm:ss");
                    if (schtasks.exe /Query /S $InstrumentInfo.IP /U $UserName /P $UserPWD /TN $TaskName)
                    {
                        schtasks.exe /Delete /S $InstrumentInfo.IP /U $UserName /P $UserPWD /TN $TaskName /F
                    }
                    schtasks.exe /create /S $InstrumentInfo.IP /U $UserName /P $UserPWD /TN $TaskName /ST $Time /SC ONCE /TR "powershell.exe -windowstyle hidden -file $TaskPath"

                    return $true
               }
               if($Operation -eq "SyncNodes")
               {
                    $ResultFilePath = $global:ConfigNodeInfo.ResultOverviewFile
                    #If not file exist return true
                    # else check PASS/FAIL
                    # Fail retrun false else true
               }
            }
        }
     }
    catch [Exception] 
    {
        $myLogInfo = "Exception occured : $_
					  $($_.InvocationInfo.ScriptName)($($_.InvocationInfo.ScriptLineNumber)): $($_.InvocationInfo.Line)"
		WriteLog "ERROR -> $myLogInfo"   
        return $false  
    }   
}