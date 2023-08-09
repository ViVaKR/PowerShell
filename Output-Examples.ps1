#! Write-Output vs Write-Host 차이점

# * Write-Output * #
# (1) 화면의 결과를 파이프라인의 입력값으로 보낼 수 있음
# (2) 출력 결과에 색깔 등으로 표현 할 수 없음
function Test-Output {
	Write-Output "Output"
	Write-Output "Hello World", "사랑", "평화", "화평" | Where-Object {$_.length -gt 3} # Hello World
}

# * Write-Host * # 
# (1) 파이프라인 입력값으로 사용할 수 없음
# (2) 콘솔에 결과 화면을 다양한 결과를 보여줌
# (3) 색깔, 구분자
function Test-Host {
	Write-Host "Host" -ForegroundColor Green -BackgroundColor DarkYellow
	Write-Host "사랑", "희락", "화평" -Separator ", "
	Write-Host "사랑","희락","화명" -Separator "," -fore red
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
