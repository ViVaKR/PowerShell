# PowerShell

## 파워쉘이란

- 명령줄
    - 그래픽 인터페이스 보다 속도가 빠름
    - 명령 일괄 처리를 실행할 수 있음으로 작업 자동화에 적합함
    - 클라우드 리소스 및 기타 리소스와 상호 작용 가능
    - 스크립트 를 텍스트 파일에 저장하고 소스 제어 시스템을 사용할 수 있음
- 스크립팅 언어
- 관리작업을 자동화 하기 위한 프레임워크
- 플랫폼 간의 도구로 발전
- 클라우드 관리

## 기능

- 파이프라인 : 한 명령의 출력은 다음 명령에 대한 입력이 되어 여러 명령을 순차적으로 실행함.
- 별칭 : 명령을 실행하는 데 사용할 수 있는 대체 이름

## 기존 명령줄 셸과의 차이점

- 파워셸에서는 개체를 입력 및 출력으로 사용하므로 서식 지정 및 추출에 소요시간을 줄일 수 있음
- *Cmdlet* (command let) : 컴파일된 명령
    - .NET, .NET Core 에서 개발되어 파워셸 내에서 명령을 호출함
    - 명명표준 : `동사-명사`  $\rightarrow$ `Get-Verb`
    - 별도의 실행 파일이 아닌 공용 런타임에 빌드되어 매개변수 구문 분석 및 파이프 라인 동작에서 일관된 환경을 제공함
    - 일반적으로 개체 입력을 받아들이고 개체를 반환함
    - NET Core 로 빌드되는 오픈소스로서, 유연하고 확장성이 탁월함
- 다양한 유형의 명령
    - 네이티브 실행 파일
    - cmdlet
    - 함수
    - 스크립트 또는 별칭

```ps1
 Get-Command -Verb Get -Noun a-noun*
```

## Cmdlet (Command-lets) : PowerShell 명령

- 독립실행파일이 아닌 네이티브 PowerShell 명령
- PowerShell Module에 수집되어 요청시 로드될 수 있음
- 컴파일된 .NET언어, PowerShell 스크립팅 언어에서 사용됨
- 동사-명사 형식으로 명명
- 동사 : cmdlet 이 수행하는 작업
- 명사 : cmdlet 작업이 수행되는 대상 리소스
- .NET 클래스의 인스턴스
- 자체 구문분석, 오류 프리젠테이션 및 출력 형식은 런타임에 처리됨
- 텍스트 스트림이 아닌 파이프라인에서 입출력 개체를 처리하고
- 기본클래스 : System.Object 에서 파생되는 .NET 클래스를 기반으로 함
-

## 도움말 : `Get-Help`

```ps1
 Update-Help -UICulture en-US -Verbose
 Update-Help -UICulture ko-KR -Verbose
 Get-Help -Name Get-Help -Full # 전체 도움말 항목 (-Detailed, Examples, Online, Parameter Noun, ShowWindows)
 help Get-Command -Full | Out-GridView # 별도의 창에 도움말 표시 (권장)
 help *process*
```

## Get-Command

