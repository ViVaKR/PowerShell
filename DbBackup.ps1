
# 날짜를 변수에 할당
$Y = (Get-Date).ToString("yyyy")
$M = (Get-Date).ToString("MM")
$D = (Get-Date).ToString("dd")

# SQLCMD 명령 실행
$sqlcmd = "sqlcmd -S 127.0.0.1,5539 -Q `"Backup Database DZICUBE TO DISK='D:\Backup\DB\DZICUBE_" + $Y + "_" + $M + "_" + $D + ".bak'`""
Invoke-Expression $sqlcmd
