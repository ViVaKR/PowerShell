@echo off
if exist E:\TEST\ (
 echo OK! �׷� ���丮�� �ֽ��ϴ�
) else (
 echo ����, �׷� ���丮�� ����
)

echo %date% %time%

echo %date%

:: ���� �����ϰ� ��¥�� ���
set MyDate=%date:~0%


:: ���� ������ ��¥ ���
echo %MyDate%


:: MyDate ���� ����
set MyDate=

@echo off

echo %date:~0,1%����

echo off
setlocal

echo ������ ��¥: %date%
echo ������ �ð�: %time%
echo --------------------------
echo.


:: ��¥ ���ڿ��� ����Ϸ� ����
set YEAR=%date:~0,4%
set MONTH=%date:~5,2%
set DAY=%date:~8,2%

echo ���� ��  : %YEAR%
echo ���� ��  : %MONTH%
echo ���� ��  : %DAY%
echo ���� ����: %WEEK%����

echo.

:: �ð� ���ڿ��� �ú��ʷ� �и�
set HOUR=%time:~0,2%
set MINUTE=%time:~3,2%
set SECOND=%time:~6,2%

echo ���� ��  : %HOUR%
echo ���� ��  : %MINUTE%
echo ���� ��  : %SECOND%


echo.
echo.
echo (YYYY-MM-DD hh:mm:ss �������� ǥ���ϱ�)
echo.
echo     %YEAR%-%MONTH%-%DAY%  %HOUR%:%MINUTE%:%SECOND%
echo.

echo (�ѱ��� ��¥ ���ڿ��� ǥ��)
echo.
echo     %YEAR%�� %MONTH%�� %DAY%��  %HOUR%�� %MINUTE%�� %SECOND%��
echo.

@echo off

rem �̰��� ��ġ ���Ͽ� ������
rem ���̴� ������ �����Դϴ�.

dir

: �̰��� ��ġ ���Ͽ� ������
: ���̴� ������ �����Դϴ�.

dir

:: �̰��� ��ġ ���Ͽ� ������
:: ���̴� ������ �����Դϴ�.

dir

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: �̰��� ��ġ ���Ͽ� ������
:: ���̴� ������ �����Դϴ�.
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
dir
