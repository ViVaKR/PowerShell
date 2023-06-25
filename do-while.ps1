
# true 일 동안 실행
$number = Get-Random -Minimum 1 -Maximum 10
do {
	$guess = Read-Host -Prompt "What's your guess?"
	if ($guess -lt $number)
	{
		Write-Output 'Too low!'
	}elseif ($guess -gt $number) {
		Write-Output 'Too hight!'
	}

} while (
	$guess -ne $number
)

Write-Output 'You Win!!'
