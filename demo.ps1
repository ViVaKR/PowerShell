# Get-Alias

function ForLoop {
    for ($i = 0; $i -lt 5; $i++) {
		Write-Host "Sleeping for $i seconds"
		Start-Sleep -Seconds 2
	}
}
ForLoop
