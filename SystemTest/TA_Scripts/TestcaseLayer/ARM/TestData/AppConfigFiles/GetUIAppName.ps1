$installedapps = get-AppxPackage

$aumidList = @()
$uiAppName = ""
foreach ($app in $installedapps)
{
    foreach ($id in (Get-AppxPackageManifest $app).package.applications.application.id)
    {
        $aumidList += $app.packagefamilyname
        if($app.PackageFamilyName.StartsWith("5ceed41e-3bef-42e2-9ad9-eb1335f89a75"))
        {
            $uiAppName =$app.PackageFamilyName
        }
    }
}
$ScriptRoot = Get-Variable -Name PSScriptRoot -ValueOnly -ErrorAction Stop

$uiAppName | Out-File -FilePath $ScriptRoot\appName.txt -Encoding ASCII 

# Close out the Powershell Remoting Session
#Exit-PSSession
#Return 0

#$aumidList
