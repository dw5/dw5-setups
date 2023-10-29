@echo off
setlocal enabledelayedexpansion

REM Using MKVTOOLNIX MKVPROPEDIT, makes ENGLISH (audio track 2) THE DEFAUL
REM English must be audio track 2
REM Hopefully one day this script will instead make 
REM [1] ENGLISH track default AND to be FIRST
REM [2] ENGLISH is found by "eng" identifier
REM [3] Optional setting: delete other langs for audio, video, subtitles... (to minify filesize)
REM NOTE: Destination folder is pretty much not used at the moment, but it does create folder structure to keep it same as source.

rem "C:\Program Files\MKVToolNix\mkvpropedit.exe"
REM Set the source folder containing the MKV files and subfolders
set "source_folder=C:\Users\neatbox\Videos\WorkAV1-Deadend\RU Dead.End.Paranormal.Park.1080p.TVShows"

REM Set the destination folder for the modified MKV files, maintaining subfolder structure
set "destination_folder=C:\mkvtemp"

REM Make sure the destination folder exists, create it if it doesn't
if not exist "!destination_folder!" mkdir "!destination_folder!"

REM Loop through the MKV files in the source folder and its subfolders
for /r "%source_folder%" %%F in (*.mkv) do (
    REM Get the relative path of the source file
    set "source_file=%%F"
    set "relative_path=!source_file:%source_folder%=!"
    
    REM Construct the destination path with the matching subfolder structure
    set "destination_path=!destination_folder!!relative_path!"
    
    REM FIXING: Remove the filename from the destination path
    set "destination_path=!destination_path:%%~nxF=!"
    
    REM Ensure the destination folder exists (without using the filename)
    if not exist "!destination_path!" mkdir "!destination_path!"
    echo !destination_path!
	
    REM Set the input file and construct the output file path
    set "input_file=%%F"
    set "output_file=!destination_path!\%%~nF"
	REM NOTICE: to nF" add .mkv if filename is not .mkv.mkv

	echo !input_file! -- !output_file!
    REM swaps default, not yet make english first track, hardcoded english as audio track 2 (so for other media needs to be edited here)
    "C:\Program Files\MKVToolNix\mkvpropedit.exe" "!input_file!" --edit track:a2 --set flag-default=1 --edit track:a1 --set flag-default=0

    echo Audio tracks reordered in "!output_file!"
)

echo Finished.
pause
