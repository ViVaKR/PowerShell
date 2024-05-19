setlocal

For /f "tokens=1,2*" %%i in (password.txt) do net use K: \\<공유서버아이피>\<공유이름> %%i /user:%%j

set YEAR=%date:~0,4%
set MONTH=%date:~5,2%
set DAY=%date:~8,2%

xcopy K:\*.bak <local folder> /D:%month%-%day%-%year% /y/h/r/e
net use K: /delete
exit
