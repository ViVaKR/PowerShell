
$answer = Read-Host "How many days: "
$answer

Write-Host "How old are you? " -NoNewline

$age = Read-Host
$age | Out-GridView -PassThru
