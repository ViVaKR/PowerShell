#! Continue

$numbers = 1..11

ForEach ($num in $numbers){
    if ($num % 2 -eq 0) {
        Continue
    }
    Write-Host "Odd Number is $num"
}

ForEach ($num in $numbers) {
    if($num -eq 5) {break}
    Write-Host "Number is $num"
}
