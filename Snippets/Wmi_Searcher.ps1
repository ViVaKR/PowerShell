
#! WmiSearcher
$s = [WmiSearcher]'Select * from Win32_Process Where Handlecount > 1000'
$s.get() | Sort-Object handlecount | Format-Table handlecount, __path, name -auto
