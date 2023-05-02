#!/bin/bash

# STEP 2: UNTESTED: Get Chapters data (intro, outro, story 1, story 2)

input_file="example.mkv"
output_prefix="audio"

echo "Chapter Job:" $input_file

ffmpeg -i $input_file -hide_banner -show_entries chapter -select_streams a -print_format csv -csv "timecode=%{TIMECODE},title=%{TAG:title}\n"