- 이름으로 필터링 : `Get-Command -Name Get-Process`
- 동사로 필터링 : `Get-Command -Verb 'Get'`
- 명사로 필터링 : `Get-Commnad -Noun U*
- 매개변수 결합 필터링 : Get-Command -Verb Get -Noun U*
- Select-Object 필터링 : `Get-Command | Select-Object -First 5 -Property Name, Source`
- Where-Object 필터링 : `Get-Process | Where-Object {$_.ProcessName -like "n*"}`
- Get-Member : 명령에 사용할 수 있는 개체, 속성 및 메서드 를 검색
    - `Get-Process | Get-Member -MemberType Method`
    - `Get-Process | Get-Member | Select-Object Name, Definition`
- `Get-Command -ParameterType Process`

```ps1
 # SqlServer
 Install-Module -Name SqlServer


 Get-Command -Name *service* -CommandType Cmdlet, Function, Alias
 Get-Help Get-FileHash -Examples
 help Get-FileHash -Examples

 Get-FileHash /etc/apt/sources.list | Format-List
 Get-FileHash .\Workspace.zip | Format-List

 # 개체검색
 Get-Process -Name 'name-of-process' | Get-Member
 Get-Command -ParameterType Process
 Get-Process -Name 'notepad' | Get-Member | Select-Object Name, MemberType
 Get-Process | Get-Member

 # Select-Object를 사용하고 고유한 속성 목록을 선택하여 기본 뷰를 재정의할 수 있습니다.
 그런 다음 이러한 속성을 Format-Table 또는 Format-List로 보내 원하는 대로 테이블을 표시할 수 있습니다.

 Get-Process zsh | Format-List -Property *
 Get-Process zsh | Get-Member -Name C*
 Get-Process zsh | Select-Object -Property Id, Name, CPU

 ## ssh
 New-PSSession
 (Get-Command New-PSSession).ParameterSets.Name
 #- SSHHost
 #- SSHHostHashParam

 # 모든 속성
 Get-Service -Name w32time | Select-Object -Property *

 # 메서드 결과범위
 Get-Service -Name w32time | Get-Member -MemberType Method
 # 메서드 사용
 (Get-Servivce -Name w32time).Stop()
 # 서비스 중지
 Get-Service -Name w32time
 # 서비스 시작
 Get-Service -Name w32time | Start-Service -PassThru

 # oneline
 $Srv = 'w32time'; Get-Service -Name $Srv

 # Where-Object
 Get-Service | Where-Object Name -eq w32time
```

```bash
 # Update the list of packages
 sudo apt-get update
 # Install pre-requisite packages.
 sudo apt-get install -y wget apt-transport-https software-properties-common
 # Download the Microsoft repository GPG keys
 wget -q "https://packages.microsoft.com/config/ubuntu/$(lsb_release -rs)/packages-microsoft-prod.deb"
 # Register the Microsoft repository GPG keys
 sudo dpkg -i packages-microsoft-prod.deb
 # Delete the the Microsoft repository GPG keys file
 rm packages-microsoft-prod.deb
 # Update the list of packages after we added packages.microsoft.com
 sudo apt-get update
 # Install PowerShell
 sudo apt-get install -y powershell
 # Start PowerShell
 pwsh
```

## Uninstall PowerShell On Ubuntu : `sudo apt-get remove powershell`

## [Installing PowerShell on macOS](https://learn.microsoft.com/en-us/powershell/scripting/install/installing-powershell-on-macos?view=powershell-7.3)

## Install PowerShell on Windows : `dotnet tool install --global PowerShell`

## 현재 실행 정책 확인 : `Get-ExecutionPolicy`

## 원격서명 실행 정책 : `Set-ExecutionPolicy -ExecutionPolicy RemoteSigned`

## PROFILE

- [문서](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_profiles?view=powershell-7.3)
- 파워셀이 시작될 때 실행되는 스크립트
- 별칭, 함수 및 변수 추가
- PowerShell Dirve 만들기
- 임의의 명령 실행
- 기본설정 변경
- The `$PSHOME` : Installation directory for PowerShell
- The `$HOME` : Current user's home directory
- 모든 사용자, 모든 호스트 `All Users, All Hosts`
    - $PROFILE.AllUsersAllHosts
    - Windows - $PSHOME\Profile.ps1
    - Linux - /usr/local/microsoft/powershell/7/profile.ps1
    - macOS - /usr/local/microsoft/powershell/7/profile.ps1
- 모든 사용자, 현재 호스트 `All Users, Current Host`
    - $PROFILE.AllUsersCurrentHost
    - Windows - $PSHOME\Microsoft.PowerShell_profile.ps1
    - Linux - /usr/local/microsoft/powershell/7/Microsoft.Powershell_profile.ps1
    - macOS - /usr/local/microsoft/powershell/7/Microsoft.Powershell_profile.ps1
- 현재 사용자, 모든 호스트 `Current User, All Hosts`
    - Windows - $HOME\Documents\PowerShell\Profile.ps1
    - Linux - ~/.config/powershell/profile.ps1
    - macOS - ~/.config/powershell/profile.ps1
- 현재 사용자, 현재 호스트 `Current user, Current Host`
    - `$PROFILE.CurrentUserCurrentHost`
    - Windows - $HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1 `$PROFILE`
    - Linux - ~/.config/powershell/Microsoft.Powershell_profile.ps1
    - macOS - ~/.config/powershell/Microsoft.Powershell_profile.ps1

```ps1
 Test-Path -Path $PROFILE.AllUsersAllHosts

 if(!(Test-Path -Path <profile-name>)) {
  New-Item -ItemType File -Path <profile-name> -Force
 }

 # 프로필 편집
 code $PROFILe       # D:\Documents\PowerShell\Microsoft.VSCode_profile.ps1
 code $PROFILE.AllUsersAllHosts   # C:\Program Files\PowerShell\7\profile.ps1
 code $PROFILE.CurrentUserAllHosts  # D:\Documents\PowerShell\profile.ps1
 code $PROFILE.AllUsersCurrentHost  # C:\Program Files\PowerShell\7\Microsoft.VSCode_profile.ps1
 code $PROFILE.CurrentUserCurrentHost # D:\Documents\PowerShell\Microsoft.VSCode_profile.ps1

 # NoProfile
 pwsh -NoProfile

 # 매개 변수 전체 목록
 pwsh -?

 # 세션에서 프로필을 실행
 Invoke-Command -Session $s -FilePath $PROFILE

