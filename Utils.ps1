$sln = "C:\Solutions"
$gitProj = "F:\1_GitProjects"

# * Modules * #
# Import-Module "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\Common7\Tools\Microsoft.VisualStudio.DevShell.dll"
# Enter-VsDevShell -InstanceId c2dcfd7d

# * PsDrive * #
## Map PSDrives to other registry hives
if (!(Test-Path HKCR:)) {
    $null = New-PSDrive -Name HKCR -PSProvider Registry -Root HKEY_CLASSES_ROOT
    $null = New-PSDrive -Name HKU -PSProvider Registry -Root HKEY_USERS
}

# 함수 관리
# (1) 드라이브 `Get-ChildItme function:`
# (2) Help `(Get-ChildItem function:help).Definition`,
# (3)      `$function:help`

# 2023 년 1월 1일 이후 변경된 파일 찾기
function Get-NewPix {

    param (
        [string]$FileName
    )

    $start = Get-Date -Year 2023 -Month 1 -Day 1
    $items = Get-ChildItem -Path "C:\Solutions\$FileName" -Recurse
    $items | Where-Object { $_.LastWriteTime -gt $start }
}

# 프롬프트 편집
function Set-Posh {
    code "C:\Users\bm\AppData\Local\Programs\oh-my-posh\themes\jandedobbeleer.omp.json"
}

# Switch Item : 매개변수 유무에 따른 실행
# Switch-Item -on or -off
# Switch-Item -on:$True
function Switch-Item {
    param ([switch]$on)
    if ($on) { "Switch On" }
    else { "Switch Off" }
}

# 파이프 라인
## - 1, 2, 4 | Get-PipeLine 
function Get-PipeLine {
    # 파이프 라인에서 함수를 사용하는 경우 
    # 파이프된 개체는 자동변수 $input 에 할당됨
    # 모든 개체는 end 에서 받은후 실행
    begin { 
        "Begin: The input is $input" 
    } # 함수의 시작 부분에서 한번 만 실행

    # process 가 있으면 자동변수 $input 은 $_ 할당되고 삭제됨
    process { # 한번에 하나의 파이프라인 개체의 자동변수 `$_` 에 할당
        "The value is : $_"
    }

    end { 
        "End: The input is $input"
    }
    clean { 
        "Clean"
    } 
}

# 필터  : `filter [<scope>]<name> {<statement list>}`
# -> `Get-WinEvent -LogName System -MaxEvents 100 | Get-ErrorLog -Message`

filter Get-ErrorLog ([switch]$Message) {
    if($Message) { Out-Host -InputObject $_.Message }
    else { $_ }
}

# 환경변수 관리
function Set-Var {
    param (
        [string]$Var,
        [string]$Val
    )

    [System.Environment]::SetEnvironmentVariable($Var, $Val, "Machine")
}

function Get-DockerConfig {
    code "C:\Users\bm\.docker\config.json"
}

function Remove-Var {
    param (
        [string]$Var
    )

    [System.Environment]::SetEnvironmentVariable($Var, $null, "Machine")
}

#! OpenSSH
function Get-SSH {
    # Confirm the Firewall rule is configured. It should be created automatically by setup. Run the following to verify
    if (!(Get-NetFirewallRule -Name "OpenSSH-Server-In-TCP" -ErrorAction SilentlyContinue | Select-Object Name, Enabled)) {
        Write-Output "Firewall Rule 'OpenSSH-Server-In-TCP' does not exist, creating it..."
        New-NetFirewallRule -Name 'OpenSSH-Server-In-TCP' -DisplayName 'OpenSSH Server (sshd)' -Enabled True -Direction Inbound -Protocol TCP -Action Allow -LocalPort 22
    }
    else {
        Write-Output "Firewall rule 'OpenSSH-Server-In-TCP' has been created and exists."
    }
    
}

# Go To PowerShell Folder
function GoProfile {
    Split-Path -Parent $Profile | Set-Location
}

function GoOneDrive {
    Set-Location $Env:OneDriveCommercial
}

