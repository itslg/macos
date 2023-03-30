#!/bin/sh
# Initial setup script for Mac OS X 10.11.x
# Created 5/8/16
# Set Time Server

# /usr/bin/systemsetup -setnetworktimeserver time.asia.apple.com

# Set Time Zone

/bin/sleep 10
/usr/sbin/systemsetup -settimezone Australia/Sydney

# Set Network Time

# /usr/sbin/systemsetup -setusingnetworktime on

# Configure Finder to always open directories in Column view

# /usr/bin/defaults write /System/Library/User\ Template/English.lproj/Library/Preferences/com.apple.finder "AlwaysOpenWindowsInColumnView" -bool true

# Disable Time Machine's pop-up message whenever an external drive is plugged in

/usr/bin/defaults write /Library/Preferences/com.apple.TimeMachine DoNotOfferNewDisksForBackup -bool true
/usr/bin/defaults write /Library/Preferences/com.apple.TimeMachine RequiresACPower 0

# Hide Admin User

# /usr/bin/defaults write /Library/Preferences/com.apple.loginwindow Hide500Users -bool TRUE

# root user
/usr/sbin/dsenableroot -u aadmin -p $staffaadminlocal -r $staffaadminroot
/usr/sbin/dsenableroot -u aadmin -p $studentaadminlocal -r $studentaadminroot

# Printing access for ALL
/usr/sbin/dseditgroup -o edit -n /Local/Default -a everyone -t group lpadmin

# Set separate power management settings for desktops and laptops
# If it's a laptop, the power management settings for "Battery" are set to have the computer sleep in 15 minutes, disk will spin down
# in 10 minutes, the display will sleep in 5 minutes and the display itslef will dim to half-brightness before sleeping. While plugged
# into the AC adapter, the power management settings for "Charger" are set to have the computer never sleep, the disk doesn't spin down,
# the display sleeps after 30 minutes and the display dims before sleeping.
#
# If it's not a laptop (i.e. a desktop), the power management settings are set to have the computer never sleep, the disk doesn't spin down, the display
# sleeps after 30 minutes and the display dims before sleeping.
#

# Detects if this Mac is a laptop or not by checking the model ID for the word "Book" in the name.
IS_LAPTOP=`/usr/sbin/system_profiler SPHardwareDataType | grep "Model Identifier" | grep "Book"`

if [ "$IS_LAPTOP" != "" ]; then
    pmset -b sleep 30 disksleep 10 displaysleep 15 halfdim 1
    pmset -c sleep 0 disksleep 0 displaysleep 120 halfdim 1
else
    pmset sleep 0 disksleep 0 displaysleep 120 halfdim 1
fi

# Set the login window to name and password

/usr/bin/defaults write /Library/Preferences/com.apple.loginwindow SHOWFULLNAME -bool true

# Disable external accounts (i.e. accounts stored on drives other than the boot drive.)

# /usr/bin/defaults write /Library/Preferences/com.apple.loginwindow EnableExternalAccounts -bool false

# Set the ability to  view additional system info at the Login window
# The following will be reported when you click on the time display
# (click on the time again to proceed to the next item):
#
# Computer name
# Version of OS X installed
# IP address
# This will remain visible for 60 seconds.

/usr/bin/defaults write /Library/Preferences/com.apple.loginwindow AdminHostInfo HostName

# Turn SSH on

/usr/sbin/systemsetup -setremotelogin on

# Turn Remote Management on (ARD)

# /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate  -configure -access -on -allowAccessFor -allUsers -privs -all
/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -activate -configure -access -on -users aadmin,ardadmin -privs -DeleteFiles -TextMessages -OpenQuitApps -GenerateReports -RestartShutDown -SendFiles -ChangeSettings -ControlObserve -restart -agent -menu
/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -allowAccessFor -specifiedUsers
# /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -targetdisk / -activate -configure -clientopts -setmenuextra -menuextra no -configure -users 'aadmin' -access -on -privs -DeleteFiles -TextMessages  -OpenQuitApps -GenerateReports -RestartShutDown -SendFiles -ChangeSettings -ControlObserve -configure -users 'ardadmin' -access -on -privs -DeleteFiles -TextMessages  -OpenQuitApps -GenerateReports -RestartShutDown -SendFiles -ChangeSettings -ControlObserve -configure -allowAccessFor -specifiedUsers -privs -DeleteFiles -TextMessages  -OpenQuitApps -GenerateReports -RestartShutDown -SendFiles -ChangeSettings -ControlObserve -restart -agent -menu
# /System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -users teacher,student -access -on -privs -ControlObserve -ObserveOnly -TextMessages

# Bind to OD

dsconfigldap -N -a od.avondaleschool.nsw.edu.au

# Set Paper to A4

/usr/bin/defaults write /Library/Preferences/org.cups.PrintingPrefs DefaultPaperID iso-a4

# Lightspeed user agent script

/usr/bin/defaults write useragent IdentServer -string "10.1.0.35"

# Create Folder for Printer Proxy redirect

mkdir /Library/Printers/Installed_Printers
chmod u+r+w+x,g+r+w+x,o+r+w+x /Library/Printers/Installed_Printers
chflags hidden /Library/Printers/Installed_Printers

# Turn off Gatekeeper

spctl --master-disable

