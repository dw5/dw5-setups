@echo off
setlocal



for /l %%i in (0, 1, 40) do (
    rem echo Downloading: https://swine.da.img.nty/swine_scr%%i.jpg
    wget https://swine.da.img.nty/swine_scr%%i.jpg
)

echo All downloads complete.

endlocal
pause
