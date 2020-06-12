#Write-Host "Copied files exists in IoT Device!" -ForegroundColor Green
#text exists in file
 
#Write-Host  Out-File -FilePath C:\data\deploy\sample.txt
#Add-Content C:\data\deploy\sample.txt

#Write-Host "Test"
Start-Sleep 1
$psise.CurrentPowerShellTab.ConsolePane.Text | Set-Content -Path C:\data\deploy\sample.txt