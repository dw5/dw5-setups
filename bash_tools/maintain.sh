# rclone
-P --transfers=1 --checkers 1 --multi-thread-streams 0  --modify-window 2s

# linux
mkdir recoded; for i in *.mp4; do ffmpeg -i "$i" "./recoded/${i%.*}-recoded.mp4"; done
mkdir recoded; for i in *.m4a; do ffmpeg -i "$i" "./recoded/${i%.*}-recoded.mp3"; done
mkdir recoded; mogrify -format jpg -path ./recoded *.png # turbo PNG2JPG (no alpha)
mkdir recoded; mogrify -format avif -path ./recoded *.png # do in bg, slow PNG2AVIF (no alpha transperancy)

FOR %y IN (*.png) DO @cavif "%y"  # imagemagick sometimes output broken avif (unreadable, unusable)
cavif *.png && mkdir avifout && mv *.avif avifout

#gif2AV1 ffmpeg -i x -c:v libaom-av1 -b:v 200k failed-test.mp4
ffmpeg -y -i path_to_your.gif -vsync 0 -pix_fmt yuv420p -f yuv4mpegpipe - | ./rav1e - -o - > path_to_your.avifs #gif2avif #src: https://gif2avif.com/how-it-works/

` fdupes -SrdN . ` # dont ask just do it
` fdupes -Srd . ` # see all files before delete

ffmpeg -ss 00:20:50 -i "abc.mp4" -vn -acodec copy abc.webm
ffmpeg -ss 00:20:50 -i "abc.mp4" abc.wav


SH curl -H "Content-Type: application/json" -d '{"username": "test", "content": "hello"}' XYZ
WIN curl -H "Content-Type: application/json" -d "{\"username\": \"test\", \"content\":\"hello\"}" %WEBHOOK_URL%


ssh sv01.nty -p 2023 -l testing -i sshkey.private
crontab -e
0 1 * * * rclone copy --bwlimit 41.67M --max-size 1G source:path destination:path >> /var/log/rclone.log 2>&1

rclone ls --include "*examplefile*" remote:  # https://forum.rclone.org/t/what-is-the-fastest-way-to-search-for-and-download-specific-files-using-rclone/11089

# https://devhints.io/screen
screen -S <abc>
screen -r <abc>

# windows
mkdir recoded    & mogrify -format jpg -path ./recoded *.png
mkdir avif    & mogrify -format avif -path ./avif *.png
mkdir recodedvid && FOR %y IN (*.webm) DO @ffmpeg -i "%y" "./recodedvid/%y-recoded.mp4"

FOR %y IN (*.wav) DO @ffmpeg -i "%y" "%y-recoded.opus"
FOR %y IN (*.opus) DO @ffmpeg -i "%y" "%y-recoded.mp3"
FOR %y IN (*.mp4) DO @ffmpeg -i "%y" "%y-recoded.mp4"
FOR %y IN (*.avi) DO @ffmpeg -i "%y" "%y-recoded.mp4"
FOR %y IN (*.webm) DO @ffmpeg -i "%y" "%y-recoded.mp4"

# too heavy for imgmagick
mkdir avifaomff; for i in *.jpg; do ffmpeg -i "$i" -c:v libaom-av1 -still-picture 1 "./avifaomff/${i%.*}.avif"; done
mkdir avifaomff; for i in *.png; do ffmpeg -i "$i" -c:v libaom-av1 -still-picture 1 "./avifaomff/${i%.*}.avif"; done
mkdir avifaomff & FOR %y IN (*.jpg) DO @ffmpeg -i "%y" -c:v libaom-av1 -still-picture 1 "./avifaomff/%y.avif"
mkdir avifaomff & FOR %y IN (*.png) DO @ffmpeg -i "%y" -c:v libaom-av1 -still-picture 1 "./avifaomff/%y.avif"

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
