#! 산술연산
#- 모든 산술연산자는 64비트 숫자에서 작동
#- 비트 연산은 정수 형식에서만 작동
#- shift-rigth(shr), shift-left(shl)

```ps1
	6 + 2
	"file" + "name"
	@(1, "one") + @(2.0, "two")
	@{1="One"} + @{2="Two"}
	@("arr1") * 5
	"repeat " * 3
	7 % 2
	[int](5 / 2) # 2, Rounded Down
	[int](7 / 2) # 4, Rounded Up
	[int][Math]::Ceiling(5 / 2) #= 3
	[int][Math]::Floor(5 / 2) #= 2

	$red = [ConsoleColor]::Red
	Write-Output $red - 3
	$hash1 = @{a=1; b=2; c=3}
	Write-Output $hash1
	
	$array = @()
	(0..9).ForEach({ $array += $_})

	# 비트연산
	5 -band 3 #= 1, 0101 & 0011 => 0001
	5 -bor 3 #= 7, 0101 | 0011 => 0111
	-bnot 5 #= -6
	5 -bxor 3 #= 6
	1 -shl 2 #= 4, 0001 => 0100
	0b1000 -shr 1 #= 4

	# 형식
	(2 + 3.1).GetType().Name
	([int32]::MinValue + [UInt32]::MaxValue).GetType().FullName
	[decimal]::MaxValue

	# 연산
	(Get-Date) + (New-TimeSpan -Days 1)

	Get-Process | Where-Object { $_.CPU -gt 30 } 

```

## 배열
#- 기본 : $A = 22, 5, 10, 8, 12, 9, 80
#- 단일값 : $B = ,7
#- 범위 : $C = 5..20
#- 강력한 형식 : [int32[]]$ia = 100, 200, 300
#- [Diagnostics.Process[]]$zz = Get-Process
#- $p = @(Get-Process)
#- $a = 1..10, $a[1..4]
#- foreach ($i in $a) { $i }
#-  for ($i = 0; $i -lt $a.Length; $i++) {$a[$i]}
#- ("1/1/2017", "2/1/2017", "3/1/2017").ForEach([datetime])
