$registryPath = "HKLM:\SOFTWARE\Policies\Microsoft\Windows\LanmanWorkstation"

$Name = "AllowInsecureGuestAuth"

$value = "1"

if(!(Test-Path $registryPath))
{
   Write-Output "Registry Path in Policies doesnot exist"
}

else 
{
    Set-ItemProperty -Path $registryPath -Name $name -Value $value -Type DWord
    Write-Output "Guest Logon enabled sucessfully in Policies"
}

$registryPath2 = "HKLM:\SYSTEM\CurrentControlSet\Services\LanmanWorkstation\Parameters"

$Name2 = "AllowInsecureGuestAuth"

$value2 = "1"

if(!(Test-Path $registryPath2))
{
   Write-Output "Registry Path in CurrentControlSet doesnot exist"
}

else 
{
    Set-ItemProperty -Path $registryPath2 -Name $name2 -Value $value2 -Type DWord
    Write-Output "Guest Logon enabled sucessfully in CurrentControlSet"
}
