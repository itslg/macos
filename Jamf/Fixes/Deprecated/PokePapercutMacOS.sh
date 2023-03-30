#!/bin/sh
###################{ DEPRECATED }##################
### Name: Poke PaperCut macOS                   ###
### Author: MaverickMidori (Levi G)             ###
### Date Created: 2020-10-06                    ###
### Organisation: Avondale University           ###
### Use: Generic / Entity-Agnostic              ###
### Notes: Papercut does not authenticate       ###
###################################################
##  Levi's HardPokePapercutMacOS Script
##  This script will kill and relaunch all papercut services.

## Kill Application Server
sudo launchctl unload /Library/LaunchDaemons/papercut.plist 

## Kill Print Provider
sudo launchctl unload /Library/LaunchDaemons/papercut-event-monitor.plist

## Kill Web Print
sudo launchctl unload /Library/LaunchDaemons/papercut-web-print.plist

## Kill Mobility Print
sudo launchctl unload /Library/LaunchDaemons/pc-mobility-print.plist

## Kill Job Ticketing
sudo launchctl unload /Library/LaunchDaemons/pc-job-ticketing.plist

## Kill Print Deploy
sudo launchctl unload /Library/LaunchDaemons/papercut-print-deploy.plist

## Kill iOS Print (Legacy)
sudo launchctl unload /Library/LaunchDaemons/papercut-iosprint.plist

## Launch Application Server
sudo launchctl load /Library/LaunchDaemons/papercut.plist

## Launch Print Provider
sudo launchctl load /Library/LaunchDaemons/papercut-event-monitor.plist

## Launch Web Print
sudo launchctl load /Library/LaunchDaemons/papercut-web-print.plist

## Launch Mobility Print
sudo launchctl load /Library/LaunchDaemons/pc-mobility-print.plist

## Launch Job Ticketing
sudo launchctl load /Library/LaunchDaemons/pc-job-ticketing.plist

## Launch Print Deploy
sudo launchctl load /Library/LaunchDaemons/papercut-print-deploy.plist

## Launch iOS Print (Legacy)
sudo launchctl load /Library/LaunchDaemons/papercut-iosprint.plist
