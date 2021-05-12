#!/bin/sh

[ -d "~/storage/pictures" ] && echo "This script must be run in termux after running 'termux-setup-storage'!" && exit
[ -d ".username" ] && echo "Enter your GitHub username (cached locally): " && read uname && echo $uname > .username
[ -d ".password" ] && echo "Enter your GitHub password (cached locally): " && read passw && echo $passw > .password
new_image=`ls -dtr1 ~/storage/pictures/Screenshots/* | tail -1`
cmp "$new_image" ss1.png
if [[ $? = 0 ]]
then
    echo "Image not changed! Exiting.."
fi
cp -p "$new_image" ss1.png
git add ss1.png
git commit -m "wallpaper updated"
USERNAME=`cat .username`
PASSWORD=`cat .password`
git push https://$USERNAME:$PASSWORD@github.com/iamsubhranil/KwgtDynamicUpdate.git
echo "Push to GitHub complete! Wait for a few seconds and then update the backgrounds.."
