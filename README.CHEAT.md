# Cheat

1. Carriage Return
2. `;` : Semicolon
3. `$name` : Dollar Sign
4. `(...)` Grouping Expression (그룹 표현식)
(1) (Get-Process -Name win*).Name
(2) Write-Output (1, 2, 3 -join '* ')

4. `${...}` : Variable Prefix
 (1) 변수 이름에 다른 문자를 포함 할 때 중괄호로 묶음
 (2) ${save-items}

5. `$(...)` Sub-Expression (하위 표현식)
 (1) 보간 문자로 복잡한 표현식은 하위 표현식으로 래핑해야 함
 (1) $($x = 1; $y = 2; $x; $y)
 (2) $p = ps | Select-Object -First 1; "Proc Name is $($p.Name)"
 (3) "Hello World $($x.GetType().Name)"

6. `@{...}` Hash Initiallizer
 (1) 해쉬 테이블 정의
 (2) $h = @{ name1=value1; name2=value2;...}
 (3) Access -> $h['name1'] or $h.name2

7 `{...}` 스크립트 블록, Anonymous Function
 단일 단위로 사용할 수 있는 문 또는 식, 컬렉션으로 인수를 받아서 값을 반환할 수 있음
 {<statement list>}

 {
  Param([type]$Parameter1 [,[type]$Parameter2])
  <statement list>
 }


