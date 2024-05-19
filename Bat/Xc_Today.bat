@echo off
setlocal

:: 날짜 문자열을 년월일로 분해

set YEAR=%date:~0,4%
set MONTH=%date:~5,2%
set DAY=%date:~8,2%

xcopy Z:\Backup\DB\*.bak E:\Backup\DB\ /D:%month%-%day%-%year% /y/h/r/e

exit