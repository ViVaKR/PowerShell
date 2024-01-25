
try {
    Get-Content '~/Temp/helloworld@$@#$.cs' -ErrorAction Stop
}
catch [System.IO.IOException]{
    Write-Host "Something went wrong"
}
catch {
    Write-Host "Second Catch"
}
finally {
    # Clean up resources.
    Write-Host "The end"
}
