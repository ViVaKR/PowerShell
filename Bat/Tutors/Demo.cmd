@echo off

@REM Code Snippets

SET globalVar = 5

SETLOCAL
echo %1
echo %2
echo %3

echo "The Program has completed %1 %2 %3"

set /A var=12345
set message=Hello World
echo %message%
echo var = %var%

SET /A a = 10
SET /A b = 3
SET /A c = %a% + %b%
echo %a% + %b% = %c%

SET /A c = %a% - %b%
echo %c%

SET /A c = %a% / %b%
echo %c%

SET /A c = %a% * %b%
echo %c%
ENDLOCAL

:: String Interpolation
SET a = Hello
SET b = World
SET /A d = 50
SET c=%a% and %b% %d%
echo %c%
