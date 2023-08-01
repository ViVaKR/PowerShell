#! Write-Output vs Write-Host 차이점

#-> Output piped to another function, not displayed in first
function Test-Output {
	Write-Output "Output"
}

#-> Output not piped to 2nd function, only displayed in first
function Test-Host {
	Write-Host "Host" -ForegroundColor Green
}

function Receive-Output {
	process {
		Write-Host $_ -ForegroundColor Red
	}
}

Test-Output
Test-Output | Receive-Output
Test-Host

$count = 123

Write-Host ("count = " + $count++)
Write-Host "count = $count" # 문자열 보간 사용 가능


# Out-GridView (ogv)
Invoke-Command -ScriptBlock { Get-Culture } | Out-GridView
Get-Process -ComputerName Viv | Out-GridView
pwsh -Command "Get-Service | Out-GridView -Wait" # Short Cut
