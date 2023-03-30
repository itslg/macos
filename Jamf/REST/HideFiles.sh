#!/bin/sh
# Hide User (Old Method)
# defaults write /Library/Preferences/com.apple.loginwindow HiddenUsersList -array-add its
#--------------------------------------------------------------------------
# Function to Hide the User Account - SysPref Pane, Directory & Login Window
hide_user () {
if [ -d $1 ]; then
dscl . create $1 IsHidden 1
echo "$2 is now Hidden"
else
echo "Error: No $2 account found. Run Local Administrator Policy (ID63)"
}
# Run Function with Variables
# func_name $VAR1 $VAR2
hide_user /Users/sadmin SADMIN
hide_user /Users/badmin BADMIN
hide_user /Users/tadmin TADMIN
hide_user /Users/ITS ITS
#---------------------------------------------------------------------------
# Function to Hide a Specified Directory - Chflags
hide_directory () {
if [ -d $1]; then
chflags hidden $1
else
echo "$1 does not exist..."
}
hide_directory /Applications/Library
hide_directory /Applications/private
hide_directory /Applications/PaperCut\ Mobility\ Print\ Client
hide_directory /Applications/PaperCut\ Print\ Deploy\ Client
---------------------------------------------------------------------------
