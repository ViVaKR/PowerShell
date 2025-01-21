$ErrorActionPreference = 'Inquire'
Get-WmiObject -Class Win32_BIOS -ComputerName viv, LON-DC1 -ErrorAction Stop
