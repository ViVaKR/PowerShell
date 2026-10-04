$numbers = 1..11
ForEach ($num in $numbers) {
    if ($num % 2 -eq 0) {
        Continue
    }
    Write-Host "Odd Number is $num"
}
