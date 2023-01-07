#!/bin/bash

# good for consistend filename start cleanup, for me, after yt-dlp -x --split-chapters
# this works, chat openai even failed at making this work :D

# Change to the directory containing the files
cd /home/test/

# Set the text to be removed as a variable
text="YOURTEXTHERE "
forsed="s/^$text//"
echo $forsed
# Remove the text from the beginning of each file name
for file in *; do
  # Extract the base name of the file (without the directory path)
  base=$(basename "$file")
  echo "input: " $base
  # Remove the text from the beginning of the base name
  #echo "$base" | sed "s/^YOURTEXTHERE //"
  newbase=$(echo "$base" | sed "$forsed")
  echo "output:" $newbase
  # Rename the file
  mv "$file" "$newbase"
done
