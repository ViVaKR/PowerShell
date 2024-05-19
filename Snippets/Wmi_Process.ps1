#! WMI
$wmi = [Wmi]'\\viv\root\cimv2:Win32_Process.Handle="6964"'
$wmi.Name

#! 로컬 컴퓨터 프로세스 가져오기
Get-WmiObject -Class Win32_Process

