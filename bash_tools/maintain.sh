
# linux
mkdir recoded; for i in *.mp4; do ffmpeg -i "$i" "./recoded/${i%.*}-recoded.mp4"; done
mkdir recoded; for i in *.m4a; do ffmpeg -i "$i" "${i%.*}-recoded.mp3"; done
mkdir recoded; mogrify -format jpg -path ./recoded *.png # turbo
mkdir recoded; mogrify -format avif -path ./recoded *.png # do in bg, slow

#gif2AV1 ffmpeg -i x -c:v libaom-av1 -b:v 200k failed-test.mp4

` fdupes -SrdN . ` # dont ask just do it
` fdupes -Srd . ` # see all files before delete

# windows
mkdir recoded    & mogrify -format jpg -path ./recoded *.png
mkdir avif    & mogrify -format avif -path ./avif *.png
mkdir recodedvid && FOR %y IN (*.webm) DO @ffmpeg -i "%y" "./recodedvid/%y-recoded.mp4"

FOR %y IN (*.wav) DO @ffmpeg -i "%y" "%y-recoded.opus"
FOR %y IN (*.opus) DO @ffmpeg -i "%y" "%y-recoded.mp3"
FOR %y IN (*.mp4) DO @ffmpeg -i "%y" "%y-recoded.mp4"
FOR %y IN (*.avi) DO @ffmpeg -i "%y" "%y-recoded.mp4"
FOR %y IN (*.webm) DO @ffmpeg -i "%y" "%y-recoded.mp4"

# windows count cli
dir *.mp4 /b /a-d | find /c /v ""

# BLITZ
ffmpeg -i x.p -acodec mp3 -vcodec copy p.x
yt-dlp -f mp4 -S res:360
yt-dlp -f -
yt-dlp --merge-output-format mp4

# tool goodies
yt-dl --write-subs --write-auto-subs --embed-subs --write-thumbnail --write-description --write-info-json --compat-options no-live-chats
https://github.com/overcast07/wayback-machine-spn-scripts/blob/main/spn.sh
-vf scale=3840:2160 # to 4K in order to better preserve <720p videos on video platforms

wget -e robots=off
spn.sh -p 1 tree.txt

# ffmpeg mass main directory, output will create new folders if needed
ffenmass -i /home/ubuntu/swine-voices-en -ext wav /home/ubuntu/swine-voices-en-wav

tree -if $PWD # "wget -m" to file list. might want to edit out the place you ran this command (e.g. /home/user/temp/projectWA/some.website.com)
tree PATH -H http://localhost -o out.html
ls -fR $PWD/* # also does the job but is more sucky, files in subdirectories will have ': \n . ..'
