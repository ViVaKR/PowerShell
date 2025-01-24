
# Get-Process | Group-Object -Property ProcessName | Select-Object -Property Name, Count | Sort-Object -Property Count -Descending

# Get-Process | Where-Object PriorityClass -EQ "Normal"
Clear-Host

$data = @(
    @{ Name = 'a'; Age = 15 }
    @{ Name = 'b'; Age = 27 }
    @{ Name = 'c'; Age = 27 }
    @{ Name = 'd'; Age = 45 }
    @{ Name = 'e'; Age = 27 }
)
$data | Group-Object -Property Age | Select-Object -Property Count | Sort-Object -Property Count -Descending

# 'a', 'b', 'c', 'd', 'a', 'a', 'b', 'e' | Select-Object -Unique
# New-Item -Path "TextFile.txt" -ItemType File -Force
# Add-Content -Path "TextFile.txt" -Value "Hello, World!"


