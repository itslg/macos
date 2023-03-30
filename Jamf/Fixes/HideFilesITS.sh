#!/bin/sh
###################################################
### Name: Hide Jamf Files and ITS Account       ###
### Author: MaverickMidori (Levi G)             ###
### Date Created: 2021-03-11                    ###
### Organisation: Avondale University           ###
### Use: Avondale Specific (ITS)                ###
### Notes: ITS Script should be forked          ###
###################################################
## Hide the ITS Account off Login Window
defaults write /Library/Preferences/com.apple.loginwindow HiddenUsersList -array-add its

## Hide ITS User Folder
chflags hidden /Users/its

## Hide ~/Applications/Library
chflags hidden /Applications/Library

## Hide ~/Applications/private
chflags hidden /Applications/private

## Hide ~/Applications/PaperCut Print Deploy Client
chflags hidden /Applications/PaperCut\ Print\ Deploy\ Client


## Unhide ITS User Folder
# chflags nohidden /User/its


