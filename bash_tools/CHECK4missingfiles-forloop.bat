@echo off
setlocal enabledelayedexpansion
rem Delayed expansion allows variables update values


set "howmany2count=500"
set "counted=0"

for /L %%i in (0,1,%howmany2count%) do (
    set "filename=%%i.png"
    if exist "!filename!" (
        REM echo File !filename! exists.
		set /a "counted+=1"
    ) else (
        echo File !filename! does not exist.
    )
)

set /a expected_count=howmany2count+1

if %counted% equ %expected_count% (
    echo All files are there, nothing missing
) else (
    echo ==== Some files are missing. ====
 )

pause
