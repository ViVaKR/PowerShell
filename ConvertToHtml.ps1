Get-Alias |
ConvertTo-Html Name,
Definition,
@{
 name  = 'ParameterCount'
 expr  = { $_.Parameters.Keys.Count }
 align = 'center'
} |
Out-File .\aliases.htm -Force
