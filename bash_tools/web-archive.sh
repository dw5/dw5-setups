#!/bin/bash

# Read the website URL from user input
echo "Enter website URL:"
read url

# Download the website using wget
wget -r -np -k -p -nc --no-check-certificate "$url"

# Use find to extract all URLs from downloaded files and write to links.txt
find . -type f \( -name "*.html" -o -name "*.htm" -o -name "*.php" \) \
  -exec grep -o -E 'https?://[^"]+' {} \; | sort -u > links.txt

echo "All links saved to links.txt"

spn.sh -p 2 links.txt