```

## `$PSVersionTable`

## `Get-Verb`

## `Get-Command`

## `Set-ExcutionPolicy -ExcutionPolicy <Policy Name>`

- AllSigned
- Bypass
- Default
- RemoteSigned
- Restricted
- Undefined
- Unrestricted

## Trusted Repository In PowerShell

```ps1

 Set-PSRepository -Name "PSGallery" -InstallationPolicy Trusted
  Unregister-PSRepository -Name "PSGallery"

 # 확인
 Get-PSRepository
```

```bash

Get-Process | Sort-Object -Descending -Property Name, CPU

Get-Process 'some process' | Sort-Object -Property @{Expression = "Name"; Descending = $True}, @{Expression = "CPU"; Descending = $False}

# Where-Object Sort-Object
Get-Process | Where-Object CPU -gt 2 | Sort-Object CPU -Descending | Select-Object -First 3
```

## Intellisense

```ps1
 Install-Module -Name PSReadLine -Repository PSGallery -Force
 Get-PSReadLineOption | Select-Object -Property Predictionsource

 # 키바인딩 변경
 Set-PSReadLineKeyHandler -Chord "Ctrl+f" -Function ForwardWord
 Set-PSReadLineKeyHandler -Chord "RightArrow" -Function ForwardWord
```

---

## `Prompt`

```bash
  Get-Command Promt
  (Get-Command Prompt).ScriptBlock # ScriptBlock
```

## Prompt Example

`/Users/<whoami>/.config/powershell/Microsoft.Powershell_profile.ps1`

```bash
  function prompt {
    # $color = Get-Random -Min 1 -Max 16
    Write-Host "[ " -NoNewline
    Write-Host $(Get-Date -Format "dddd yyyy-MM-dd HH:mm") -NoNewline -ForegroundColor 1
    Write-Host " " -NoNewline
    Write-Host $(Get-Location) -ForegroundColor 13 -NoNewline
    Write-Host " ]"
    Write-Host ($(Split-Path -Path (Get-Location) -Leaf) + " $") -NoNewline -ForegroundColor 2
    return " "
}

