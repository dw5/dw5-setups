#!/bin/bash
# arhmk + arhread | arhvrn
# maker + maker stage 2 | rename maker
# f81337: purpose is to keep original file date and timestamps
# after file conversion to modern and efficient formats
# where filename (as in path) can't be changed
archivistlogfile="archivist.log"

# === read txt file === (yes you can go directly to this part and no log file)
# BUGFIX: filenames with too many spaces will be treated as access and other timestamps, thus fix by using highly unlikely §
while IFS=$'§\t\n' read -r key fAccess fModified fChanged fBirthday; do
    echo -e "File: $key | $fAccess | $fModified | $fChanged | $fBirthday |"
    # === change timestamp ===
    touch -at $fAccess $key    # access
    touch -mt $fModified $key  # modify
    echo "------"
done <$archivistlogfile
