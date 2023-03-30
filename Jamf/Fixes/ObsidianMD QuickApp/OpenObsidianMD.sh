#!/bin/sh
#   OpenObsidianMD.sh
#   Created by MaverickMidori on 2022-04-19-1132
#   Script is used to trigger markdown database rather than macOS Notes.
AppName="Obsidian"
VarPath="/Applications/Obsidian.app"
    if test -d $VarPath; then
        echo "$AppName is Installed >> Opening $AppName"
        open /Applications/Obsidian.app
    else
        # Call AppleScript via OSA
        osascript >/dev/null 2>&1 <<-EOF
            tell application "Terminal"
                set AppName to "Obsidian"
                set myMsg to "Uh Oh!" & return & return & AppName & " is not currently installed..." & return & return & "Would you like to install it?"
                set theResp to display dialog myMsg buttons {"Cancel", "Yes Please!"} default button 2 with icon stop
            end tell
            # Following
            if button returned of theResp is "Cancel" then
                return 1
            end if
EOF
        # Check Status of OSA
        if [ "$?" != "0" ] ; then
            echo "User cancelled. Exiting..."
            exit 1
        fi
        # Opens WebPage to Obsidian.md
        echo "User Selected Install >> Opening WebPage"
        open https://obsidian.md
    fi
exit
