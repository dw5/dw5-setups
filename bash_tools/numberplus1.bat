@echo off
setlocal enabledelayedexpansion


if "%~1"=="" (
    set "directory=."
) else (
    set "directory=%~1"
)

REM Change this to your directory path

REM %directory%\.png
set "start_index=20"

:: Find the highest number in the directory
set "highest_index=0"
for %%f in ("%directory%\*.png") do (
    set "filename=%%~nf"
    set "extension=%%~xf"
    for /f "tokens=1 delims=0123456789" %%i in ("!filename!") do (
        set "file_number=%%i"
        set /a "file_number=!file_number:~1!"
        if !file_number! gtr !highest_index! (
            set "highest_index=!file_number!"
        )
    )
)

echo Highest: !highest_index!
:: Increment numbers and rename the files
set /a "start_index=highest_index+1"
for %%f in ("%directory%\*.png") do (
    set "filename=%%~nf"
    set "extension=%%~xf"
    for /f "tokens=1 delims=0123456789" %%i in ("!filename!") do (
        set "file_number=%%i"
        set /a "file_number=!file_number:~1!"
        if !file_number! geq 16 (
            set /a "new_index=start_index"
            set /a "start_index=start_index+1"
            echo dbg: ren "%%f" "!new_index!!extension!"
        )
    )
)

endlocal
pause
