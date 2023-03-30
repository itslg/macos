#!/bin/sh
###################################################
### Name: Uninstall Skype Home & Business        ###
### Author: MaverickMidori (Levi G)             ###
### Date Created: 2020-09-10                    ###
### Organisation: Avondale University           ###
### Use: Generic / Entity-Agnostic              ###
### Notes: Skype Business Uninstall Risky       ###
###################################################

## Create current user pwd variable
userdir=$(pwd)
echo $userdir
##SampleOutput
### /Users/levi_g/

## Uninstall Skype Home
rm -rf /Applications/Skype.app
rm -rf /Library/Internet\ Plug-Ins/MeetingJoinPlugin.plugin
defaults delete com.microsoft.Skype || true
rm -rf ~/Library/Containers/com.skype.skype.shareagent
rm -rf ~/Library/Logs/Skype
rm -rf ~/Library/Saved\ Application\ State/com.microsoft.Skype.savedState
rm -rf ~/Library/Preferences/com.microsoft.Skype.plist
rm -rf ~/Library/Application Support/Skype
rm -rf ~/Library/Caches/com.skype.skype
rm -rf ~/Library/Caches/skype.skype.Shiplt
rm -rf ~/Library/Preferences/com.skype.skype
rm -rf ~/Library/Cookies/com.skype.skype.binarycookies
rm -rf ~/Library/Cookies/com.skype.skype.binarycookies_tmp_429_0.dat
rm -rf /private/var/db/receipts/com.microsoft.Skype
rmdir ~/Library/Application\ Scripts/com.microsoft.Skype
find -f /private/var/db/BootCaches/* -name "app.com.microsoft.Skype*" -exec sudo rm -rf {} +

## Uninstall Skype for Business
# rm -rf /Applications/Skype\ for\ Business.app
# rm -rf /Library/Internet\ Plug-Ins/MeetingJoinPlugin.plugin
# defaults delete com.microsoft.SkypeForBusiness || true
# rm -rf ~/Library/Containers/com.microsoft.SkypeForBusiness
# rm -rf ~/Library/Logs/DiagnosticReports/Skype\ for\ Business_*
# rm -rf ~/Library/Saved\ Application\ State/com.microsoft.SkypeForBusiness.savedState
# rm -rf ~/Library/Preferences/com.microsoft.SkypeForBusiness.plist
# rm -rf ~/Library/Application\ Support/CrashReporter/Skype\ for\ Business_*
# rm -rf ~/Library/Application\ Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/com.microsoft.skypeforbusiness*
# rm -rf ~/Library/Cookies/com.microsoft.SkypeForBusiness*
# rm -rf /private/var/db/receipts/com.microsoft.SkypeForBusiness*
# rmdir ~/Library/Application\ Scripts/com.microsoft.SkypeForBusiness
# find -f /private/var/db/BootCaches/* -name "app.com.microsoft.SkypeForBusiness*" -exec sudo rm -rf {} +












