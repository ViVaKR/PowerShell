Import-Module Microsoft.PowerShell.LocalAccounts -SkipEditionCheck

Write-Output "비밀번호 입력 >> "
$Password = Read-Host -AsSecureString
$params = @{
    Name        = 'ViVaBJ'
    Password    = $Password
    FullName    = 'ViVaBJ'
    Description = 'SQL Server Manager'
}

New-LocalUser @params

Add-LocalGroupMember -Group "Administrators" -Member "viv\ViVaBJ"
