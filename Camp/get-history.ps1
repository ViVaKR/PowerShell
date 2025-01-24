

Get-History | Export-Csv -Path '/Volumes/Workspace/Temp/history.csv' `
    -NoTypeInformation -Delimiter ',' -Encoding UTF8


Import-Csv -Path '/Volumes/Workspace/Temp/history.csv' -Encoding UTF8
