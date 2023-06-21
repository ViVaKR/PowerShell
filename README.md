<!-- markdownlint-disable MD012 -->
<!-- markdownlint-disable MD046 -->

# PowerShell

## 파워쉘이란

- 명령줄
  - 그래픽 인터페이스 보다 속도가 빠름
  - 명령 일괄 처리를 실행할 수 있음으로 작업 자동화에 적합함
  - 클라우드 리소스 및 기타 리소스와 상호 작용 가능
  - 스크립트 를 텍스트 파일에 저장하고 소스 제어 시스템을 사용할 수 있음
- 스크립팅 언어 두 부분으로 구성됨
- 관리작업을 자동화 하기 위한 프레임워크
- 플랫폼 간의 도구로 발전

## 기능

- 파이프라인 : 한 명령의 출력은 다음 명령에 대한 입력이 되어 여러 명령을 순차적으로 실행함.
- 별칭 : 명령을 실행하는 데 사용할 수 있는 대체 이름

## 기존 명령줄 셸과의 차이점

- 파워셸에서는 개체를 입력 및 출력으로 사용하므로 서식 지정 및 추출에 소요시간을 줄일 수 있음
- *cmdlet* (command let) : 컴파일된 명령
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

```bash
Get-Command -Verb Get -Noun a-noun*
```

## 도움말

```ps1
Update-Help -UICulture en-US -Verbose
Update-Help -UICulture ko-KR -Verbose
Get-Help -Name Get-Help
```

## Get-Help

- NAME : 명령의 이름
- SYNTAZ : 플래그의 조합과 간혹 허용되는 매개 변수를 사용하여 명령을 호출하는 방법을 보여줌
- ALIASES: 명령의 별칭이 있으면 나열됩니다. 별칭은 명령의 다른 이름이며 명령을 호출하는 데 사용할 수 있습니다.
- REMARKS: 이 명령에 대한 자세한 도움말을 가져오기 위해 실행할 명령에 관한 정보를 제공합니다.
- PARAMETERS: 매개 변수의 세부 정보를 제공합니다. 해당하는 경우 형식, 더 긴 설명 및 허용되는 값을 나열합니다.

- Full: 자세한 도움말 페이지를 반환합니다. 표준 응답에서 가져오지 않는 매개 변수, 입력 및 출력과 같은 정보를 지정합니다.
- Detailed: 표준 응답과 유사하지만 매개 변수에 해당하는 섹션을 포함하는 응답을 반환합니다.
- Examples: 예제(있는 경우)만 반환합니다.
- Online: 명령의 웹 페이지를 엽니다.
- Parameter: 매개 변수 이름을 인수로 요구합니다. 이 플래그는 특정 매개 변수의 속성을 나열합니다.

```ps1
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
```

---

## [Install PowerShell On Ubuntu](https://learn.microsoft.com/en-us/powershell/scripting/install/install-ubuntu?view=powershell-7.3)

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

## Paths (MacOS)

- $PSHOME is `/usr/local/microsoft/powershell/<version number>/`
- User profiles are read from `~/.config/powershell/profile.ps1`
- Default profiles are read from `$PSHOME/profile.ps1`
- User modules are read from `~/.local/share/powershell/Modules`
- Shared modules are read from `/usr/local/share/powershell/Modules`
- Default modules are read from `$PSHOME/Modules`
- PSReadLine history are recorded to `~/.local/share/powershell/PSReadLine/ConsoleHost_history.txt`

## PROFILE

- [MS Document](https://learn.microsoft.com/en-us/powershell/module/microsoft.powershell.core/about/about_profiles?view=powershell-7.3)
- The $PSHOME variable stores the installation directory for PowerShell
- The $HOME variable stores the current user's home directory

- All Users, All Hosts
  - Windows - $PSHOME\Profile.ps1
  - Linux - /usr/local/microsoft/powershell/7/profile.ps1
  - macOS - /usr/local/microsoft/powershell/7/profile.ps1
- All Users, Current Host
  - Windows - $PSHOME\Microsoft.PowerShell_profile.ps1
  - Linux - /usr/local/microsoft/powershell/7/Microsoft.Powershell_profile.ps1
  - macOS - /usr/local/microsoft/powershell/7/Microsoft.Powershell_profile.ps1
- Current User, All Hosts
  - Windows - $HOME\Documents\PowerShell\Profile.ps1
  - Linux - ~/.config/powershell/profile.ps1
  - macOS - ~/.config/powershell/profile.ps1
- Current user, Current Host
  - Windows - $HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1
  - Linux - ~/.config/powershell/Microsoft.Powershell_profile.ps1
  - macOS - ~/.config/powershell/Microsoft.Powershell_profile.ps1

## `$PSVersionTable`

## `Get-Verb`

## `Get-Command`

```bash

Get-Process | Sort-Object -Descending -Property Name, CPU

Get-Process 'some process' | Sort-Object -Property @{Expression = "Name"; Descending = $True}, @{Expression = "CPU"; Descending = $False}

# Where-Object Sort-Object
Get-Process | Where-Object CPU -gt 2 | Sort-Object CPU -Descending | Select-Object -First 3
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

```bash
 New-Item .gitignore
 ni .gitignore

```
