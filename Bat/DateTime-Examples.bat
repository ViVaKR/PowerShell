@echo off
setlocal
:: ��¥ ���ڿ��� ����Ϸ� ����
set YEAR=%date:~0,4%
set MONTH=%date:~5,2%
set DAY=%date:~8,2%

set COPYDAY=1

set /a sumday = %DAY% - %COPYDAY%
set /a summonth = %MONTH% - 1

if %sumday% LEQ 0 (
set /a summday = 30-%COPYDAY%
) ELSE (
set /a summday = %sumday%
)

echo ���� ��  : %YEAR%
echo ���� ��  : %MONTH%
echo ���� ��2  : %summonth%
echo ���� ��    : %SUMDAY%
echo ���� ��2  : %SUMMDAY%
echo ���� ����: %WEEK%����
echo �����������2: %summonth%-%summday%-%year%
echo �����������: %month%-%sumday%-%year%

if %sumday% LEQ 0 (
xcopy *.* d:\temp_d\2\ /D:%summonth%-%summday%-%year% /y/h/r/e
) ELSE (
xcopy *.* d:\temp_d\22\ /D:%month%-%sumday%-%year% /y/h/r/e
)

exit
