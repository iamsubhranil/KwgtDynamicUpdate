#!/bin/sh

[ -d "~/storage/pictures" ] && echo "This script must be run in termux after running 'termux-setup-storage'!" && exit
[ -d ".username" ] && echo "Enter your GitHub username (cached locally): " && read uname && echo $uname > .username
[ -d ".password" ] && echo "Enter your GitHub password (cached locally): " && read passw && echo $passw > .password
cp -p "`ls -dtr1 ~/storage/pictures/Screenshots/* | tail -1`" ss1.png
cp -p "`ls -dtr1 ~/storage/pictures/Screenshots/* | tail -2 | head 1`" ss2.png
git add ss1.png ss2.png
git commit -m "wallpaper updated"
USERNAME=`cat .username`
PASSWORD=`cat .password`
git push https://$USERNAME:$PASSWORD@github.com/iamsubhranil/KwgtDynamicUpdate.git
echo "Push to GitHub complete! Wait for a few seconds and then update the backgrounds.."
