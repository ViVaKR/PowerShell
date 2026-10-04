$data = @(
    @{ Name = 'a'; Age = 15 }
    @{ Name = 'b'; Age = 27 }
    @{ Name = 'c'; Age = 27 }
    @{ Name = 'd'; Age = 45 }
    @{ Name = 'e'; Age = 27 }
)

$data | Group-Object -Property Age | Select-Object -Property Count | Sort-Object -Property Count -Descending
