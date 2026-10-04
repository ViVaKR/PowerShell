1..999 | foreach-object { New-Item -Path $("F:\Temp\Files\vivFile_{0:000}.txt" -f  $_)}
