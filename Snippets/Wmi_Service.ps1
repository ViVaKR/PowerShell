# Win32_Service
Get-WmiObject -Query "Select * from Win32_Service Where name ='WinRM'" -ComputerName viv | Format-List -Property PSComputerName, Name, ExitCode, ProcessID, StartMode, State, Status

#! 
Get-WmiObject -Class Win32_Service -ComputerName 192.168.219.103
