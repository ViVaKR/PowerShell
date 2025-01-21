$sqlcmd = "sqlcmd -S 192.168.0.4,59273 -U SA $pwd -Q `"Backup Database Movies TO DISK='C:\SQLServer\Data\Backup\movies.bak'`""
Invoke-Expression $sqlcmd
