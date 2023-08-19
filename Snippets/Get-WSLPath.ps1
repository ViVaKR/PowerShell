Get-ChildItem HKCU:\Software\Microsoft\Windows\CurrentVersion\Lxss\ | 
ForEach-Object { 
        (Get-ItemProperty $_.PSPATH) | Select-Object DistributionName, BasePath 
}
