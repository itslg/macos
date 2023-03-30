#!/bin/sh

###################################################
### Name: Uninstall PaperCut Clean              ###
### Author: MaverickMidori (Levi G)             ###
### Date Created: 2020-09-30                    ###
### Organisation: Avondale University           ###
### Use: Generic / Entity-Agnostic              ###
### Notes:                                      ###
###################################################


#  Unload the Papercut Client
launchctl unload /Library/LaunchAgents/com.papercut.client.plist
sudo rm /Library/LaunchAgents/com.papercut.client.plist

#   Unload Papercut Services
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

#   Removes Login Start Hook
sudo defaults delete com.apple.loginwindow LoginHook

# Delete PaperCut Client Application
rm -rf /Applications/pcclient.app
rm -rf /Applications/papercut.app
rm -rf /Applications/papercutclient.app
