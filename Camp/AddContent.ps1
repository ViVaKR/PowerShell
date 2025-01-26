
1..100 | Foreach-Object { Add-Content -Path./LineNumbers.txt -Value "This is line $_." }

