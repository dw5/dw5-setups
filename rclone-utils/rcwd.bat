@echo off
setlocal

rem Check if the parameter is provided
if "%~1"=="" (
    echo Usage: rcwd ^<drive c: or cloud:^>
    exit /b
)

rem Run the rclone serve webdav command
rclone serve webdav --addr :8080 "%~1"

endlocal
