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


# Clean Uninstall Skype for Business
#################
### Variables ###
#################
# Items at the system level to be removed
systemItems=(
    /private/var/db/receipts/com.microsoft.SkypeForBusiness*
    /Applications/Skype\ for\ Business.app
    /Library/Internet\ Plug-Ins/MeetingJoinPlugin.plugin

)
# Items at the user level to be removed
userItems=(
    Applications/SkypeForBusiness.app
    Downloads/SkypeForBusiness*
    Library/Containers/com.microsoft.SkypeForBusiness
    Library/Logs/DiagnosticReports/Skype\ for\ Business_*
    Library/Saved\ Application\ State/com.microsoft.SkypeForBusiness.savedState
    Library/Preferences/com.microsoft.SkypeForBusiness.plist
    Library/Application\ Support/CrashReporter/Skype\ for\ Business_*
    Library/Application\ Support/com.apple.sharedfilelist/com.apple.LSSharedFileList.ApplicationRecentDocuments/com.microsoft.skypeforbusiness*
    Library/Cookies/com.microsoft.SkypeForBusiness*
    Library/Application\ Scripts/com.microsoft.SkypeForBusiness
)
#################
### Functions ###
#################
function deleteItems()
{
declare -a toDelete=("${!1}")
for item in "${toDelete[@]}"
  do
    if [[ ! -z "${2}" ]]
    then
      item=("${2}""${item}")
    fi
      echo "Looking for $item"
    if [ -e "${item}" ]
    then
      echo "Removing $item"
      rm -rf "${item}"
    fi
done
}
####################
### Main Program ###
####################
echo "Killing Skype for Business"
killall "Skype for Business"
# Delete system level items
deleteItems systemItems[@]
# Investigate Integrating these two lines >_>
/private/var/db/BootCaches/* -name "app.com.microsoft.SkypeForBusiness*" -exec sudo rm -rf {} +
defaults delete com.microsoft.SkypeForBusiness
# Delete user level items
for dirs in /Users/*/
  do
    deleteItems userItems[@] "${dirs}"
  done
exit 0
