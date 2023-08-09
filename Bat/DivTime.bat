@echo off
setlocal
set T=%time:~0,2%
set M=%time:~3,2%
set S=%time:~6,2%
set B=%time:~9,2%

echo %T%-%M%-%S%-%B%

