@echo off
if exist E:\TEST\ (
 echo OK! 그런 디렉토리가 있습니다
) else (
 echo 에러, 그런 디렉토리는 없음
)

echo %date% %time%

echo %date%

:: 요일 삭제하고 날짜만 얻기
set MyDate=%date:~0%


:: 요일 삭제한 날짜 출력
echo %MyDate%


:: MyDate 변수 삭제
set MyDate=

@echo off

echo %date:~0,1%요일

echo off
setlocal

echo 원래의 날짜: %date%
echo 원래의 시각: %time%
echo --------------------------
echo.


:: 날짜 문자열을 년월일로 분해
set YEAR=%date:~0,4%
set MONTH=%date:~5,2%
set DAY=%date:~8,2%

echo 현재 년  : %YEAR%
echo 현재 월  : %MONTH%
echo 현재 일  : %DAY%
echo 현재 요일: %WEEK%요일

echo.

:: 시간 문자열을 시분초로 분리
set HOUR=%time:~0,2%
set MINUTE=%time:~3,2%
set SECOND=%time:~6,2%

echo 현재 시  : %HOUR%
echo 현재 분  : %MINUTE%
echo 현재 초  : %SECOND%


echo.
echo.
echo (YYYY-MM-DD hh:mm:ss 형식으로 표시하기)
echo.
echo     %YEAR%-%MONTH%-%DAY%  %HOUR%:%MINUTE%:%SECOND%
echo.

echo (한국식 날짜 문자열로 표시)
echo.
echo     %YEAR%년 %MONTH%월 %DAY%일  %HOUR%시 %MINUTE%분 %SECOND%초
echo.

@echo off

rem 이것은 배치 파일에 설명문을
rem 붙이는 간단한 예제입니다.

dir

: 이것은 배치 파일에 설명문을
: 붙이는 간단한 예제입니다.

dir

:: 이것은 배치 파일에 설명문을
:: 붙이는 간단한 예제입니다.

dir

::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
:: 이것은 배치 파일에 설명문을
:: 붙이는 간단한 예제입니다.
::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::::
dir
