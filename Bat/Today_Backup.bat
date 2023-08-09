setlocal

net use K: \\<Shared Computer>\shareRoot  

set YEAR=%date:~0,4%
set MONTH=%date:~5,2%
set /a DAY=%date:~8,2% - 9
set DDAY=%DAY%

echo %YEAR% - %MONTH% - %DDAY% 
xcopy  K:\*.* <Destination>  /D:%MONTH%-%DDAY%-%YEAR%/h/y/r/e

