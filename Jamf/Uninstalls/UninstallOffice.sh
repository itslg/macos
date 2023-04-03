#!/bin/sh
###################################################
### Name: Uninstall Office365 + Office 2016     ###
### Author: MaverickMidori (Levi G)             ###
### Date Created: 2021-05-19                    ###
### Organisation: Avondale University           ###
### Use: Generic / Entity-Agnostic              ###
### Notes: Created from MS Documentation        ###
###################################################
USERNAME=$(ls -l /dev/console | awk '{print $3}')
# Check Privledges
if [[ $EUID -ne 0 ]]; then
    echo -e "
    ROOT PRIVILEDGES NEEDED!
    You have to run this script as root.
    Aborting...
    "
    exit 1
else
    echo -e "
    ###################################
      Office 365 for Mac uninstaller
    ###################################
    "
    sleep 4
    echo -e "
    ------------- WARNING -------------
      Your Outlook data will be wiped.
     Press CTRL+C in 5 seconds to ABORT
    -----------------------------------
    "
    sleep 6
    # commands out of the official guide from microsoft
    # source https://support.office.com/en-us/article/Uninstall-Office-2016-for-Mac-eefa1199-5b58-43af-8a3d-b73dc1a8cae3
### Uninstall Applications ###
AppPath="/Applications/"
AppRemove=(
    'Microsoft Excel'
    'Microsoft OneNote'
    'Microsoft Outlook'
    'Microsoft PowerPoint'
    'Microsoft Word'
    'Microsoft OneDrive'
    'Microsoft Teams'
)
function UninstallApps() {
    declare -a AppRemove=("${!1}")
    for app in "${AppRemove[@]}"
    do
        if [ -d $AppPath$app.app]; then
            echo "    Removing Office 365 apps..." && rm -rf $AppPath$App.app
        else
            echo $app" not found, proceeding with script..."
        fi
    done
}
# Invoke Function CloseApp with Array appName
UninstallApps AppRemove[@]

### Clean Library Files ###
LibPath="/Library/"
LibRemove=(
    'Application Support/Microsoft/MAU2.0'
    'Fonts/Microsoft'
    'LaunchDaemons/com.microsoft.office.licensing.helper.plist'
    'LaunchDaemons/com.microsoft.office.licensingV2.helper.plist'
    'Preferences/com.microsoft.Excel.plist'
    'Preferences/com.microsoft.office.plist'
    'Preferences/com.microsoft.office.setupassistant.plist'
    'Preferences/com.microsoft.outlook.databasedaemon.plist'
    'Preferences/com.microsoft.outlook.office_reminders.plist'
    'Preferences/com.microsoft.Outlook.plist'
    'Preferences/com.microsoft.PowerPoint.plist'
    'Preferences/com.microsoft.Word.plist'
    'Preferences/com.microsoft.office.licensingV2.plist'
    'Preferences/com.microsoft.autoupdate2.plist'
    'Preferences/com.microsoft.OneDriveUpdater'
    'Preferences/com.microsoft.OneDriveStandaloneUpdater'
    'Preferences/com.microsoft.OneDrive.plist'
    'Preferences/com.microsoft.teams'
    'Preferences/ByHost/com.microsoft*'
    'Receipts/Office2016_*'
    'PrivilegedHelperTools/com.microsoft.office.licensing.helper'
    'PrivilegedHelperTools/com.microsoft.office.licensingV2.helper'
)
function CleanLibs() {
    declare -a LibRemove=("${!1}")
    for lib in "${LibRemove[@]}"
    do
        if [ -f ]; then
            echo echo "    Cleaning system folders..." && rm -rf $LibPath$lib
        else
            echo $lib" not found, proceeding with script..."
        fi
    done
}
# Invoke Function CleanLibraries with Array LibRemove
CleanLibs LibRemove[@]

### Forget Office Suite in PKG Utility ###
pkg=(
    'Fonts'
    'Microsoft_AutoUpdate.app'
    'Microsoft_Excel.app'
    'Microsoft_OneNote.app'
    'Microsoft_Outlook.app'
    'Microsoft_PowerPoint.app'
    'Microsoft_Word.app'
    'Microsoft_OneDrive.app'
    'Microsoft_Teams.app'
    'Proofing_Tools'
    'licensing'
)
function PkgForget() {
    declare -a pkg=("${!1}")
    for lib in "${pkg[@]}"
    do
        echo "    Making your Mac forget about Office 2016..." && pkgutil --forget com.microsoft.package.$pkg
    done
}
PkgForget pkg[@]
    echo -e "
    Complete!
    Please Note: You may need to reinstall Microsoft Silverlight.
    You can now remove icons from Dock (if any!).
    "
fi
