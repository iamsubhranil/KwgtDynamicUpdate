#!/bin/sh

[ -d "~/storage/pictures" ] && echo "This script must be run in termux after running 'termux-setup-storage'!" && exit
[ -d ".username" ] && echo "Enter your GitHub username (cached locally): " && read uname && echo $uname > .username
[ -d ".token" ] && echo "Enter your GitHub token (cached locally): " && read tkn && echo $tkn > .token
new_image=`ls -dtr1 ~/storage/pictures/Screenshots/* | tail -1`
cmp "$new_image" ss1.png
if [[ $? = 0 ]]
then
    echo "Image not changed! Exiting.."
    exit
fi
cp -p "$new_image" ss1.png
git add ss1.png
git commit -m "wallpaper updated"
USERNAME=`cat .username`
TOKEN=`cat .token`
git push https://$USERNAME:$TOKEN@github.com/iamsubhranil/KwgtDynamicUpdate.git
echo "Push to GitHub complete! Wait for a few seconds and then update the backgrounds.."
