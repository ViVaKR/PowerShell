$sln = "C:\Solutions"
$gitProj = "F:\1_GitProjects"

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

<# [ 동사목록 ]
Verb        Group
----        -----
Add         Common
Approve     Lifecycle
Assert      Lifecycle
Backup      Data
Block       Security
Checkpoint  Data
Clear       Common
Close       Common
Compare     Data
Complete    Lifecycle
Compress    Data
Confirm     Lifecycle
Connect     Communications
Convert     Data
ConvertFrom Data
ConvertTo   Data
Copy        Common
Debug       Diagnostic
Deny        Lifecycle
Disable     Lifecycle
Disconnect  Communications
Dismount    Data
Edit        Data
Enable      Lifecycle
Enter       Common
Exit        Common
Expand      Data
Export      Data
Find        Common
Format      Common
Get         Common
Grant       Security
Group       Data
Hide        Common
Import      Data
Initialize  Data
Install     Lifecycle
Invoke      Lifecycle
Join        Common
Limit       Data
Lock        Common
Measure     Diagnostic
Merge       Data
Mount       Data
Move        Common
New         Common
Open        Common
Optimize    Common
Out         Data
Ping        Diagnostic
Pop         Common
Protect     Security
Publish     Data
Push        Common
Read        Communications
Receive     Communications
Redo        Common
Register    Lifecycle
Remove      Common
Rename      Common
Repair      Diagnostic
Request     Lifecycle
Reset       Common
Resize      Common
Resolve     Diagnostic
Restart     Lifecycle
Restore     Data
Resume      Lifecycle
Revoke      Security
Save        Data
Search      Common
Select      Common
Send        Communications
Set         Common
Show        Common
Skip        Common
Split       Common
Start       Lifecycle
Step        Common
Stop        Lifecycle
Submit      Lifecycle
Suspend     Lifecycle
Switch      Common
Sync        Data
Test        Diagnostic
Trace       Diagnostic
Unblock     Security
Undo        Common
Uninstall   Lifecycle
Unlock      Common
Unprotect   Security
Unpublish   Data
Unregister  Lifecycle
Update      Data
Use         Other
Wait        Lifecycle
Watch       Common
Write       Communications

#>
