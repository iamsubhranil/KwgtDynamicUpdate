#!/bin/sh

[ ! -d "~/storage/pictures" ] && echo "This script must be run in termux after running 'termux-setup-storage'!" && exit
[ ! -d "~/storage/shared" ] && echo "This script must be run in termux after running 'termux-setup-storage'!" && exit
[ ! -d "~/storage/pictures/Screenshots" ] && echo "This script requires the screenshot directory to be present!" && exit
[ ! -d ".last_image" ] && touch .last_image
new_image=`ls -dtr1 ~/storage/pictures/Screenshots/* | tail -1`
cmp "$new_image" .last_image
if [[ $? = 0 ]]
then
    echo "Image not changed! Exiting.."
    exit
fi
mv ss1.png local_ss1.png
cp -p "$new_image" ss1.png
cp ss1.png .last_image
python crop_wallpaper.py $1
FOLDER=~/storage/shared/Kustom/BlurBacks
mkdir -p $FOLDER
mv date.png $FOLDER
mv music.png $FOLDER
mv weather.png $FOLDER
mv gmail.png $FOLDER
mv reddit.png $FOLDER
mv youtube.png $FOLDER
mv spotify.png $FOLDER
mv local_ss1.png ss1.png
echo "Crop complete! Refresh your backgrounds!"
