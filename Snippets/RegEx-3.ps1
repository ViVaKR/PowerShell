
#? 수량

# (1) * : 0번 이상
# (2) + : 1번 이상
# (3) ? : 0 또는 1번
# (4) {n, m} : 최소 n 이상 ~ m 이하

'Account Name:     Administrator' -match 'Account Name:\s*\w*'

'DC-01' -match '[A-Z]+-\d\d'
'DC-01' -match '[A-Z]+-\d+'

# (5) {n} : 정확히 n회와 일치
# (6) {n,} : 횟수 n회 이상 일치
# (7) {n,m} : n ~ M 횟수 사이에 일치

'111-222-3333' -match '\d{3}-\d{3}-\d{4}'

# (8) 앵커 : start -> ^, end -> $

'fishing' -match '^fi\w*ng$'

#! Escape Charater : `\`
#! 예약된 문자 : `[] () . \ ^ $ | ? * + {}`

'3.141592' -match '3\.\d{2,}'

#! 정적메서드
[regex]::Escape('3.\d{2,}')

'The last logged on user was CONTOSO\jsmith' -match '(.+was)(.+)'
$Matches.0
$Matches[0]
$Matches

'Good Dog' -match 'Dog'

$Matches[0]
$Matches.Item(0)
$Matches.0

#! 캡처링 이름할당 : `?<keyname>`
#- 캡처는 왼꼭에서 오른쪽으로 오름차순으로 저장됨
$string = 'The last logged on user was CONTOSO\jsmith'
$string -match 'was (?<domain>.+)\\(?<user>.+)'
$Matches

$Matches.domain #-> CONTOSO
$Matches.user #-> jsmith


#! 정규식 대체 : -replace
'John D. Smith' -replace '(\w+)\s*(\w+)\.\s*(\w+)', '$1.$2.$3@contos'

'Kim Bum Jun' -match '(\w+)\s*(\w+)\s*(\w+)'
$Matches.0
$Matches.1
$Matches.2
$Matches.3

Write-Output $Matches | Format-Table

foreach($item in $Matches)
{
    Write-host $item[2]
}

$str = 'Kim Bum Jun'
$pattern = '(\w+)\s*(\w+)\s*(\w+)'

$mc = [regex]::Matches($str, $pattern)
$mc.groups.count    
$mc.groups[0].value
$mc.groups[1].value

# 
'Viv\Administrator' -replace '\w+\\(?<user>\w+)', 'ViVaKR\${user}' #-> ViVaKR\Administrator

#! 모든 텍스트 : `$&`
'ViVaBM' -replace 'ViVaBM', '$& Viv $&' #-> ViVaBM Viv VivaBM

#! 큰 따옴표 내부에 $를 사용할 때는 이스케이프를 해야 함
'Hello, World' -replace '(\w+),\s+(\w+)', '$1 $2 Hi'
"Hello, World" -replace "(\w+),\s+(\w+)", "`$1 `$2 Everyone"

#! $ 문자를 넣어야 할 때에는 $로 이스케이프
'5.72' -replace '(.+)', '$1'
'5.72' -replace '(.+)', '$$$1'
