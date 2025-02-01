Split-Path .\tmp.txt -LeafBase
Split-Path ${PWD}\tmp.txt -NoQualifier
Split-Path ${PWD}\tmp.txt -Extension
Convert-Path HKLM:\Software\Microsoft\
Get-Item .git -Force
"C:\Win*" "System*" -Resolve
ls SQLSERVER:\SQL\VIV\DEFAULT\Databases\ViVa\Tables\
Get-PSDrive
Get-PSDrive -PSProvider FileSystem | ForEach-Object { "{0:N0} MB" -f ($_.Free / (1024*1024))}
Join-Path a b c d e f g
Resolve-Path -Path $PROFILE -Relative
Test-Connection -TargetName 192.168.0.8
Remove-Service -Name "wslservice"