```

## ETC Commands

```ps1
  New-Item .gitignore
  ni .gitignore

 # 환경변수
 $Env:<variable-name>
 $Env:windir
 $PSHOME
 $Env:PATH
 $Env:PATHEXT # 윈도우에서 실행파일로 간주하는 파일 확장명
 $Env:TERM
 $Env:<variable-name> = "<new-value>" # new or update
 $Env:Foo = "An Example" #new
 $Env:Foo = '' # remove
 New-Item -Path Env:\Foo -Value 'Bar'
 Remove-Item -Path Env:\Foo* -Verbose

 # 환경변수 영구 저장 방법 3가지
 #-1. 프로필에 저장
 $PROFILE # 프로필 경로 가져오기

 #-2. SetEnvironmentVariable 메서드 사용
 [Environment]::SetEnvironmentVariable('Foo', 'Bar', 'Machine')
 [Environment]::SetEnvironmentVariable('Foo','', Machine)
 #-3. 시스템 제어판 사용

 # Where-Object
 Get-ChildItem -Path $HOME -Recurse | Where-Object {$_.Length -gt 20MB} | Measure-Object

 # Alias
 Get-Alias -Definition Get-Service # 명령의 별칭

 # Windows 논리드라이브, 공급자 드라디브, 네트워크 공유 드라이브
 Get-PSDrive

 Get-PSProvider

 Get-ChildItem -Path Cert:\LocalMachine\CA

 #Show MarkDown
 Show-MarkDown -Path E:\1_GitProjects\PowerShell\README.md -UseBrowser

 Invoke-Item https://vivabm.com
```

## 비교 연산자

| 연산자 | 정의 |
| --- | ---- |
| -eq | 같음 |
| -ne | 같지 않음 |
| -gt | 초과 |
| -ge | 크거나 같음 |
| -Like | * 와일드카드 문자를 사용하여 일치 |
| -NotLike | * 와일드카드 문자를 사용하여 일치하지 않음 |
| -Match | 지정된 정규식과 일치 |
| -NotMatch | 지정된 정규식과 일치하지 않음 |
| -Contains | 컬렉션에 지정된 값이 포함되는지 확인 |
| -NotContains | 컬렉션에 특정 값이 포함되지 않는지 확인 |
| -In | 컬렉션에 지정된 값이 있는지 확인 |
| -NotIn | 컬렉션에 지정된 값이 없는지 확인 |
| -Replace | 지정된 값을 대체 |

---

[ 등호 ]
-eq , -ieq , -ceq - 같음
-ne , -ine , -cne - 같지 않음
-gt , -igt , -cgt - 보다 큼
-ge , -ige , -cge - 보다 크거나 같음
-lt , -ilt , -clt - 보다 작음
-le , -ile , -cle - 작거나 같음

[ Matching ]
-like , -ilike , -clike - 문자열이 와일드카드 패턴과 일치합니다.
-notlike , -inotlike , -cnotlike - 문자열이 와일드카드 패턴과 일치하지 않음
-match , -imatch , -cmatch - 문자열이 정규식 패턴과 일치합니다.
-notmatch , -inotmatch , -cnotmatch - 문자열이 정규식 패턴과 일치하지 않음

[ 대체 ]
-replace , -ireplace , -creplace - 정규식 패턴과 일치하는 문자열을 대체합니다.

[ Containment ]
-contains , -icontains , -ccontains - 컬렉션에 값이 포함됩니다.
-notcontains , -inotcontains , -cnotcontains - 컬렉션에 값이 없습니다.
-in - 컬렉션에 값이 있습니다.
-notin - 컬렉션에 값이 없습니다.

[ 타입비교 ]
-is - 두 개체 모두 동일한 형식입니다.
-isnot - 개체가 동일한 형식이 아닙니다.

---

```ps1
 "Hello" -ceq "hello" # False
 "Hello" -eq "hello" # True
 5 -ge 5 # True
 'PowerShell' -like '*shell' # True
 'PowerShell' -match '^*.shell$' # True

 $Numbers = 1..10 # Set 1 ~10
  $Numbers -contains 15 # False
  $Numbers -Notcontains 15 # True
  7 -in $Numbers
  23 -NotIn $Numbers
  'PowerShell' -replace 'Shell' # Power
  'SQL Saturday - Baton Rouge' -Replace 'Saturday', 'Sat' # 대소문자 구분하지 않음
  'SQL Saturday - Baton Rouge'.Replace('saturday', 'Sat') # 대소문자 구분

