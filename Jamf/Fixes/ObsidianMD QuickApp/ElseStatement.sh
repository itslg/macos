#!/bin/bash

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
            echo "User aborted. Exiting..."
            exit 1
        fi
        # Opens WebPage to Obsidian.md
        echo "User Selected Install >> Opening WebPage"
        open https://obsidian.md
