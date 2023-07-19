
ipconfig | Get-Member

get-process -name notepad | sort-object -property id

# 
Get-Process a* | Get-Member
Get-Service a*
get-process | where-object { $_.name -eq "notepad" } | Get-Member

dotnet tool install -g powershell

# Set Cliboard
Set-Clipboard -Value "hello from powershell"
Get-Clipboard

# GridView
Get-Process | Out-GridView -PassThru | Stop-Process

#  Navigate
Get-PSDrive

# Modules
Import-Module -Name Appx -UseWIndowsPowershell

get-host

$psversiontable 

$psversiontable.psversion

$psversiontable.psversion.major

# 파워쉘 버전 확인 팁
[intptr]::size 

# 실행환경설정
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope LocalMachine