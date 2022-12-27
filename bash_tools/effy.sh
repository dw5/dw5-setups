#!/bin/bash
# test script concept

# Set the input and output directories
input_dir=$(pwd)
output_dir=$(pwd)/output

# Create the output directory if it doesn't exist
mkdir -p "$output_dir"

# Iterate over all files in the input directory and subdirectories
find "$input_dir" -type f -exec mogrify -format avif {} -write "$output_dir/{}" \;
