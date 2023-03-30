#!/bin/sh
###################################################
### Name: Create Mobile Account OSAscript       ###
### Author: MaverickMidori (Levi G)             ###
### Date Created: 2021-07-20                    ###
### Organisation: Avondale School               ###
### Use: Avondale School create mobile account  ###
### Notes: Can be forked for local account      ###
###         is alternative to prestage account  ###
###################################################

userName=$(osascript << EOF
text returned of (display dialog "Enter the Username for this device" default answer "101234" buttons {"OK"} default button 1)

EOF)

sudo /System/Library/CoreServices/ManagedClient.app/Contents/Resources/createmobileaccount -n "$userName" -h /Volumes/Data/Users/"$userName" -D
