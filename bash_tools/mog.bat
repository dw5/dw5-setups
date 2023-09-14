@echo off
setlocal enabledelayedexpansion

REM mogrify but with information of current and how many files remaining

rem Check if a file extension parameter is provided
if "%~1"=="" (
    echo Usage: %0 ^<file_extension^>
    exit /b 1
)

set "file_extension=%~1"

rem Get a list of all files with the provided extension in the current directory
for %%F in (*.%file_extension%) do (
    set /a "file_count+=1"
    set "file_list=!file_list! "%%~F""
)

rem Calculate the total number of files
if !file_count! equ 0 (
    echo No files found with the extension .%file_extension% in the current directory.
    exit /b 1
)

rem Process each file and display progress
set "counter=0"
for %%F in (!file_list!) do (
    set /a "counter+=1"
    echo Processing file !counter! of !file_count!: %%~F
    rem Add your processing command here, e.g., convert to AVIF
    rem Replace the echo command with the actual processing command
    echo mogrify -format avif "%%~F"
)

endlocal
