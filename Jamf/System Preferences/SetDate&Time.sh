#!/bin/bash
###################################################
### Name: Set Date & Time                       ###
### Author: MaverickMidori (Levi G)             ###
### Date Created: 2021-06-29                    ###
### Organisation: Avondale University           ###
### Use: Generic / Entity-Agnostic              ###
### Notes: Post Install - System Level Tweak    ###
###################################################

# Toggles On Set time & Date automatically check box
sudo systemsetup -setusingnetworktime on
# Set Timezone to Australia - Sydney
sudo systemsetup -settimezone Australia/Sydney
# Set NTP Server to Apple's Asia NTP
sudo systemsetup -setnetworktimeserver time.asia.apple.com
# Updates the time against ntp server
sudo ntpdate -u time.asia.apple.com
exit 0
