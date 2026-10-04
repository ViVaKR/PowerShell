
if ($freeSpace -le 5GB) {
    Write-Host "Free disk space is less than 5 GB"
}
elseif ($freeSpace -le 10GB) {
    Write-Host "Free disk space is less than 10 GB"
}
else {
    Write-Host "Free disk space is more than 10 GB"
}
