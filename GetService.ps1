Get-Service -Name W32Time
Get-Service -Name w32time | Select-Object -Property *
Get-Service -Name w32time | Select-Object -Property Status, Name, DisplayName, ServiceType
