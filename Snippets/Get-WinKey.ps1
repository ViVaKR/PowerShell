Write-Output "=========== OEM Key ===============" &&
Get-WmiObject -query 'Select * from SoftwareLicensingService' | Select-Object OA3xOriginalProductKey  

Write-Output ""
Write-Output "============= From Registry ============" &&

reg query "HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform" /v BackupProductKeyDefault | Write-Output

Get-ItemPropertyValue 'Registry::HKEY_LOCAL_MACHINE\SOFTWARE\Microsoft\Windows NT\CurrentVersion\SoftwareProtectionPlatform' -Name BackupProductKeyDefault | Out-GridView