function GoSln {
    param (
        [string]$child_0 = $args[0],
        [string]$child_1 = $args[1],
        [string]$child_2 = $args[2],
        [string]$child_3 = $args[3]
    )
    Join-Path -Path $sln $child_0 $child_1 $child_2 $child_3 -Resolve | Set-Location
    Get-ChildItem -Path .
}

function Get-ProcessMember () {
    Get-Process | Get-Member | Out-Host -Paging
}


#! Alias `ll`
function ll {
    param (
        $arg
    )
    $order = @(
        @{ E = 'Length'; D = ($arg -eq "l") ? $true : $false }
    )

    Get-ChildItem  | Sort-Object $order | Format-Table Mode, Attributes,
    @{N = "Creation Date"; E = { $_.CreationTime.ToShortDateString() }; Alignment = "right" },
    @{N = "Time"; E = { $_.CreationTime.ToString("HH:mm:ss") } },
    IsReadOnly,
    @{N = "LastWrite Date"; E = { $_.LastWriteTime.ToShortDateString() } ; Alignment = "right" },
    @{N = "Time"; E = { $_.LastWriteTime.ToString("HH:mm:ss") } },
    @{N = "Length(Byte)"; E = { '{0:N0}' -f ($_.Length) } }, Name -AutoSize
}

#! Alias `go, ntc, vping, dnsname`
Set-Alias -Name ntc Get-NetTCPConnection
Set-Alias -Name vping Test-NetConnection
Set-Alias -Name dnsname Resolve-DnsName

function FindService {
    Get-Service -Name ( -join ("*", $args[0], "*")) | Select-Object -expand Name
}

function GetAllServices {
    Get-Service -ErrorAction SilentlyContinue 
}

function GetStartedServices {
    Get-Service -ErrorAction SilentlyContinue | Where-Object { $_.Status -eq "Running" }
}

function GetStopedServices {
    Get-Service -ErrorAction SilentlyContinue | Where-Object { $_.Status -eq "Stopped" }
}

function GetDirectories {
    Get-ChildItem -Directory $args[0] | Join-String Name -DoubleQuote -Separator `r`n
}

function GetServiceMember {
    Get-Service -ErrorAction SilentlyContinue | Get-Member -MemberType Method 
}

function GetPath {
    param (
        $path = [System.Environment]::GetEnvironmentVariable("Path", "Machine")
    )
    $path -split ";" | ForEach-Object { $_ }
}

function Remove-Temp {
    Remove-Item -Path $env:TEMP\* -Recurse -Force -ErrorAction SilentlyContinue
    Clear-Host
    Write-Output "Completed..."
    GoTemp
}

function GoPosh {
    param (
        $POSH_THEMES_PATH = "C:\Users\bm\AppData\Local\Programs\oh-my-posh\themes"
    )
    Invoke-Item $POSH_THEMES_PATH
}

function Get-Env {
    Get-ChildItem -Path Env:
}

function GoTemp {
    param (
        $TEMP = "C:\Users\bm\AppData\Local\Temp"
    )
    Invoke-Item $TEMP
}

function GoGitProjects {
    param (
        [string]$child_0 = $args[0],
        [string]$child_1 = $args[1],
        [string]$child_2 = $args[2],
        [string]$child_3 = $args[3]
    )
    Join-Path -Path $gitProj $child_0 $child_1 $child_2 $child_3 -Resolve | Set-Location
    Get-ChildItem -Path .
}

function EditPosh {
    code $Env:POSH_THEME
}

function GetTcpConnections {
    Clear-Host
    [string]$ip = If ($null -eq $($args[0])) { "127.0.0.1" } Else { $($args[0]) }
    Write-Host ( -join ("(Get-NetTCPConnection) => ", $ip, " : 연결정보 "))
    Get-NetTCPConnection -LocalAddress $ip | Sort-Object LocalPort | Format-Table -AutoSize
}

# sqlcmd -S ".\mssqllocaldb -uID -pPassword"
# sqlcmd -S "(localdb)mssqllocaldb"

<# 
	$ oh-my-posh print primary --config .\VivPrompt.json --shell uni

! final_space
! pwd
! terminal_background
! accent_color
! var
! shell_integration

