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




<#
    Get-VerboseDebugMessage -Verbose -Debug
#>
