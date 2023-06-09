#!/bin/bash

###################################################
### Name: Last Timemachine Backup               ###
### Author: MaverickMidori (Levi G)             ###
### Date Created: 2021-07-20                    ###
### Organisation: Avondale University           ###
### Use: Generic / Entity-Agnostic              ###
### Notes: Requires Extension Attribute         ###
###################################################

#############[ VARIABLE DEFINITIONS ]##############

dateBackup="No Time Machine Backups"
macOS=$(sw_vers | awk '/ProductVersion/{print substr($2,1,5)}' | tr -d ".")
pathPlistNew="/Library/Preferences/com.apple.TimeMachine.plist"
pathPlistOld="/private/var/db/.TimeMachine.Results.plist"

#################[ SCRIPT BEGINS ]#################


function main {
    # Check the OS to determine where to look.
    if [ "$macOS" -ge "109" ]; then
        # If Auto Backup is enabled, get the Time Machine last backup date.
        checkAutoBackup=$(defaults read "$pathPlistNew" | awk '/AutoBackup/{print $3}' \
        | tr -d ";")
        if [ "$checkAutoBackup" = "1" ]; then
            dateBackup=$(defaults read "$pathPlistNew" Destinations | \
            sed -n '/SnapshotDates/,$p' | grep -e '[0-9]' | awk -F '"' '{print $2}' | sort \
            | tail -n1 | cut -d" " -f1,2)
            if [ "$dateBackup" = "" ]; then
                dateBackup="Initial Backup Incomplete"
            fi
        fi
    else
        if [ -e "$pathPlistOld" ]; then
            dateBackup=$(defaults read "$pathPlistOld" "BACKUP_COMPLETED_DATE")
            if [ "$dateBackup" = "" ]; then
                dateBackup="Initial Backup Incomplete"
            fi
        fi
    fi
    # Report the result to the JSS.
    echo "$dateBackup"
}

################[ FUNCTION CALLS ]################

main
