@echo off
setlocal
:: 날짜 문자열을 년월일로 분해
set YEAR=%date:~0,4%
set MONTH=%date:~5,2%
set DAY=%date:~8,2%

set COPYDAY=1

set /a sumday = %DAY% - %COPYDAY%
set /a summonth = %MONTH% - 1

if %sumday% LEQ 0 (
set /a summday = 31-%COPYDAY%
) ELSE (
set /a summday = %sumday%
)

echo 현재 년  : %YEAR%
echo 현재 월  : %MONTH%
echo 현재 월2  : %summonth%
echo 현재 일    : %SUMDAY%
echo 현재 일2  : %SUMMDAY%
echo 현재 요일: %WEEK%요일
echo 복사기준일자2: %summonth%-%summday%-%year%
echo 복사기준일자: %month%-%sumday%-%year%



if %sumday% LEQ 0 (
xcopy F:\Backup\DB\*.bak J:\Backup_48\DB\ /D:%summonth%-%summday%-%year% /y/h/r/e
) ELSE (
xcopy F:\Backup\DB\*.bak J:\Backup_48\DB\ /D:%month%-%sumday%-%year% /y/h/r/e
)

exit