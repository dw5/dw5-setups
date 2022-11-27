#!/bin/bash
# arhmk + arhread | arhvrn
# maker + maker stage 2 | rename maker
# f81337: purpose is to keep original file date and timestamps
# after file conversion to modern and efficient formats
# PRO TIP: hey if you can, use archivist if you can't change paths

# === get file timestamps ===
archivistlogfile="archivist.log"
renametodolist="archvst-todo.log" # so whatever it got changed to can be edited in text editor, you wont apply it to .wmv when there is .av1 ? :D
rm $archivistlogfile
rm $renametodolist
for curFile in *; do
if [ -f "${curFile}" ]; then #only FILES, no folders // -d directories -f files
# to make touch command friendly and more human readable
# $(date -d @<stat unix output> +%Y%m%d%H%M)
    curFileAXtime=$(stat -c %X "$curFile") # access
    curFileMDtime=$(stat -c %Y "$curFile") # modify
    #echo "'$curFile' $curFileAXtime $curFileMDtime"
    #echo "'$curFile'§$curFileAXtime§$curFileMDtime§">>$archivistlogfile

if (( $curFileAXtime > $curFileMDtime )); then
echo "$curFile $curFileAXtime is more than Modify $curFileMDtime"
echo "mv '$curFile' '$(date -d @$curFileAXtime +%Y%m%d%H%M)-$curFile'">>$renametodolist
else
echo "$curFile $curFileMDtime is more than Access $curFileAXtime"
echo "mv '$curFile' '$(date -d @$curFileMDtime +%Y%m%d%H%M)-$curFile'">>$renametodolist
fi

fi
done
exit 1
