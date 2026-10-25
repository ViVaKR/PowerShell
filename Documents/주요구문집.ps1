
$genre = Get-Content Genres.json | ConvertFrom-Json
$genre

$users = Invoke-RestMethod "https://jsonplaceholder.typicode.com/todos"
$user

$cred = Import-Clixml -Path ./cred.xml
$cred

Get-Content -Path "$PWD/*" -Include "*.txt" -TotalCount

$answer = Read-Host "How many days "
$answer

$number = 1
while ($number -le 10) {
  Write-Host "While Loop $number"
  $number++
}

[System.Net.Dns]::GetHostAddresses("google.com") | Select-Object IPAddressToString
# nc -zv google.com 443
# dig google.com +short
# nslookup google.com
#
# 현재 리슨(LISTEN) 중인 포트와 프로세스 확인 (가장 많이 씀)
#lsof -iTCP -sTCP:LISTEN

# 전통적인 네트워크 연결 상태 조회
# netstat -an -p tcp

# 맥 파워셸에서도 443 포트 연결 테스트가 됨!
Test-Connection -TargetName google.com -TcpPort 443

$profile = (Split-Path -Parent $Profile.CurrentUserAllHosts) # profile.ps1

# Start-Job : 내 일을 대신해 줄 '그림자 분신술(비동기 백그라운드 일꾼)'
# C# 의 **Task.Run(() => { ... }) 또는 백그라운드 스레드
# 원래 10 + 10 = 20초 걸리던 작업니 두 코어가 동시에 작엉 10초 만에 끝내 버림

# 1. Rust 빌드를 백그라운드 분신(Job)에게 시킴 (즉시 다음 줄로 넘어감!)
$jobRust = Start-Job -ScriptBlock { cargo build --release ... }

# 2. Go 빌드도 다른 분신에게 시킴 (동시에 병렬 실행!)
$jobGo = Start-Job -ScriptBlock { go build ... }

# 3. 메인 스크립트는 다른 일(어셈블리 파싱 등)을 하다가, 두 녀석이 다 끝날 때까지 대기!
Wait-Job $jobRust, $jobGo

# 4. 일꾼들이 작업한 결과(출력 로그)를 회수!
$rustLog = Receive-Job $jobRust
$goLog = Receive-Job $jobGo

# 5. 일 다 끝난 분신들 퇴근(메모리 해제)
Remove-Job $jobRust, $jobGo

# 타임 아웃 걸기 - 5초 안에 안끝나면 목을 쳐라
# 백그라운드로 실행
$job = Start-Job -ScriptBlock { Invoke-RestMethod "https://느려터진서버.com/api" }

# 딱 5초만 기다려줌! (C#의 CancellationTokenSource 같은 역할)
if (-not (Wait-Job $job -Timeout 5)) {
  Stop-Job $job
  Write-Warning "⚠️ 5초 초과! 서버가 응답이 없어 작업을 강제 처단했습니다."
}
else {
  $data = Receive-Job $job
}
Remove-Job $job

# [Start-ThreadJob]
# 100개의 작업을 동시에 병렬로 돌릴 때 (Thread 기반 초광속!)
# C#의 ThreadPool처럼 0.001초 만에 스레드를 띄워 병렬 사격!
1..100000 | ForEach-Object -Parallel {
  Write-Host "사격 번호: $_ (스레드 ID: $([System.Threading.Thread]::CurrentThread.ManagedThreadId))"
} -ThrottleLimit 10

# ================================

# 현재 단축키 현황 사용중 / 미 사용중
Get-PSReadLineKeyHandler -Bound -Unbound

# 👑 Start-Transcript 끝판왕 엔터프라이즈 템플릿
# 1. 로그 전용 폴더 준비 (없으면 자동 생성)
# 터미널 화면을 녹화하는 'CCTV 카메라'
$logDir = Join-Path $PSScriptRoot "logs"
if (-not (Test-Path $logDir)) { New-Item -ItemType Directory -Path $logDir -Force | Out-Null }

# 2. 초 단위 타임스탬프가 박힌 고유 파일명 생성
$timestamp = Get-Date -Format 'yyyyMMdd_HHmmss'
$logPath = Join-Path $logDir "build_$timestamp.log"

# 3. 끝판왕 옵션 장착 후 녹화 개시!
Start-Transcript -Path $logPath -IncludeInvocationHeader -Append

try {
  # =================================================================
  # ⚔️ [여기에 본래의 빌드 / 오케스트레이터 로직을 위치시킵니다] ⚔️
  # =================================================================
  Write-Host "▶ 작전 개시..." -ForegroundColor Green

  # 예: cargo build, go build, ld 링킹 등등...
  # 중간에 에러가 터져서 throw가 발생해도 괜찮습니다!

  Write-Host "✔ 작전 성공!" -ForegroundColor Cyan
}
finally {
  # 4. [가장 중요한 방패] 성공하든, 중간에 폭망하든 '무조건' 안전하게 녹화 종료!
  Stop-Transcript
  Write-Host "📋 작전 일지 보관 완료: $logPath" -ForegroundColor DarkGray
}

# 일반적인 형식
Start-Transcript -Path "./pwsh_time_log" -IncludeInvocationHeader

Stop-Transcript

1..5 | ForEach-Object { $_ * 3 }

$data = @(
  @{ Name = 'a'; Age = 15 },
  @{ Name = 'b'; Age = 27 },
  @{ Name = 'c'; Age = 27 },
  @{ Name = 'd'; Age = 45 },
  @{ Name = 'e'; Age = 27 }
)
$result = $data |
Group-Object -Property Age |
ForEach-Object {
  # C# 의 new { ... } 와 완전히 동일한 익명 객체 투영!
  [PSCustomObject]@{
    Age      = [int]$_.Name
    Count    = $_.Count
    Names    = ($_.Group.Name -join ', ') # 그룹에 속한 이름들 묶기
    TotalAge = ($_.Group.Age | Measure-Object -Sum).Sum # C# 의 .Sum(x=> x.Age)
  } |
  Sort-Object -Property Count -Descending
}

<#
=================================================================================
C# LINQ 메서드                        파워셸 (PowerShell) 대응 구문
=================================================================================
.Where(x => x.Age > 20)             Where-Object { $_.Age -gt 20 }
.GroupBy(x => x.Age)                Group-Object -Property Age
.Select(x => new { ... })           ForEach-Object { [PSCustomObject]@{ ... } }
.OrderByDescending(x => x.Count)    Sort-Object -Property Count -Descending
.Take(5)                            Select-Object -First 5
.Skip(2)                            Select-Object -Skip 2
.Sum(x => x.Age)                    ($_.Age | Measure-Object -Sum).Sum
.Any() / .All()                     -contains 또는 조건문 결합
=================================================================================
#>


Get-Process | Group-Object -Property ProcessName | Select-Object -Property Name, Count | Sort-Object -Property Count -Descending

Add-Content -Path "TextFile.txt" -Value "Hello, World!"
New-Item -Path "TextFile.txt" -ItemType File -Force

'a', 'b', 'c', 'd', 'a', 'a', 'b', 'e' | Select-Object -Unique

Clear-Host

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
