@echo off

REM Set variables for the share path, username, and password
set SHAREPATH=\\xxx.samba.nty\xxx
set USERNAME=xxx
set PASSWORD=yyyy
set DRIVELETTER=N:

REM Map the share as a network drive
echo Remember LOGIN INFO
cmdkey /add:xxx.samba.nty /user:%USERNAME% /pass:%PASSWORD%

echo Add Cloud Drive
net use %DRIVELETTER%: %SHAREPATH% /user:%USERNAME% %PASSWORD% /persistent:yes 
rem /savecred

REM Display a message indicating that the mapping was successful
echo Mapping of %SHAREPATH% to drive %DRIVELETTER%: complete.

REM Pause the script to allow the user to read the message before closing the window
pause
