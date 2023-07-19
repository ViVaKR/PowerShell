

$C = Get-Volume -DriveLetter C

"{0:N0} GB" -f ($C.Size / 1GB) 
// 결과 = 99 GB

"{0:N0} MB" -f ($C.Size / 1MB)
// 결과 = 101,798 MB


@{n="Size";e={[math]::Round($_.Size/1GB,2)}},@{n="FreeSpace";e={[math]::Round($_.FreeSpace/1GB,2)}}


Get-WmiObject Win32_LogicalDisk | % { "DeviceID:  $($_.DeviceID)" "FreeSpace: $($_.FreeSpace / 1GB) GB" }