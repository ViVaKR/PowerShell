
function FindService {
    Get-Service -Name ( -join ("*", $args[0], "*")) | Select-Object -expand Name
}

function AllServices {
    Get-Service -ErrorAction SilentlyContinue 
}

function RunningServices {
    Get-Service -ErrorAction SilentlyContinue | Where-Object { $_.Status -eq "Running" }
}

function StoppedServices {
    Get-Service -ErrorAction SilentlyContinue | Where-Object { $_.Status -eq "Stopped" }
}

function Directories {
    Get-ChildItem -Directory $args[0] | Join-String Name -DoubleQuote -Separator `r`n
}

function ServiceMember {
    Get-Service -ErrorAction SilentlyContinue | Get-Member -MemberType Method 
}

# sqlcmd -S ".\mssqllocaldb -uID -pPassword"
# sqlcmd -S "(localdb)mssqllocaldb"
