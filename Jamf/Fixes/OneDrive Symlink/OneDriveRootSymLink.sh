#!/bin/sh
###################################################
### Name: OneDrive Root Sym Link                ###
### Author: MaverickMidori (Levi G)             ###
### Date Created: 2021-09-04                    ###
### Organisation: Avondale University           ###
### Use: Generic / Entity-Agnostic              ###
### Notes: Dynamic Script - Don't Edit Plz      ###
###################################################

grabConsoleUserAndHome(){

    # don't assume the home folder is equal to the user's name
    CURRENT_USER=""
    CURRENT_USER=$(stat -f %Su "/dev/console")
    HOME=$(dscl . read /Users/"$CURRENT_USER" NFSHomeDirectory | cut -d ':' -f2 | cut -d ' ' -f2)
    if [ "$HOME" == "" ]; then
        if [ -d "/Users/$CURRENT_USER" ]; then
            HOME="/Users/$CURRENT_USER"
        else
            HOME=$(eval echo "~$CURRENT_USER")
        fi
    fi
}
grabConsoleUserAndHome

oneDriveRoot=$(echo "$HOME/OneDrive - CompanyName")

#Create directory if doesnt exist, incase they havent signed into OneDrive, then users just adopt this location on sign in.
mkdir -p "$oneDriveRoot"
chown -R $CURRENT_USER:staff "$oneDriveRoot"
chmod -R 700 "$oneDriveRoot"

mv $HOME/Desktop "$oneDriveRoot/Desktop"
mv $HOME/Documents "$oneDriveRoot/Documents"

su $CURRENT_USER -c "ln -s '$oneDriveRoot/Desktop' $HOME/"
su $CURRENT_USER -c "ln -s '$oneDriveRoot/Documents' $HOME/"

killall cfprefsd
