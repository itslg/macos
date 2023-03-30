#!/bin/sh
###################################################
### Name: Clear Wireless Preferences            ###
### Author: MaverickMidori (Levi G)             ###
### Date Created: 2020-09-16                    ###
### Organisation: Avondale University           ###
### Use: Generic / Entity-Agnostic              ###
### Notes: Creates a backup zip before removal  ###
###################################################

cd /Library/Preferences/SystemConfiguration/

## Create backup of .plist files
sudo zip backup.zip \
         com.apple.airport.preferences.plist       \
         com.apple.network.identification.plist    \
         com.apple.wifi.message-tracer.plist       \
         NetworkInterfaces.plist preferences.plist

## Delete .plist files
sudo rm  com.apple.airport.preferences.plist       \
         com.apple.network.identification.plist    \
         com.apple.wifi.message-tracer.plist       \
         NetworkInterfaces.plist preferences.plist

## Reboot to Regenerate plists
sudo shutdown -r now

## Log Back In, Setup Avondale Network & Staff Wireless + Inform home Wireless Passwords may be removed.
