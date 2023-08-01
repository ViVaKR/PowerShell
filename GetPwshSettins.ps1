# Terminal Get settings.json
$settings = (Get-Item "C:\users\$env:UserName\AppData\Local\Packages\Microsoft.WindowsTerminal_*\LocalState\settings.json")
$settings.DirectoryName
