

function MultiplyEven {
    param (
        $number
    )
    if ($number % 2) { return "$number is not even" }
    return $number * 2
}

1..10 | ForEach-Object { MultiplyEven -number $_ }

Write-Host $null

Write-Host 'Hello, World'

function calculation {
    param (
        $value
    )

    Write-Information "Please wait. Working on calculation..." -InformationAction Continue
    $value += 73
    return $value
}

$a = calculation 14
$a

function Test-Return {
    $array = 1, 2, 3
    return $array
}

Test-Return | Measure-Object

function Test-Return {
    $array = 1, 2, 3
    return (, $array)
}

Test-Return | Measure-Object
