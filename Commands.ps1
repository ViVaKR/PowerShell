
# 1. Invoke-Item :기본 연결 프로그램으로 파일 즉시 열기 (가장 주된 목적)
#              기본 웹 브라우저로 URL(웹사이트) 띄우기
#              와일드 카드와 파이프 라인으로 "몰아서 열기"
#              파일 실행
# 더블 클릭의 미학, 옵션을 줄 필요가 없음
# 맥의 open 명령어 (윈도우 cmd start) 를 객체 지향 문법으로 이식한것

# Start-Process : 옵션과 함께 백그라운드나 관리자 권한으로 실행시
#                 정밀한 프로세스 제어가 필요할 때

# 2. Invoke-Command(icm) - 원격 제어의 끝판왕
# 원격에 있는 다른 서버 수십대에 스크립트 블록({}) 을 광선처럼 쏴섯 실행
# 원격 서버(SSH나 WinRM)에 접속해서 그 자리에서 즉석으로 코드 실행하고 결과 객체만 회수!
Invoke-Command -ComputerName "Server01" -ScriptBlock { Get-Process | Where-Object CPU -gt 100 }
# C#의 Task처럼 비동기(Background)로 돌리기:
# -AsJob 옵션을 붙이면 백그라운드 스레드로 비동기 실행됩니다. 바로 친구분이 말씀하신 C#의 Task.Run()처럼 돌아가는 것이죠!
# 깃허브 API를 찌르면, JSON 텍스트 파싱 따위 필요 없이 곧바로 파워셸 객체로 변환됨!
$user = Invoke-RestMethod -Uri "https://api.github.com/users/octocat"
$user.name        # The Octocat
$user.public_repos # 8
# 파이썬의 requests나 자바스크립트의 fetc() 보다 100배는 우아하고 직관적
# JSON/XML 데이터 파싱에 특화

# 3. Invoke-WebRequest (iwr, 유닉스의 curl)
# 웹 브라우저의 원초적인 HTTP 통신 그 자체
Invoke-WebRequest -Uri "https://www.google.com"

# 4. Invoke-Expression (iex, eval)
# 자바스크립트나 파이썬의 **eval()**과 완전히 같은 녀석입니다. 문자열로 된 텍스트를 파워셸 코드로 둔갑시켜 즉석에서 실행
Invoke-RestMethod https://get.scoop.sh | Invoke-Expression
# (줄여서: irm https://get.scoop.sh | iex)
# 웹에서 스크립트 문자열을 받아와서(irm), 곧바로 내 컴퓨터에서 코드로 실행(iex)해라!

# 5. Invoke-History(r) : 방금 그거 다시 해라!
# 터미널에서 이전에 실행했던 명령어 목록(History) 중에서 특정 번호의 명령을 다시 호출할 때 씁니다. (리눅스의 !123 같은 암호 문법을 닷넷의 언어로 풀어쓴 것)

# 6. Invoke-RestMethod(irm) - REST API의 절대 군주
# 맥, 리눅스, 윈도우 할 것 없이 웹 API와 통신할 때 전 세계에서 가장 사랑받는 명령어입니다. C#의 HttpClient로 호출한 뒤 System.Text.Json으로 역직렬화(Deserialize)하는 과정을 단 한 줄로 끝내줍니다.
# API 호출 즉시 닷넷 객체(PSCustomObject)로 자동 파싱:
# 깃허브 API를 찌르면, JSON 텍스트 파싱 따위 필요 없이 곧바로 파워셸 객체로 변환됨!
$user = Invoke-RestMethod -Uri "https://api.github.com/users/octocat"
$user.name        # The Octocat
$user.public_repos # 8


# Open with finder
Invoke-Item ./Temp

# Error Check
& $PROFILE.CurrentUserAllHosts

# Reload Profile
. $PROFILE.CurrentUserAllHosts

$Env:PATH -split ":"

Get-ChildItem -Directory ./Modules/ | Join-String Name -DoubleQuote -Separator `n

@{ Name = 'Length(Byte)'; Expression = 'Length'; FormatString = '{0:N0}' }
@{ Name = 'Length(Byte)'; Expression = { '{0:N0}' -f $_.Length } }

Split-Path -Parent $Profile.CurrentUserAllHosts | Set-Location # profile.ps1

$start = Get-Date -Year 2026 -Month 1 -Day 1
$items = Get-ChildItem -Path "C:\Solutions\$FileName" -Recurse
$items | Where-Object { $_.LastWriteTime -gt $start }

1..10 | Measure-Object -Property { ($_ % 2) -eq 0 } -Sum

Get-ChildItem -File | Sort-Object extension | Format-Table Name, Length -GroupBy @{name = 'Type'; expression = { $_.extension } }

Get-ChildItem -File | Format-Wide -Property @{e = { '{0} ({1:N2}kb)' -f $_.name, ($_.length / 1kb) } }

$env:Path += ":/추가할/경로/이름"

Get-Alias | select-object DisplayName, Definition | Out-Host -Paging
Get-Module -ListAvailable | Where-Object HelpInfoUri
Update-Help -Verbose -Force -ErrorAction SilentlyContinue
Write-Output @($Env:PSModulePath -split ":")
Write-Output @($Env:PATH -split ":")
Start-Sleep (New-TimeSpan -Seconds 2)
Write-Output $LASTEXITCODE
"${temp} Completed {0,3} " -f $LASTEXITCODE | Write-Host
switch ($LASTEXITCODE) {
  1 { "0:yyyy-MM-dd" -f (Get-Date) | Write-Output }
  Default {}
}
Copy-Item -Path "C:\원본폴더" -Destination "C:\새로운폴더\" -Recurse
