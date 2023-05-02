#!/bin/bash
echo "Package Job:" $input_file

# if something, you may want to create a job lock, simple 
# if file exists pkg.lck { echo "Job in progress", sleep 1minute}
# echo "LOCK">pkg.lck

audio_files=$(find . -name '*_afrag.mp4' -type f -printf '%T@ %p\n' | sort -n | cut -d' ' -f2-)
audoutput=""

for file in $audio_files; do
  language=$(echo $file | sed -n 's/.*audio_\(.*\)_afrag.mp4/\1/p')
  audoutput+="[+representation_id=${language},type=audio,language=${language}]${file} "
done
#echo $audoutput

video_files=$(find . -name '*_frag.mp4' -type f -printf '%T@ %p\n' | sort -n | cut -d' ' -f2-)
vidoutput=""

for file in $video_files; do
  resolution=$(echo $file | sed -n 's/.*-\([0-9]\{1,4\}p\)_frag.mp4/\1/p')
  vidoutput+="[+representation_id=${resolution},type=video]${file} "
done
#echo $vidoutput

# output as single file on random directory
bash "/path/to/Bento4/Source/Python/wrappers/mp4dash" --hls --no-split $audoutput $vidoutput --use-segment-timeline -o $(openssl rand -hex 8) 

#bkpush / rclone / rsync / mv / aws / curl / etc
#rm pkg.lck