# Disable Gatekeeper's auto-rearm. Otherwise Gatekeeper
# will reactivate every 30 days. When it reactivates, it
# will be be set to "Mac App Store and identified developers"

/usr/bin/defaults write /Library/Preferences/com.apple.security GKAutoRearm -bool false

# Set the RSA maximum key size to 32768 bits (32 kilobits) in
# /Library/Preferences/com.apple.security.plist to provide
# future-proofing against larger TLS certificate key sizes.
#
# For more information about this issue, please see the link below:
# http://blog.shiz.me/post/67305143330/8192-bit-rsa-keys-in-os-x

# /usr/bin/defaults write /Library/Preferences/com.apple.security RSAMaxKeySize -int 32768

# Remove setup LaunchDaemon item

rm -rf /Library/LaunchDaemons/com.company.initialsetup.plist

## Show on desktop

/usr/bin/defaults write com.apple.finder ShowMountedServersOnDesktop -bool true
/usr/bin/defaults write com.apple.finder ShowExternalHardDrivesOnDesktop -bool true
/usr/bin/defaults write com.apple.finder ShowHardDrivesOnDesktop -bool true

# Enable the wireless method you need and
# add the correct variables as needed. The
# wireless network name should not contain spaces.

# Determines which OS the script is running on
osvers=$(sw_vers -productVersion | awk -F. '{print $2}')

# On 10.7 and higher, the Wi-Fi interface needs to be identified.
# On 10.5 and 10.6, the Wi-Fi interface should be named as "AirPort"

wifiDevice=`/usr/sbin/networksetup -listallhardwareports | awk '/^Hardware Port: Wi-Fi/,/^Ethernet Address/' | head -2 | tail -1 | cut -c 9-`

# Set the SSID variable to your wireless network name
# to set the network name you want to connect to.
# Note: Wireless network name cannot contain spaces.
SSID=AvondaleSchool

# Set the INDEX variable to the index number you’d like
# it to be assigned to (leave it as "0" if you do not know
# what index number to use.)
INDEX=0

# Set the SECURITY variable to the security type of the
# wireless network (NONE, WEP, WPA, WPA2, WPAE or
# WPA2E) Setting it to NONE means that it's an open
# network with no encryption.
SECURITY=WPA2

# If you've set the SECURITY variable to something other than NONE,
# set the password here. For example, if you are using WPA
# encryption with a password of "thedrisin", set the PASSWORD
# variable to "thedrisin" (no quotes.)
PASSWORD= # AvondaleSchool Wireless PW
  
# Once the running OS is determined, the settings for the specified
# wireless network are created and set as the first preferred network listed
  
if [[ ${osvers} -ge 7 ]]; then
    networksetup -addpreferredwirelessnetworkatindex $wifiDevice $SSID $INDEX $SECURITY $PASSWORD
else
    networksetup -addpreferredwirelessnetworkatindex AirPort $SSID $INDEX $SECURITY $PASSWORD
fi


# Region settings?
# language, see man page.
# this has to come first because it scrubs .GlobalPreferences.plist
languagesetup -langspec English

# int value defines how many languages are activated in the list.
defaults write /Library/Preferences/.GlobalPreferences.plist
AppleUserLanguages -int 3

# language preference (and order)
# for example mine are english with the option for Simplified and
Traditional Chinese
defaults write /System/Library/User\
Template/English.lproj/Library/Preferences/.GlobalPreferences.plist
AppleLanguages -array "en" "zh-Hans" "zh-Hant" "fr" "de" "ja" "es" "it"
"nl" "ko" "pt" "pt-PT" "da" "fi" "nb" "sv" "ru" "pl" "tr" "ar" "th" "cs"
"hu" "ca" "hr" "el" "he" "ro" "sk" "uk" "id" "ms" "vi"

# locale
defaults write /Library/Preferences/.GlobalPreferences.plist AppleLocale
-string en_AU

defaults write /Library/Preferences/.GlobalPreferences.plist Country
-string AU

# Centimeters or Inches
defaults write /Library/Preferences/.GlobalPreferences.plist
AppleMeasurementUnits -string Centimeters

defaults write /Library/Preferences/.GlobalPreferences.plist
AppleMetricUnits -bool true

# keyboard input method
# ugly, I know.
cat > "/tmp/com.apple.HIToolbox.plist" << EOPROFILE
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "
http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
<key>AppleCurrentKeyboardLayoutInputSourceID</key>
<string>com.apple.keylayout.YY</string>
<key>AppleDefaultAsciiInputSource</key>
<dict>
<key>InputSourceKind</key>
<string>Keyboard Layout</string>
<key>KeyboardLayout ID</key>
<integer>XX</integer>
<key>KeyboardLayout Name</key>
<string>YY</string>
</dict>
<key>AppleEnabledInputSources</key>
<array>
<dict>
<key>InputSourceKind</key>
<string>Keyboard Layout</string>
<key>KeyboardLayout ID</key>
<integer>XX</integer>
<key>KeyboardLayout Name</key>
<string>YY</string>
</dict>
</array>
</dict>
</plist>
EOPROFILE

keyboardlayoutname=Australian
keyboardlayoutid=15
cat "/tmp/com.apple.HIToolbox.plist" | sed s/YY/${keyboardlayoutname}/g |
sed s/XX/${keyboardlayoutid}/g >
"/Library/Preferences/com.apple.HIToolbox.plist"

