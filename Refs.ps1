
#* 네트워크
Get-NetTCPConnection -State Established | Format-Table -AutoSize

# SSH
Find-Module Posh-SSH | Install-Module

Get-Command -Module Posh-SSH

New-SSHSession -ComputerName ServerNmae

Get-SSHSession

Invoke-SSHCommand -SessionId 0 -Command cut -d: -f1 /etc/password

Get-Service | Format-Wide -Column 5

Get-Service [r-s]* | Sort-Object Status | Format-Wide -GroupBy Status


(Get-Command New-PSSession).ParameterSets.Name

# Ssh
Get-WindowsCapability -Online | Where-Object Name -like "OpenSSH"
Start-Service sshd
Set-Service -Name sshd -StartupType 'Automatic'
ssh bm@192.168.219.150

#! SSH-Keygen (사용자 키 생성)
#! 알고리즘 : DSA, RSA, ECDSA, Ed25519 (지정하지 않으면 RSA)

ssh-keygen -t ed25519

Get-SErvice ssh-agent | Set-Service -StartupType Manual

#* Start the service
Start-Service ssh-agent

Get-Service ssh-agent

ssh-add ~\.ssh\id_ed25519

# Format
Get-ChildItem HKCU:\software\microsoft | Format-Wide -Property pschildname -AutoSize

#* File Hash
Get-FileHash .\.angular-config.json | Format-List

# Algorithm -
# SHA1
# SHA256
# SHA384
# SHA512
# MD5
# => default => SHA256

#* Get Host : Terminal Info
(Get-Host).UI.RawUI.WindowSize
(Get-Host).CurrentCulture | Format-List
(Get-Host).CurrentCulture.DateTimeFormat | Format-List
(Get-Host).UI.RawUI









