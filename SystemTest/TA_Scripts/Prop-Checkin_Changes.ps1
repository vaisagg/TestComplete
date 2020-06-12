#Test
Param(
$sourcedir = $(Get-ChildItem Env:teamcity_build_checkoutDir),
$sourcefiles =  @("New-vAppFromTemplate.ps1"`
,"Kill-AutoCIvApps.ps1"`
,"Start-Modules.ps1"`
,"Connect-PowerCLIEnv.ps1"`
,"Start-MTMProcess.ps1"`
,"New-CIVMNic.ps1"`
,"Set-PowerCLIEnv.ps1"`
,"stcrd.ps1"`
,"gtcrd.ps1"`
),

$destinations =  @("\\Usndea3001ksrv\Automation\vCloud"`
)
)

foreach ($dest in $destinations){
    ForEach ($src in $sourcefiles){
        Write-Host "Copying $($sourcedir)\$($src) to $($dest)"
        Copy-Item "$($sourcedir)\$($src)" -Destination "$dest" -Recurse -Force -Confirm:$false
        }
}

Write-Host "$sourcefiles $(Get-Date)"