#>

# 1. 함수 (이름 출돌 방지를 위하여 접두사 지정 권장)

function Get-VivVersion {
    $PSVersionTable.PSVersion
}

# 2. 함수가 메모리에 로드 되면 Function PSDrive 에서 확인 가능
# ` Get-ChildItem -Path function:\Get*`

# 3. 매개변수
function Test-VivParameter {
    param (
        $ComputerName
    )
    Write-Output $ComputerName
}

# 4. 반환값이 있는 함수 (사용 -> $ Get-VivParameterCount -ParameterName ComputerName, Computer, ServerName, Host, Machine)
function Get-VivParameterCount {
    param (
        [string[]]$ParameterName
    )

    foreach ($item in $ParameterName) {
        $Results = Get-Command -ParameterName $item -ErrorAction SilentlyContinue

        [PSCustomObject]@{
            Name            = $item
            NumberOfCmdlets = $Results.Count
        }
    }
}

# 5. 고급함수
#* 일반함수와 고급 함수의 차이점 : 자동으로 추가되는 공통 매개변수를 포함함
#* 공통 매개변수 : Verbose, Debug...

<# 일반함수
-> Get-Command -Name Test-VivParameter -Syntax
-> Test-VivParameter [[-ComputerName] <Object>]
#>
<#? 고급함수
-> [CmdletBinding] 추가
-> $ Get-Command -Name Test-VivCmdletBinding -Syntax
-> $ (Get-Command -Name Test-VivCmdletBinding).Parameters.Keys
    ComputerName
    Verbose
    Debug
    ErrorAction
    WarningAction
    InformationAction
    ErrorVariable
    WarningVariable
    InformationVariable
    OutVariable
    OutBuffer
    PipelineVariable
-> SupportsShouldProcess : WhatIf, Confirm 매개변수 추가
#>

function Test-VivCmdletBinding {
    [CmdletBinding()]
    param (
        $ComputerName
    )
    Write-Output $ComputerName
}

function Test-VivSupportsShouldProcess {
    [CmdletBinding(SupportsShouldProcess)]
    param (
        $ComputerName
    )
    Write-Output $ComputerName.WhatIf
}

# 형식을 지정함으로서 단일 컴퓨터 이름만 지정가능하게 함
# Mandatory : 매개변수를 넣지 않으면 매개변수 질의를 함
function Test-VivParameterValidation {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]$ComputerName
    )
    Write-Output $ComputerName
}

# 기본값 제공
function Test-VivParameterDefault {
    [CmdletBinding()]
    param (
        [ValidateNotNullOrEmpty()]
        [string[]]$ComputerName = $Env:COMPUTERNAME
    )
    Write-Output $ComputerName
}

#* Verbose 
<# 사용예
    $ Test-VivVerboseOutput -ComputerName S01, S02, S03 -Verbose
    VERBOSE: Attempting to perform some action on S01
    S01
    VERBOSE: Attempting to perform some action on S02
    S02
    VERBOSE: Attempting to perform some action on S03
    S03
#>
function Get-FuncName {

    <#
.SYNOPSIS
시놉시스

.DESCRIPTION
설명

.PARAMETER ComputerName
파라미터 1

.PARAMETER Credential
파라미터 2

.EXAMPLE
(예) 1.

.EXAMPLE
(예) 2.

.EXAMPLE
(예) 3.

.INPUTS
String

.OUTPUTS
반환 값

.NOTES
Author:  Kim Bum Jun
Website: https://vivabm.com

#>

    [CmdletBinding()]
    param (
        [ValidateNotNullOrEmpty()]
        [Parameter(Mandatory, ValueFromPipeline, ValueFromPipelineByPropertyName)]
        [string[]]$var
    )

    PROCESS {
        foreach ($item in $var) {
            try {
                Write-Output $item
            }
            catch {
                Write-Warning -Message "오류가 발생하였습니다.: $item"
            }
        }
    }
}

function OpenExample {
    code (Get-ChildItem $HOME/.vscode/extensions/ms-vscode.powershell-*/examples)[-1]
}
