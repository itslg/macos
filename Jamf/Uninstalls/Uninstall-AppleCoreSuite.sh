#!/bin/sh
###################################################
### Name: Uninstall Apple Suite Core            ###
### Author: MaverickMidori (Levi G)             ###
### Date Created: 2020-09-24                    ###
### Organisation: Avondale University           ###
### Use: Generic / Entity-Agnostic              ###
### Notes: Only Removes Core 3 Applications     ###
###################################################
DirPath=/Applications/
appName=(
    'Pages'
    'Keynote'
    'Numbers'
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
