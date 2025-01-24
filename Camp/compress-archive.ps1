
if (Test-Path /Volumes/Workspace/Temp/Temp1.zip) {
    # Remove-Item /Volumes/Workspace/Temp/Temp1.zip

    Compress-Archive -Path ~/Temp/ -Update -DestinationPath /Volumes/Workspace/Temp/Temp1.zip
    Write-Output "Updated..."
    return
}

# if (Test-Path /Volumes/Workspace/Temp/Temp2.zip) {
#     Remove-Item /Volumes/Workspace/Temp/Temp2.zip

# }

Compress-Archive -Path ~/Temp/ -DestinationPath /Volumes/Workspace/Temp/Temp1.zip

# Compress-Archive -Path ~/Temp/* -DestinationPath /Volumes/Workspace/Temp/Temp2.zip
# Get-ChildItem -Path ~/Temp/pwshs/ | Compress-Archive -DestinationPath ~/Temp/pwshs.zip -Force
