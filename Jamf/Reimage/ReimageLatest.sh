###################################################
### Name: Reimage to latest version of macOS    ###
### Author: MaverickMidori (Levi G)             ###
### Date Created: 2021-07-20                    ###
### Organisation: Avondale University           ###
### Use: Generic / Entity-Agnostic              ###
### Notes: Must be paired with Erase Policy     ###
###################################################

#Reset Ignored Software Update Policy

sudo softwareupdate --reset-ignored

#Download latest macOS Full Installer

sudo softwareupdate --fetch-full-installer
