#!/bin/bash

# Step 1: Take input as command line argument or prompt for it
if [ -z "$1" ]; then
    read -p "Enter URL: " input
else
    input="$1"
fi

# Step 2: Modify input to include user and password if it starts with "https://"
if [[ "$input" == "https://"* ]]; then
    input="https://user:password@${input:8}"
fi

# Step 3: Run mpv with the modified URL
mpv "$input"
