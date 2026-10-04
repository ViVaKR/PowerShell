#! 함수
<# 
    (1) 재사용 가능한 코드 블록
    (2) 반복적인 작업을 수행
    (3) 함수를 호출할 때 데이터를 전달할 수있음
    (4) Param() 블럭을 사용

#>

function Get-SecurityEvent {
    param (
        [string]$ComputerName
    ) # end Param
    Get-EventLog -LogName Security -ComputerName $ComputerName -Newest 10
}

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


function GetTcpConnections {
    Clear-Host
    [string]$ip = If ($null -eq $($args[0])) { "127.0.0.1" } Else { $($args[0]) }

    Write-Host ( -join ("(Get-NetTCPConnection) => ", $ip, " : 연결정보 "))

    Get-NetTCPConnection -LocalAddress $ip -ErrorAction SilentlyContinue | Sort-Object LocalPort | Format-Table -AutoSize

    # If(Get-NetTCPConnection -LocalPort 5900 -State Established -ErrorAction SilentlyContinue) {Write-host "Established!"}
}

function OpenExample {
    code (Get-ChildItem $HOME/.vscode/extensions/ms-vscode.powershell-*/examples)[-1]
}


function Test-WriteError {
    Write-Error "Bad"
    "The `$? variable is: $?"
}

Test-WriteError
"Now the `$? variable is: $?"

function Test1 {
    param($a, $b)

    # Display the parameters in dictionary format.
    $PSBoundParameters
}

Test1 -a 345 -b 456
Test1 -a Power -b Shell
