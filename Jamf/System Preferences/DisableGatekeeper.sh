#!/bin/sh
###################################################
### Name: Disabled GateKeeper                   ###
### Author: MaverickMidori (Levi G)             ###
### Date Created: 2021-07-28                    ###
### Organisation: Avondale University           ###
### Use: Generic / Entity-Agnostic              ###
### Notes: Created from MasterPlaylist          ###
###################################################

# Disable Gatekeeper

spctl --master-disable

# Disable Gatekeeper's auto-rearm. Otherwise Gatekeeper
# will reactivate every 30 days. When it reactivates, it
# will be be set to "Mac App Store and identified developers"

/usr/bin/defaults write /Library/Preferences/com.apple.security GKAutoRearm -bool false
