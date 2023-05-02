#!/bin/bash

# STEP 1: Get every audio track, covert it to Opus (aka the av1 for audio or some other efficient codec)

input_file="example.mkv"
output_prefix="audio"

echo "Audio Job:" $input_file

# Get the number of audio tracks in the input file
num_tracks=$(ffprobe -v error -select_streams a -show_entries stream=index -of csv=p=0 "$input_file" | wc -l)
echo "Tracks found (human):" $num_tracks

num_tracks="$(($num_tracks-1))"
echo "Tracks found (robots):" $num_tracks

for ((i=0; i<=${num_tracks}; i++)); do
   # echo "Audio track: $line"
    # Get the audio track title and language identifier
  title=$(ffprobe -v error -select_streams a:$i -show_entries stream_tags=title -of default=noprint_wrappers=1:nokey=1 "$input_file")
  lang=$(ffprobe -v error -select_streams a:$i -show_entries stream_tags=language -of default=noprint_wrappers=1:nokey=1 "$input_file")

  # Build the output filename using the track title and language identifier
  output_file="${output_prefix}_${lang}.mp4"

echo [1title:$title] [2-lang-$lang] [3out-$output_file]

  # Transcode the audio track to Opus
  ffmpeg -i "$input_file" -map 0:a:$i -c:a libopus -vn "$output_file" -n
  mp4fragment "$output_file" "${output_prefix}_${lang}_afrag.mp4"

done
