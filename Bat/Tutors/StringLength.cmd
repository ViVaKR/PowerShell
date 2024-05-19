@echo off
SET str = Hello World
call :strlen str strlen
echo String is %strlen% characters long
exit /b

:strlen
setlocal enabledelayedexpansion

:strLen_Loop

