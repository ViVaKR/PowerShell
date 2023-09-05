#! Function

function Test {
    begin
    {
        $i = 0
    }

    process
    {
        "Iteration : $i"
        $i++
        "`tInput: $input"
        "`tAccess Again: $input"
        $input.Reset()
        "`tAfter Reset: $input"
    }
}

"one", "two" | Test


function Get-SecurityEvent {
    param (
        [string]$ComputerName
    ) # end Param
    
    Write-Host $ComputerName, " Hello World"
    return($ComputerName)
}

$result = (Get-SecurityEvent -ComputerName viv)
Write-Host $result
