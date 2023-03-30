#!/bin/sh
###################################################
### Name: Disable Recent Applications in Dock   ###
### Author: MaverickMidori (Levi G)             ###
### Date Created: 2021-07-21                    ###
### Organisation: Avondale University           ###
### Use: Generic / Entity-Agnostic              ###
### Notes: Kill Dock if user logged in          ###
###################################################
user=`ls -la /dev/console | cut -d " " -f 4`
sudo -u $user defaults write com.apple.dock show-recents -bool FALSE
sudo -u $user killall Dock
