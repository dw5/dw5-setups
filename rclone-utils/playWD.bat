@echo off
setlocal

REM Step 1: Take input as command line argument or prompt for it
set "input=%~1"
if "%input%"=="" (
    set /p "input=Enter URL: "
)

REM Step 2: Modify input to include user and password if it starts with "https://"
if "%input:~0,8%"=="https://" (
    set "input=https://user:password@%input:~8%"
)

REM Step 3: Run mpv with the modified URL
mpv "%input%"

endlocal
