#=============================================================================  
#
# FILE:        ExecuteConfiguredTests.ps1
# COMPANY:     Siemens  
# VERSION:     0.01  
# DESCRIPTION: Executes tests specifed in TestSelector
#=============================================================================

##########################################################################
### Check availability of TestSelector.xml 
## and trigger execution of configured tests
########################################################################## 


function CreateResutFile($Result)
{ 
#tbd   $Result | Out-File $global:ConfigNodeInfo.ResultOverviewFile
    $Result | Out-File 'F:\SystemTest\TestOutput\SmokeComplete.txt'
    "Logs: $global:TCResultPath" | Out-File 'F:\SystemTest\TestOutput\SmokeComplete.txt' -Append 
}

function WriteLog($Message)
{
    $LogFile = $global:TCResultPath + ".\TestExecLog.log"
    $CurrentDateTime = Get-Date -UFormat "%Y%m%d %H:%M:%S"
    $CurrentDateTime + "  " + $Message | Out-File $LogFile -Append 
}

function CopyDiretory([string] $SourceFolder,[string] $TargetFolder,[bool] $OverWrite)
{
    WriteLog "Copy the files & folder from location $SourceFolder to target location $TargetFolder "
    Try 
    {
        $LogPath = $global:TCResultPath + "\TestExecLog.log"
        if(($OverWrite -eq $true) -and ((Test-Path -path $TargetFolder ) -eq $True))
        {
            Remove-Item -Recurse -Force $TargetFolder
        }
        elseif(($OverWrite -eq $false) -and ((Test-Path -path $TargetFolder ) -eq $True))
        {
            WriteLog "Folder exists in destination; exiting as overwrite flag set to false"
            return $true
        }

        robocopy $SourceFolder $TargetFolder /MIR
        if($LASTEXITCODE -ne 1)
        {
            WriteLog "Failure in copying $SourceFolder files to $TargetFolder"
            WriteLog "Robocopy failed with error code $LASTEXITCODE"
            return $false
        }
        WriteLog "Copy Sucessful"   
        return $true
    }
    catch [Exception] 
    {
        WriteLog "Failed to copy the $SourceFolder to $TargetFolder"
        $myLogInfo = "Exception occured : $_
					  $($_.InvocationInfo.ScriptName)($($_.InvocationInfo.ScriptLineNumber)): $($_.InvocationInfo.Line)"
		WriteLog "ERROR -> $myLogInfo"   
        return $false  
    }
    return $true
}

Function CopyFile([string] $SourceFile,[string] $TargetFile,[bool] $OverWrite)
{
    WriteLog "Copy the file from location $SourceFile to target location $TargetFile "
    Try 
    {
        if(($OverWrite -eq $true) -and ((Test-Path -path $TargetFile ) -eq $True))
        {
            Remove-Item -Force $TargetFile
        }
        elseif(($OverWrite -eq $false) -and ((Test-Path -path $TargetFile ) -eq $True))
        {
            return $true
        } 
        Copy-Item -path $SourceFile -destination $TargetFile -recurse -force      
    }
    catch [Exception] 
    {
        WriteLog "Failed to copy the $SourceFile to $TargetFile"
        $myLogInfo = "Exception occured : $_
					  $($_.InvocationInfo.ScriptName)($($_.InvocationInfo.ScriptLineNumber)): $($_.InvocationInfo.Line)"
		WriteLog "ERROR -> $myLogInfo"   
        return $false  
    }
    return $true
}