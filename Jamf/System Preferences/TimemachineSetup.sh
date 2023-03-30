#!/bin/sh
###################################################
### Name: Setup Time Machine                    ###
### Author: MaverickMidori (Levi G)             ###
### Date Created: 2022-02-08                    ###
### Organisation: Avondale University           ###
### Use: Generic / Entity-Agnostic              ###
### Notes: Opens SysPref TM Pane, Startbackup   ###
###################################################
# Requires Self Service PPPC, Needs Terminal Access.
if osascript -e 'display alert "Ready to Backup?" message "Please Connect your Backup Drive." as critical buttons {"Stop", "Continue"} default button "Continue" cancel button "Stop"' == 'OK';
then
open -b com.apple.systempreferences /System/Library/PreferencePanes/Timemachine.prefPane
tmutil enable
sleep 10
tmutil startbackup
tmutil disable local

fi

# tell app "Self Service" to
# with icon caution
