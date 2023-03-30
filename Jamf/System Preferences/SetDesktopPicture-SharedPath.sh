#!/bin/sh
###################################################
### Name: Set Desktop Picture                   ###
### Author: MaverickMidori (Levi G)             ###
### Date Created: 2021-06-15                    ###
### Organisation: Avondale University           ###
### Use: Generic / Entity-Agnostic              ###
### Notes: Reliant on Compose Package           ###
###################################################

## Runs Set Wallpaper Command after Policy to Install Package delivers Image to /Users/Shared/Wallpaper1.jpg
osascript -e 'tell application "Finder" to set desktop picture to POSIX file "/Users/Shared/Wallpaper1.jpg"'
