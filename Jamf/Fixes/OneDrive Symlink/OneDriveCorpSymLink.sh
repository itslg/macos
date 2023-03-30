#!/bin/sh
###################################################
### Name: OneDrive SymLink Script v1.0          ###
### Author: MaverickMidori (Levi G)             ###
### Date Created: 2021-09-04                    ###
### Organisation: Avondale University           ###
### Use: Generic / Entity-Agnostic              ###
### Notes: Create User Variable from RootSymlink###
###################################################

## Script moves ~/ (Home Directory) to the OneDrive Folder.
## SymLinkDirection = HomeDir on OneDrive. SymLink home folders --> OneDrive. (Spoof existence of Home Folders)
## Mandatory: Download and Sign-in to OneDrive on the Mac.
#Change to the user
cd /Users/levi_g/

mv Desktop/ 'OneDrive - Avondale Univeristy College/Levi-iMac/'
mv Documents/ 'OneDrive - Avondale Univeristy College/Levi-iMac/'
mv Downloads/ 'OneDrive - Avondale Univeristy College/Levi-iMac/'
mv Movies/ 'OneDrive - Avondale Univeristy College/Levi-iMac/'
mv Music/ 'OneDrive - Avondale Univeristy College/Levi-iMac/'
mv Pictures/ 'OneDrive - Avondale Univeristy College/Levi-iMac/'

ln -s 'OneDrive - Avondale Univeristy College/Levi-iMac/Desktop'
ln -s 'OneDrive - Avondale Univeristy College/Levi-iMac/Documents'
ln -s 'OneDrive - Avondale Univeristy College/Levi-iMac/Downloads'
ln -s 'OneDrive - Avondale Univeristy College/Levi-iMac/Movies'
ln -s 'OneDrive - Avondale Univeristy College/Levi-iMac/Music'
ln -s 'OneDrive - Avondale Univeristy College/Levi-iMac/Pictures'
