#!/bin/sh
# Script is intended for Avondale University's Jamf Instance
########################[ Section One: Pre-flight Checks ]#########################
# Check if Setup Assistant is running
SetupAssistance_process=$(/bin/ps auxww | grep -q "[S]etup Assistant.app")
while [ $? -eq 0 ]
do
    /bin/echo "Setup Assistant Still Running... Sleep for 2 seconds..."
    /bin/sleep 120
    SetupAssistance_process=$(/bin/ps auxww | grep -q "[S]etup Assistant.app")
done
osascript -e "display dialog\"Ready to install 'Avondale Universities - Standard Operating Environment'?"\"
if [ "$?" != "0" ] ; then
   echo "User aborted. Exiting..."
   exit
fi
########################[ Section Two: Tweaking & Optimisation ]#########################
### Defaults Write Commands ###
defaultwrite=(
# Location - Enable Location Services
"/var/db/locationd/Library/Preferences/ByHost/com.apple.locationd LocationServicesEnabled -bool true; /bin/launchctl kickstart -k system/com.apple.locationd 2>&1"
# Date & Time - Enable Automatic Timezone
"/Library/Preferences/com.apple.timezone.auto Active -bool YES"
"/private/var/db/timed/Library/Preferences/com.apple.timed.plist TMAutomaticTimeOnlyEnabled -bool YES"
"/private/var/db/timed/Library/Preferences/com.apple.timed.plist TMAutomaticTimeZoneEnabled -bool YES"
# Printing - Set Paper to A4
"/Library/Preferences/org.cups.PrintingPrefs DefaultPaperID iso-a4"
# TimeMachine - Disable Timemachine Setup Prompt when drive connected
"/Library/Preferences/com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true"
"/Library/Preferences/com.apple.TimeMachine RequiresACPower 0"
# Appearance - Set Appearance to Auto
"-g AppleInterfaceStyleSwitchesAutomatically -bool true"
)
function ConfDefaults() {
    declare -a defaultwrite=("${!1}")
    for defaultspath in "${defaultwrite[@]}"
    do
    	# echo $defaultspath
	/usr/bin/defaults write $defaultspath || :
	done }
# Invoke ConfDefaults function with array defaultwrite
ConfDefaults defaultwrite[@]
### System Setup Commands ###
syssetup=(
# Date & Time - Enable Automatic Timezone
"-setusingnetworktime on"
"-gettimezone"
"-getnetworktimeserver"
)
function SystemSetup() {
	declare -a syssetup=("${!1}")
	for setup in "${syssetup[@]}"
	do # echo $setup
	/usr/sbin/systemsetup $setup || :
	done }
# Invoke SystemSetup function with array syssetup
SystemSetup syssetup[@]
########################[ Section Three: Jamf Policies ]#########################
policyID=(
# Set Asset Tag
72
# Set Avondale Wallpaper
62
# Install Rosetta2
66
# Unlock Preference Panes
69
# Install Microsoft Edge
29
# Install Zoom
64
# Install Defender
108
# Install Jamf Connect
118
# Install Microsoft Teams
42
# Installing TeamViewer
109
# Install Adobe Acrobat Reader DC
32
)
function JamfPolicies() {
    declare -a policyID=("${!1}")
    for id in "${policyID[@]}"
    do
        jamf policy -id $id || :
        sleep 12
    done }
# Invoke Function JamfPolicies with Array policyID
JamfPolicies policyID[@]
### DS Edit Commands ###
dsedit=(
# Printers & Scanners - Enable All Users as Print Admins
"-o edit -n /Local/Default -a everyone -t group lpadmin"
)
function DSEditGroup() {
	declare -a dsedit=("${!1}")
	for ds in "${dsedit[@]}"
	do /usr/sbin/dseditgroup $ds || :
	done }
# Invoke DSEditGroup function with array dsedit
DSEditGroup dsedit[@]
########################[ Section Four: Clean Up ]#########################
### Close applications that persist after installation ###
appName=(
    'zoom.us'
    'Microsoft AutoUpdate'
)
function CloseApp() {
    declare -a appName=("${!1}")
    for app in "${appName[@]}"
    do
        if pgrep -xq -- $app; then
            killall $app && echo "Terminating "$app".app"
        else
            echo $app" is not running, proceeding with script..."
        fi
    done
}
# Invoke Function CloseApp with Array appName
CloseApp appName[@]
# Close Jamf Connect Windows (Not Working Currently)
#/usr/bin/osascript -e 'tell application "Jamf Connect" to close windows
#    with timeout of 5 seconds
#    end timeout'
### Announce Completion ###
osascript -e "set Volume 5"
say "Provisioning Complete"
echo "Script Complete"
