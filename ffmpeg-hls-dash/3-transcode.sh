#!/bin/bash

input_file="example.mkv"

    # Define preset profiles
    declare -a profiles=("144p" "240p" "360p" "480p" "720p" "1080p" "1440p" "4K")
    
    # Get the number of preset profiles to execute (up to X resolution)
    preset_profile="$3"
    
    # Loop through each preset profile and execute ffmpeg command
    for (( i=0; i<$preset_profile; i++ ))
    do
        # Set output video resolution based on preset profile
        case ${profiles[$i]} in
            "144p") resolution="256x144" ;;
            "240p") resolution="426x240" ;;
            "360p") resolution="640x360" ;;
            "480p") resolution="854x480" ;;
            "720p") resolution="1280x720" ;;
            "1080p") resolution="1920x1080" ;;
            "1440p") resolution="2560x1440" ;;
            "4K") resolution="3840x2160" ;;
        esac
        
		echo START $input_file ${profiles[$i]} $(date +'%Y-%m-%d %H:%M:%S')
    ffmpeg -i "$input_file" -vf "scale=$resolution" -c:v libvpx-vp9 -map_metadata 0 -map_chapters 0 -an "$output_file-${profiles[$i]}.mp4"
    #ffmpeg -i "$input_file" -vf "scale=$resolution" -c:v libaom-av1 -map_metadata 0 -map_chapters 0 -an "$output_file-${profiles[$i]}.mp4"
		# fragment the file
		mp4fragment "$output_file-${profiles[$i]}.mp4" "$output_file-${profiles[$i]}_frag.mp4"
		everyresvid+=" [+representation_id=$resolution,type=video]$output_file-${profiles[$i]}_frag.mp4"
    
    # Once some resolution finished encode, package it (hls and dash) and push it to public access (directory or storage (s3) bucket)
    # bash 4-finalpkg.sh
    done
