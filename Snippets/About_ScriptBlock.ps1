Invoke-Command -ScriptBlock { param($p1, $p2)
    "p1: $p1"
    "p2: $p2"
} -ArgumentList "First", "Second"

# 호출 연산자 : `&`
$anony = { param($color = 'red'); "color = $color" }
& $anony 'blue'  # => color = blue; # `&` => Invoke-Command

$a = { Get-Service BITS }
Invoke-Command $a

$a = { param($p1, $p2)
    "p1: $p1"
    "p2: $p2"
}

& $a -p2 'First' -p1 "Second"

# 할당을 이용하여 스크립트 블록의 출력을 변수에 저장할 수 있음
$a = { 34 + 27 }
$b = & $a
Write-Host $b -ForegroundColor Red

$a = { 40 * 27 }
$b = Invoke-Command $a
Write-Host $b -ForegroundColor Magenta


