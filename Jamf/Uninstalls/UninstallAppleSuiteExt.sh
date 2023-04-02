#!/bin/sh
###################################################
### Name: Uninstall Apple Suite Extended        ###
### Author: MaverickMidori (Levi G)             ###
### Date Created: 2021-07-20                    ###
### Organisation: Avondale University           ###
### Use: Generic / Entity-Agnostic              ###
### Notes: Removes Extended Suite Applications  ###
###################################################
DirPath=/Applications/
appName=(
    'Pages'
    'Keynote'
    'Numbers'
    'iMovie'
    'Garageband'
)
function UninstallApp() {
    declare -a appName=("${!1}")
    for app in "${appName[@]}"
    do
        if [ -d $DirPath$app".app" ]; then
            rm -rf $DirPath$app".app" && echo "Uninstalling "$app".app"
        else
            echo $app" is not installed, proceeding with script..."
        fi
    done
}
# Invoke Function CloseApp with Array appName
UninstallApp appName[@]
