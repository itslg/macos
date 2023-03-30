###################################################
### Name: Reimage to macOS 10.15.7 Catalina     ###
### Author: MaverickMidori (Levi G)             ###
### Date Created: 2021-07-20                    ###
### Organisation: Avondale University           ###
### Use: Generic / Entity-Agnostic              ###
### Notes: Must be paired with Erase Policy     ###
###################################################

# Remove - Remove Forcibly the following Applications
#Reset Ignored Software Update Policy

sudo softwareupdate --reset-ignored

#Download macOS Catalina 10.15.7

sudo softwareupdate --fetch-full-installer --full-installer-version 10.15.7