```

## WMI (Windows Management Instrumentation) : CIM cmdlet 대체 사용을 권장, PowerShell 5.1

## CIM (Common Information Model)

- `Get-Command -Module CimCmdlets`
- WMI에 엑세스
- `Get-CimInstance -Query 'Select * from Win32_BIOS'`
- `Get-CimInstance -ClassName Win32_BIOS`
- `Get-CimInstance -ClassName Win32_BIOS | Select-Object -Property SerialNumber`
- `Get-CimInstance -ClassName Win32_BIOS -Property SerialNumber | Select-Object -Property SerialNumber`
- `(Get-CimInstance -ClassName Win32_BIOS -Property SerialNumber).SerialNumber`
- `$CimSession = New-CimSession -ComputerName Viv -Credential (Get-Credential)`
    - `Get-CimInstance -CimSession $CimSession -ClassName Win32_BIOS`
- Get-Service -Name WinRM | Start-Service
    - Test-WSMan -ComputerName ViV
    - `Get-CimSession` : CimSessions 가 현재 연결되어 있는 대상과 사용중인 프로토콜을 확인하는 용도로 사용

```ps1
 $DCOM = New-CimSessionOption -Protocol Dcom
 $Cred = Get-Credential
 $CimSession = New-CimSession -Computer ViV -SessionOption $DCOM -Credential $Cred
 Get-CimInstance -CimSession $CimSession -ClassName Win32_BIOS
```

## `Get-Command -ParameterName ComputerName` : ComputerName 매개변수가 있는 명령을 확인함

## `Enable-PSRemoting` : 원격 컴퓨터에서 PoweShell 원격기능 사용 설정 (원격명령 사용 목적)

## 일대일 원격작업 `Enter-PSSession`

```ps1
 $Cred = Get-Credential
 Enter-PSSession -ComputerName Viv -Credential $Cred
```

## 일대다 원격작업

```ps1
 # 하나 이상의 원격 컴퓨터 를 대상으로 동시에 명령을 실행하기
 Invoke-Command -ComputerName c01, c02, c03 { Get-Service -Name W32time } -Credential $Cred
```

## 함수

## 고급함수

- `CmdletBinding` 추가
- 공통매개 변수 자동포함 : Verbose, Debug

## 동사 (Verb)

## Alias

```ps1
 Get-Alias -Definition Get-ChildItem
 Get-Alias -Name gci
```

- 호환성 별칭
- 스크립트에서는 별칭 사용 안함

| cmd.exe | UNIX | PowerShell Cmdlet | PowerShell Alias |
| --- | --- | --- | ---|
| cd, chdir | cd | Set-Location | sl, cd, chdir |

## 키바인딩

```ps1
 Get-PSReadLineKeyHandler
 Get-PSReadLineKeyHandler -Unbound
 Set-PSReadLineKeyHandler -Chord 'Ctrl+Spacebar' -Function MenuComplete

 # 키이름 및 코드 바인딩
 [System.Console]::ReadKey()
 [System.Console]::ReadLine()

