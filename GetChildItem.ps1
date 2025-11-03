Get-ChildItem -File | Sort-Object extension | Format-Table Name, Length -GroupBy @{name='Type'; expression={$_.extension}}
Get-ChildItem -File | Format-Wide -Property @{e={'{0} ({1:N2}kb)' -f $_.name, ($_.length/1kb)} }
