#!/bin/bash
# test script concept

# Set the input and output directories
input_dir=$(pwd)
output_dir=$(pwd)/output

# Create the output directory if it doesn't exist
mkdir -p "$output_dir"

# Iterate over all image, video, and audio files in the input directory and subdirectories
find "$input_dir" -type f \( -name '*.jpg' -o -name '*.png' -o -name '*.bmp' -o -name '*.tga' \) -o \( -name '*.mp4' -o -name '*.mov' -o -name '*.wmv' \) -o \( -name '*.mp3' -o -name '*.wav' -o -name '*.ogg' \) -exec bash -c '
  # Get the file extension
  ext="${1##*.}"
  
  # Check the file extension and convert the file accordingly
  if [[ $ext == "jpg" || $ext == "png" || $ext == "bmp" || $ext == "tga" ]]; then
    # Convert image file to avif format
    mogrify -format avif "$1" -write "$2/{}"
  elif [[ $ext == "mp4" || $ext == "mov" || $ext == "wmv" ]]; then
    # Convert video file to av1 mp4 format
    ffmpeg -i "$1" -c:v libaom-av1 -c:a copy "$2/${1%.*}.mp4"
  elif [[ $ext == "mp3" || $ext == "wav" || $ext == "ogg" ]]; then
    # Convert audio file to opus format
    ffmpeg -i "$1" -c:a libopus "$2/${1%.*}.opus"
  fi
' {} "$output_dir" \;
