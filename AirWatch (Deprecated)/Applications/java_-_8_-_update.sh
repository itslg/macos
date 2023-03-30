#!/usr/bin/env bash

#########################
#Oracle Java 8 Update XXX
#########################

declare tempMountPoint='/tmp/mnt/'
declare dmgLocation='lmnas01.avondale.edu.au/Software/Java'
declare dmgFile='jdk-8u121-macosx-x64.dmg'
declare pkgLocation='/Volumes/JDK 8 Update 121/JDK 8 Update 121.pkg'
declare dmgVolume='/Volumes/JDK 8 Update 121'

##################################
#Remove Existing Java Installation
##################################
rm -f -r /Library/Internet\ Plug-Ins/JavaAppletPlugin.plugin
rm -f -r /Library/PreferencePanes/JavaControlPanel.prefPane
rm -f -r ~/Library/Application\ Support/Java

#############################
#Create Temporary Mount Point
#############################
mkdir "$tempMountPoint"

####################
#Mount Remote Server
####################
printf "Please Enter Your UserName e.g. s14054524: "
read -r userName
mount -t smbfs //"$userName"@"$dmgLocation" "$tempMountPoint"

############
#Mount *.dmg
############
hdiutil attach "$tempMountPoint$dmgFile"

##############
#Install *.pkg
##############
installer -pkg "$pkgLocation" -target /

#########
#Clean-Up
#########
hdiutil detach -force "$dmgVolume"
sleep .5
umount -f "$tempMountPoint"

############
#START NOTES
############

##########
#END NOTES
##########