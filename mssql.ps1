param (
        [string]$OutputFormat = "table"
)
$serverInstance = "192.168.0.4,59273"
$databaseName = "Hyundai"
$userId = "Hyundai"
$password = $env:MSSQL_PASSWORD
$connectionString = "Server=$serverInstance; Database=$databaseName; User Id=$userId; Password=$password; Encrypt=Optional;"

while ($true) {
    $query = Read-Host "SQL Query (exit to quit)"
    if ($query -eq "exit") {
        Write-Host "Goodbye!" -ForegroundColor Green
        break
    }

    try {
        # Execute the query
        $result = Invoke-Sqlcmd -Query $query -ConnectionString $connectionString

        # Output formatting based on the parameter
        if ($OutputFormat -eq "table") {
            $result | Format-Table -Property * -AutoSize
        } elseif ($OutputFormat -eq "list") {
            $result | Format-List
        } else {
            Write-Host "Invalid OutputFormat specified. Defaulting to 'table'." -ForegroundColor Yellow
            $result | Format-Table -Property * -AutoSize
        }
    } catch {
        # Custom error message
        Write-Host "An error occurred while executing your query: '$query'" -ForegroundColor Red
        Write-Host "Please check your query syntax or verify the table/procedure exists." -ForegroundColor Yellow
    }
}
