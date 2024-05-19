#! Do Until

$number = 1

do {
    Write-Host "Do Untile $number"
    $number++
} until ($number -gt 10)
