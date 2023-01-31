@echo off & setlocal enableextensions

rem get d: label
set target_=D:

::
call :IsDeviceReady %target_% isready_
echo Device %target_% ready: %isready_%
if /i "%isready_%"=="false" (endlocal & goto :EOF)
::
call :GetLabel %target_% label_


echo ------------------------------------------
echo The label of Volume %target_% is %label_%
REM endlocal & goto :EOF
echo ------------------------------------------
if exist "disc-%label_%.txt" (
    rem file exists
	echo file exist
	tree d: /F /A >> "disc-%label_%-%random%.txt"
) else (
    rem file doesn't exist
	echo file dont exist
	tree d: /F /A >> "disc-%label_%.txt"
)

endlocal & goto :EOF

::
:IsDeviceReady
setlocal
set ready_=true
dir "%~1" > nul 2>&1
if %errorlevel% NEQ 0 set ready_=false
endlocal & set "%2=%ready_%" & goto :EOF
::
:GetLabel
setlocal
for /f "tokens=5*" %%a in (
  'vol "%~1"^|find "Volume in drive "') do (
    set label_=%%b)
endlocal & set "%2=%label_%" & goto :EOF


:GetContents
rem get contents
D:
rem cd D:
tree /F >> "disc-%label_%.txt"
PAUSE
goto :EOF