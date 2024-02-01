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

# * New-PSDrive * #
New-PSDrive -Name VG -PSProvider FileSystem -Root "F:\1_GitProjects" | Out-Null

## Add argument completer for the dotnet CLI tool
$scriptblock = {
    param($wordToComplete, $commandAst, $cursorPosition)
    dotnet complete --position $cursorPosition $commandAst.ToString() |
    ForEach-Object {
        [System.Management.Automation.CompletionResult]::new($_, $_, 'ParameterValue', $_)
    }
}

Register-ArgumentCompleter -Native -CommandName dotnet -ScriptBlock $scriptblock

# $PSDefaultParameterValues['*:NoLogo'] = $true

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
Set-Alias -Name vConnection Get-NetTCPConnection
Set-Alias -Name vPing Test-NetConnection
Set-Alias -Name vDnsName Resolve-DnsName

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


fuction Etc {
    Get-Host
    Update-Help
}

winget.exe --info
winget.exe export package.json
winget.exe list -n 9

# [ source ]리리
# msstore : Microsoft Store 카탈로그
# winget : 윈도우 패키지 관리자 앱 리포지토리

winget.exe source update winget
winget.exe source list
winget.exe source add --name Contoso