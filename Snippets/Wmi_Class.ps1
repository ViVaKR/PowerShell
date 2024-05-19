
#! WmiClass
$c = [Wmiclass]"root\cimv2:Win32_Process"
$c | Format-List *

