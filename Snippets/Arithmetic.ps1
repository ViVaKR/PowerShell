# 산술연산

# (1) 모든 산술연산자는 64비트 숫자에서 작동
# (2) 비트 연산은 정수 형식에서만 작동
# (3) shift-rigth(shr), shift-left(shl)

6 + 2 # => 8
"file" + "name" # => "filename"
@(1, "one") + @(2.0, "two") # @(1, "one", 2.0, "two")
@{1 = "One" } + @{2 = "Two" }
@("arr1") * 5 
- -6 # => 6
@("!") * 4 # => @("!", "!", "!", "!")
"!" * 3 # => "!!!"

# Bit AND (-band)
5 -band 3 # => 1 (0101 & 0011 = 0001)
11 -band 7 # => 3 (1011 & 0111 = 0011)

# Bit OR (-bnot)
5 -bor 0x03 # => 7 (0101 & 0011 = 0111)

# Bit NOT (-bnot)
-bnot 5 # => -6 (not 0101 = 1010)

# Bit XOR (-bxor)
5 -bxor 0x03 # => 6 (0101 xor 0011 = 0110 )

# Shift Left (-shl)
102 -shl 2 # => 408
102 -shr 2 # => 25

# div : `.5` 이면 가장 가까운 정수로 반올림
[int](5 / 2) # => 2,  Runded Down
[int](7 / 2) # => 4, Runded Up

"repeat " * 3
7 % 2
[int](5 / 2) # 2, Rounded Down
[int](7 / 2) # 4, Rounded Up
[int][Math]::Ceiling(5 / 2) #= 3
[int][Math]::Floor(5 / 2) #= 2

$red = [ConsoleColor]::Red
Write-Output $red - 3
$hash1 = @{a = 1; b = 2; c = 3 }
Write-Output $hash1
	
$array = @()
	(0..9).ForEach({ $array += $_ })

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

# 배열에 요소 추가
$array = @()
(0..5).ForEach{ $array += $_ }
$array # 1, 2, 3, 4, 5

# 정밀도를 잃지 않고 결과를 자장 잘 표현하는 .NET 숫자 형식을 자동으로 선택함
(2 + 3.1).GetType().FullName # => System.Double
(512MB).GetType().Name # => Int32
(512MB * 512MB).GetType().Name # => Double

# 식에서 산술 연산
(get-date) + (new-timespan -day 1) 
Get-Process | Where-Object { ($_.ws * 2) -gt 50mb }
