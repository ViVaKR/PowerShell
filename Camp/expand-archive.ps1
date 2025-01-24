if (Test-Path '/Volumes/Workspace/Temp/Expanded') {
    Remove-Item -Path '/Volumes/Workspace/Temp/Expanded' -Recurse -Force
}
Expand-Archive -LiteralPath '/Volumes/Workspace/Temp/Temp1.zip' -DestinationPath '/Volumes/Workspace/Temp/Expanded/'
