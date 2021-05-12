#!/bin/bash

if [ ! -e "$HOME/storage/pictures" ];
then
    echo "This script must be run in termux after running 'termux-setup-storage'!"
    exit
fi
if [ ! -e "$HOME/storage/shared" ];
then
    echo "This script must be run in termux after running 'termux-setup-storage'!"
    exit
fi
if [ ! -e "$HOME/storage/pictures/Screenshots" ];
then
    echo "This script requires the screenshot directory to be present!"
    exit
fi
if [ ! -f ".last_image" ];
then 
    touch .last_image
fi
new_image=`ls -dtr1 $HOME/storage/pictures/Screenshots/* | tail -1`
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
FOLDER=$HOME/storage/shared/Kustom/BlurBacks
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
