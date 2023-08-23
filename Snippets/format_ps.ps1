#! Number Format

$C = Get-Volume -DriveLetter C

"{0:N0} GB" -f ($C.Size / 1GB) 
#-> 99 GB

"{0:N0} MB" -f ($C.Size / 1MB)
#-> 101,798 MB


@{n="Size";e={[math]::Round($_.Size/1GB,2)}},@{n="FreeSpace";e={[math]::Round($_.FreeSpace/1GB,2)}}

Write-Host $NULL

Get-WmiObject Win32_LogicalDisk `
| ForEach-Object { 'DeviceID: {0} FreeSpace: {1:N1} GB' `
-f $($_.DeviceID), $($_.FreeSpace / 1GB) }
