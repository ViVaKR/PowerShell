@echo off

goto %1

:MS
echo 여기는 '마이크로소프트' 라벨입니다
goto QUIT

:GOOGLE
echo 여기는 '구글' 라벨입니다
goto QUIT

:Apple
echo 여기는 '애플' 라벨입니다
goto QUIT

:QUIT
echo 여기서 Caller.bat으로 다시 돌아갑니다.
