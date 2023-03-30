#!/usr/bin/env bash

######################################
#Create a bootable installer for macOS
######################################

while true; do

cat << BANNER

################################
# 1. Format An External Drive
# 2. Install MacOS Sierra
# 3. Install Mac OS X EL Capitan
# 4. Install Mac OS X Yosemite
# 5. Install Mac OS X Mavericks
# 6. Drop Back To The Shell
################################

BANNER

printf "Please Select An Option: "
read -r userOption

case $userOption in

"1")
diskutil list

printf "Please Enter A Disk Node e.g. /dev/disk1: "
read -r diskNode

printf "Please Enter A New Disk Name e.g. SANDISK: "
read -r diskName

sudo diskutil eraseDisk JHFS+ "$diskName" "$diskNode"
;;

"2")
printf "Please Enter A Volume Name e.g. SANDISK: "
read -r volumeName
declare binSierra='/Applications/Install macOS Sierra.app/Contents/Resources/createinstallmedia'
declare appSierra='/Applications/Install macOS Sierra.app'
sudo "$binSierra" --volume /Volumes/"$volumeName" --applicationpath "$appSierra"
;;

"3")
printf "Please Enter A Volume Name e.g. SANDISK: "
read -r volumeName
declare binELcap='/Applications/Install OS X El Capitan.app/Contents/Resources/createinstallmedia'
declare appELcap='/Applications/Install OS X El Capitan.app'
sudo "$binELcap" --volume /Volumes/"$volumeName" --applicationpath "$appELcap"
;;

"4")
printf "Please Enter A Volume Name e.g. SANDISK: "
read -r volumeName
declare binYosemite='/Applications/Install OS X Yosemite.app/Contents/Resources/createinstallmedia'
declare appYosemite='/Applications/Install OS X Yosemite.app'
sudo "$binYosemite" --volume /Volumes/"$volumeName" --applicationpath "$appYosemite"
;;

"5")
printf "Please Enter A Volume Name e.g. SANDISK: "
read -r volumeName
declare binMavericks='/Applications/Install OS X Mavericks.app/Contents/Resources/createinstallmedia'
declare appMavericks='/Applications/Install OS X Mavericks.app'
sudo "$binMavericks" --volume /Volumes/"$volumeName" --applicationpath "$appMavericks"
;;

"6")
exit
;;

*) printf "Invalid Option";;

esac

done

############
#START NOTES
############

##########################################################################################################################
#Reference:
##########################################################################################################################
#<https://developer.apple.com/legacy/library/documentation/Darwin/Reference/ManPages/man1/echo.1.html>
#"Applications aiming for maximum portability are strongly encouraged to use printf(1) to suppress the newline character."
##########################################################################################################################

##########
#END NOTES
##########