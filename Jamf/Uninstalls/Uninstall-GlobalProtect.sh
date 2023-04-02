#!/bin/sh
###################################################
### Name: Uninstall GlobalProtect               ###
### Author: MaverickMidori (Levi G)             ###
### Date Created: 2020-09-10                    ###
### Organisation: Avondale University           ###
### Use: Generic / Entity-Agnostic              ###
### Notes: Calls Interal GP Uninstall Script    ###
###################################################
DirPath=/Applications/
App=GlobalProtect.app
ScriptPath=/Contents/Resources/uninstall_gp.sh
if [ -f $DirPath$App$ScriptPath ];
then $DirPath$ScriptPath && echo "Starting Uninstaller"
else echo "Uninstall Script not found..."
if [ -d $DirPath$App.app];
then rm -rf $DirPath$App.app && echo "Manually Removing "$App
else echo $App "not found..."
