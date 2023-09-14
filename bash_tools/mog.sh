#!/bin/bash
# mogrify but with information of current and how many files remaining
# Check if a file extension parameter is provided
if [ $# -ne 1 ]; then
    echo "Usage: $0 <file_extension>"
    exit 1
fi

file_extension="$1"

# Get a list of all files with the provided extension in the current directory
matching_files=( *."$file_extension" )

# Calculate the total number of files
total_files=${#matching_files[@]}

# Check if there are no matching files
if [ $total_files -eq 0 ]; then
    echo "No files found with the extension .$file_extension in the current directory."
    exit 1
fi

# Process each file and display progress
for ((i=0; i<total_files; i++)); do
    current_file="${matching_files[$i]}"
    echo "Processing file $((i+1)) of $total_files: $current_file"
    mogrify -format avif "$current_file"
done
