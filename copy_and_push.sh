#!/bin/sh

[ -d "~/storage/pictures"] && echo "This script must be run in termux after running 'termux-setup-storage'!\n" && exit
cp -p "`ls -dtr1 ~/storage/Pictures/Screenshots/* | tail -1`" ss1.png
cp -p "`ls -dtr1 ~/storage/Pictures/Screenshots/* | tail -2 | head 1`" ss2.png
git add ss1.png ss2.png
git commit -m "wallpaper updated"
USERNAME=`cat .username`
PASSWORD=`cat .password`
git push https://$USERNAME:$PASSWORD@github.com/iamsubhranil/KwgtDynamicUpdate.git
echo "Push to GitHub complete! Wait for a few seconds and then update the backgrounds.."
