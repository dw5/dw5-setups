#!/bin/bash
# f81337: purpose is to keep original file date and timestamps
# after file conversion to modern and efficient formats
# where filename (as in path) can't be changed
# PRO TIP: hey if you can, use archivist-renamer where it will use earliest date and apply to file

#get file timestamps
archivistlogfile="archivist.log"
rm $archivistlogfile
for curFile in *; do
if [ -f "${curFile}" ]; then #only FILES, no folders // -d directories -f files
# unix timestamp seconds 1128674280 (test file input: touch -t 200510071138 2005 10 7 11:38:00)
# to make touch command friendly and more human readable
# $(date -d @<stat unix output> +%Y%m%d%H%M)
# is done before writing output. (otherwise this would be needed to be done again when using touch)
    curFileAXtime=$(date -d @$(stat -c %X "$curFile") +%Y%m%d%H%M.%S)  # access
    curFileMDtime=$(date -d @$(stat -c %Y "$curFile") +%Y%m%d%H%M.%S)  # modify
    curFileCGtime=$(date -d @$(stat -c %Z "$curFile") +%Y%m%d%H%M.%S)  # change -- kinda useless, kinda same as birth
    curFileBWtime=$(date -d @$(stat -c %W "$curFile") +%Y%m%d%H%M.%S)  # birth -- kinda useless, birth as in day when transfered to device on which you currently have it. "inode"
    #if (( curFileMtime < timestamp )); then
    echo "'$curFile' $curFileAXtime $curFileMDtime $curFileCGtime $curFileBWtime"
    echo "'$curFile'§$curFileAXtime§$curFileMDtime§$curFileCGtime§$curFileBWtime">>$archivistlogfile
    #fi
fi
done
#read txt file
# BUGFIX: filenames with too many spaces will be treated as access and other timestamps, thus fix by using highly unlikely §
while IFS=$'§\t\n' read -r key fAccess fModified fChanged fBirthday; do
    echo -e "File: $key | $fAccess | $fModified | $fChanged | $fBirthday |"
    #change timestamp
    touch -at $fAccess $key    # access
    touch -mt $fModified $key  # modify
    echo "------"
done <$archivistlogfile
exit 1
