setlocal

net use X: \\<Shared Computer>\local$

set YEAR=%date:~0,4%
set MONTH=%date:~5,2%
set DAY=%date:~8,2%
set /a M=%MONTH%-1
set /a D=%DAY%-1

xcopy X:\*.* "<Destination>" /D:%month%-%day%-%year% /y/h/r/e
net use X: /delete
exit
