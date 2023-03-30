#!/usr/bin/env bash
 
##############################
#Microsoft Office 2016 For Mac
##############################

declare tempMountPoint='/tmp/mnt/'
declare dmgLocation='lmnas01.avondale.edu.au/Software/Microsoft/Office/MAC'
declare dmgFile='SW_DVD5_Office_Mac_Standard_2016_MultiLang_-3_.iso_MLF_X20-52737.ISO'
declare pkgLocation='/Volumes/Office 2016 VL/Microsoft_Office_2016_Volume_Installer.pkg'
declare dmgVolume='/Volumes/Office 2016 VL'

printf "Please Enter Your Avondale UserName e.g. s14054524: "
read -r userName
 
#############################
#Create Temporary Mount Point
#############################
mkdir "$tempMountPoint"
 
####################
#Mount Remote Server
####################
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