function ForLoop {
    for ($i = 0; $i -lt 5; $i++) {
		Write-Host "Sleeping for $i seconds"
		Start-Sleep -Seconds 1
	}
}
ForLoop

# until
(1..50).Where({$_ -gt 10}, "Until")
(1..50).Where({$_ -le 10});

#! Split 
#- 두 개의 개별 컬렉션으로 분할하거나 그룹화함
$running, $stopped = (Get-Service).Where({$_.status -eq 'Running'}, 'Split')
$running
$stopped

#! Clear


#! ForEach
$a = @(0 .. 3)
$a.ForEach({ $_ * $_})