```

## 배열

- `@()` 을 이용하여 빈 배열을 만듬

## 자동변수

`$$` : 세션에서 받은 마지막 줄의 마지막 토큰을 포함
`$?` : 마지막 명령의 실행 상태 포함 True, False
`$^` : 세션에서 받은 마지막줄의 첫번째 토큰
`$_` : $PSItem 과 동일, 파이프 라인의 모든 개체에 대해 작업을 수행하는 명령에서 이 변수를 사용할 수 있음.
`$args` :
`$Error` :
`$Event` : 처리중인 이벤트를 나타내는 PSEventArgs 개체를 포함
`$EventArgs` :
`$ExecutionContext` :
`$false`
`$foreach`
`$HOME`
`$input`
`$IsCoreCLR` : 현재 세션이 .NET Core 런타임(CoreCLR)에서 실행되고 있는지 여부
`$IsLinux`
`$IsMacOS`
`$IsWindows`
`$LASTEXITCODE` : 종료코드 (0: 성공적으로 완료, 1 : 예외 종류)
`$Matches` :
`$MyInvocation`
`$NestedPromptLevel`
`$null` :
`$PID` :
`$PROFILE` : Test-Path $PROFILE
`$PSBoundParameters` : 전달된 매개 변수, key-value
`$PSCmdlet`
`$PSCommandPath` : 실행중인 스크립의 전체 경로 및 파일 이름 포함
`PSCulture`
`$PSEdition`
`$PSHOME`
`$PSItem`
`$PSScriptRoot`
`$PSSenderInfo`
`$PSUICulture`
`$PSVersionTable`
`$PWD`
`$Sender`
`$StackTrace`
`$Switch`
`$this` : Get-ChildItem .\README.md | Get-Member BaseName | Format-List
`$true`

## Built-in Functions

`cd..`
`cd\`
`Pause` : 일시중지
`promt` : 기본 프롬프트 함수, 재정의 하여 사용자 지정가능
`clear-host`
`oss`
`mkdir`

## 윈도우 드라이브 문자함수

## Format-Custom

- 클래스 정의와 유사한 형식으로 개체의 사용자 지정 보기 제공
`Get-Date | Format-Custom @{expr={$_.Date};depth=1},TimeOfDay`

```ps1
dir -rec

Get-AppxPackage -AllUsers | where-object {$_.PackageFullName -eq ""} |  Remove-AppxPackage -AllUsers
Remove-Item: Access to the path 'C:\Program Files\WindowsApps\' is denied.
cd "C:\Program Files\windowsapps"
takeown /F Microsoft.Minecraft* /r /d y

```

```ps1
 Get-AppxPackage -AllUsers | where-object {$_.name -eq "LGElectronics.LGChatbot"} |  Remove-AppxPackage -AllUsers
```

## VSCode Start with Changed Extensions

`"C:\Users\Viv\AppData\Local\Programs\Microsoft VS Code\Code.exe" --extensions-dir="E:\Microsoft VS Code\extensions"`

```ps1
 # 윈도우 시스템 확인
 systeminfo
 Get-WmiObject -Class win32_OperatingSystem | % Caption
 wmic os get osarchitecture
 wmic cpu get datawidth
 [Environment]::Is64BitOperatingSystem

 # 별칭 만들기
 Set-Alias -Name ll -Value Get-ChildItem

 # 삭제
 Remove-Item c:\Tmp\* -Recurse -Force
```

## 오류 처리 전역변수

- `$ErrorActionPreference`
    - Continue : 기본값
    - SilentlyContinue : 오류 메시지를 표시하지 않고 계속 실행
    - Inquire : 수행할 작업을 묻는 프롬프트 표시
    - Stop : 오류를 종료 처리하고 실행 중지, 오류 트래핑

## 점소싱

- 다른 스크립트를 현재 범위로 가져오는 방법 :`. C:\Scripts\functions.ps1`

```ps1

  # Windows 업데이트를 관리하는 PowerShell 모듈
  Install-Module -Name PSWindowsUpdate

  # 업데이트 확인
  Get-WindowsUpdate

  # 모든 업데이트 설치
  Install-WindowsUpdate -AcceptAll -AutoReboot
  $running, $stopped = (Get-Service -ErrorAction SilentlyContinue).Where({$_.Status -eq 'Running'},'Split')
```

```bash
Get-ChildItem | Measure-Object -Property length -Minimun -Maximum -Sum -Average

files = Get-ChildItem -Path $PSHOME -Recurse
$files | Group-Object -Property Extension -NoElement | Sort-Object -Property Count -descending

files = Get-ChildItem -Path $PSHOME -Recurse
[hashtable]$newhash = [ordered]@{ Id = 1; Shape = "Square"; Color = "Blue"; }

```

## 비트연산자

- AND(-band)
- OR(-bor)
- XOR(-bxor)
- NOT(-bnot)
- Shift Left(-shl)
- Shift Right(-shr)
