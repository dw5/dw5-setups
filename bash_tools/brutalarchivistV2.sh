#!/bin/bash

# Set the source and destination directories
src_dir=$1
dst_dir=$2

# Create an empty log file
log_file=$(pwd)/log.txt
echo -n "" > "$log_file"

# Find all files in the source directory
find "$src_dir" -type f | while read file; do
  # Get the file access, modified, creation, and birthday dates
  dates=$(stat -c "%x %y %w %z" "$file")
  
  # Append the file path and dates to the log file
  echo "$file $dates" >> "$log_file"
  
  # Get the corresponding file in the destination directory
  dst_file=$(echo "$file" | sed "s|$src_dir|$dst_dir|")
  
  # Check if the destination file exists
  if [ -f "$dst_file" ]; then
    # If the destination file exists, apply the dates to it
    touch -a -m -c -t "$dates" "$dst_file"
  fi
done

# Prompt the user to edit the log file
echo "Please edit the log file and then enter 'continue' to proceed."

# Pause the script until the user enters "continue"
while read -r input; do
  if [ "$input" == "continue" ]; then
    break
  else
    echo "Invalid input. Please enter 'continue' to proceed."
  fi
  sleep 1
done

# Read the log file and apply the dates to the corresponding files
while read -r line; do
  # Split the line into the file path and dates
  file=$(echo "$line" | awk '{print $1}')
  dates=$(echo "$line" | awk '{print $2, $3, $4, $5}')
  
  # Check if the file exists
  if [ -f "$file" ]; then
    # If the file exists, apply the dates to it
    touch -a -m -c -t "$dates" "$file"
  fi
done < "$log_file"
