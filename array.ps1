# 배열

#! @() 으로 만들기
$data = @('Zero', 'One', 'Two', 'Three')
$nums = @(
	12,
	23,
	45
	125
)
Write-Output $data.Count
Write-Output $nums.Count

#! 쉼표로 구분된 목록으로 만들기
$data_2 = 'One', 'Two', 'Three', 'Four'
Write-Output $data_2[0]

#! Write-Output 으로 만들기
$strs = Write-Output Zero One Two Three
Write-Output $strs[2]

#! 항목인덱스
Write-Output '항목 인덱스'
Write-Output $data[0, 2, 3]
Write-Output '----'
Write-Output $data_2[0..3]
Write-Output '---'
Write-Output $data[3..0]
Write-Output '---'

# 음수 인덱스 값을 사용하면 끝에서 부터 오프셋 할 수 있음
$a = 1, 2, 3, 4, 5, 6, 7, 8, 9
Write-Output $a[4..-1]
$a[3] = 456
Write-Output '배열의 최대 인덱스 번호 : GetUpperBound(0)'
Write-Output $a.GetUpperBound(0)
Write-Output $a
Write-Output "---"

## 배열 반복 : $PSItem, $_

Write-Output '---'
$a.ForEach{"- [$PSItem]"}
Write-Output '---'
foreach ($item in $a) {
	$item * 1.3
}
Write-Output '---'
$a | ForEach-Object {$_/1024}

# For Loop
Write-Output 'For Loop'
for ($i = 0; $i -lt $a.Count; $i++) {
	"Item: [{0}]" -f ($a[$i] * 3.5)
}

# Switch

switch ($a) {
	1 { 'One' }
	2 { 'Two' }
	3 { 'Three' }
	Default {}
}








