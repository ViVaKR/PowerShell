#! Get-Service

Get-Service | Out-File "Current_Services.txt"

Get-Service | Where-Object {$_.Status -eq "Running"}

Get-Service -Name "*SQL*" | Where-Object {$_.Status -eq "Running"} | Select-Object -expand name
