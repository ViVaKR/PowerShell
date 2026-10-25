function Get-SumOfNumbers {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, Position = 0, ValueFromPipeline)]
        [int[]]$Numbers
    )

    begin {
        $retValue = 0;
        Write-Verbose "Sum of numbers: $retValue"
    }
    process {
        foreach ($number in $Numbers) {
            $retValue += $number
        }
    }
    end { $retValue }
    clean { $retValue = 0 }
}

function Get-VerboseDebugMessage {

    [CmdletBinding()]
    param()

    Write-Verbose "Verbose 메시지 출력"
    Write-Debug "Debug 메시지 출력"
}

function Remove-Safe {
    [CmdletBinding(SupportsShouldProcess = $true, ConfirmImpact = 'High')]
    param (
        [string]$Path
    )

    process {
        if ($PSCmdlet.ShouldProcess($Path, "Remove")) {
            Remove-Item -Path $Path -Force
            Write-Output "Removed: $Path"
        }
    }
}

function Test-Pipeline {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory = $true, Position = 0)]
        [string]$Name,
        [Parameter(ValueFromPipeline)]
        [int[]]$Numbers
    )

    process {
        $Numbers | ForEach-Object {
            Write-Output "${Name}: $_"
        }
    }
}

function Test-ErrorAction {
    [CmdletBinding()]
    param()
    begin {
        Write-Error "This is Error message" -ErrorAction Stop
    }

    process {
        Write-Output "This is process"
    }

    end {
        Write-Output "End of the function"
    }
}

function Test-WriteLog {
    [CmdletBinding()]
    param (
        [string]$Log
    )

    begin {
        Write-Output "로그를 기록합니다."
    }
    process {
        if ($Log -match "ERROR") {
            Write-Warning "오류 로그가 포함되었습니다!"
        }

        Add-Content -Path "app.log" -Value $Log
    }

    end {
        Write-Output "로그 기록이 완료되었습니다."
    }
}

function Invoke-SpaceTorpedo {
    [CmdletBinding(
        SupportsShouldProcess = $true,       # 안전핀 (-WhatIf, -Confirm) 확보
        DefaultParameterSetName = "IdMode",  # 기본 인자 세트 정리
        PositionalBinding = $false           # 인자 대충 던지기 금지 (명확성)
    )]
    param(
        [Parameter(Mandatory, ParameterSetName = "IdMode")][int]$Id,
        [Parameter(Mandatory, ParameterSetName = "NameMode")][string]$Name
    )
    process {
        # -WhatIf가 켜져 있으면 작동을 시뮬레이션만 하고 통과하는 명품 가드
        if ($PSCmdlet.ShouldProcess($Name, "우주 어셈블리 미사일 발사")) {
            # 진짜 실행 로직
            Write-Host "🚀 탄도 발사 성공!"
        }
    }
}

function Get-BuddhamData {
    [CmdletBinding(
        DefaultParameterSetName = "ByFilter",  # 1. 인자 대충 주면 무조건 전체 조회 모드로 간주!
        PositionalBinding = $false             # 2. 인자 생략 타이핑 절대 금지 (명확성 보안)
    )]
    param(
        # --- 세트 A: 특정 키값으로 단건 조회 모드 ---
        [Parameter(Mandatory, ParameterSetName = "ByKey")]
        [int]$Id,

        # --- 세트 B: 필터(조건) 및 페이징 전체 조회 모드 ---
        [Parameter(ParameterSetName = "ByFilter")]
        [string]$Category,

        [Parameter(ParameterSetName = "ByFilter")]
        [int]$Limit = 100
    )

    process {
        # 3. [우아함의 절정] 마소 루팡들이 검수한 세트 이름으로 switch 분기 처리!
        switch ($PSCmdlet.ParameterSetName) {
            "ByKey" {
                Write-Verbose "🎯 [단건 모드 작동] ID $Id 번 데이터를 정밀 수확합니다."
                # SQL 예시: select * from table where id = @id
                break
            }
            "ByFilter" {
                Write-Verbose "📊 [필터 모드 작동] 카테고리 '$Category' 기준 최대 $Limit 개를 긁어옵니다."
                # SQL 예시: select * from table where category = @category limit @limit
                break
            }
        }
    }
}



<#
    Get-VerboseDebugMessage -Verbose -Debug
#>
