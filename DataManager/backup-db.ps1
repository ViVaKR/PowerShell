param (
    [string]$db 
)

$server = "192.168.0.4,59273"
$database = $db
$username = "SA"
$password = "B9037!m8947#"
$Y = (Get-Date).ToString("yyyy")
$M = (Get-Date).ToString("MM")
$D = (Get-Date).ToString("dd")
$rnd = Get-Random -Minimum 10000 -Maximum 99999
# $query = "Backup Database " + $db +" TO DISK='C:\SQLServer\Backup\" + $db + "_" + $Y + "_" + $M + "_" + $D + "_" + $rnd + ".bak'"
$query = "Backup Database ${db} TO DISK='C:\SQLServer\Backup\${db}_${Y}_${M}_${D}_${rnd}.bak'"
$connectionString = "Server=$server;Database=$database;User Id=$username;Password=$password;Encrypt=Optional;"
Invoke-Sqlcmd -ConnectionString $connectionString -Query $query
