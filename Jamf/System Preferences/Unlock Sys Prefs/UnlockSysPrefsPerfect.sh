#!/bin/sh
###################################################
### Name: Unlock System Preferences (Perfect)   ###
### Author: MaverickMidori (Levi G)             ###
### Date Created: 2021-01-20                    ###
### Organisation: Avondale University           ###
### Use: Generic / Entity-Agnostic              ###
### Notes: Unlocks relevant system prefs        ###
###################################################
spctl --master-disable 

#Authorise General System Preferences (Top Layer)
security authorizationdb write system.preferences allow
security authorizationdb write system.preferences.network allow
security authorizationdb write system.preferences.accessibility allow
security authorizationdb write system.preferences.energysaver allow
security authorizationdb write system.preferences.printing allow
security authorizationdb write system.preferences.datetime allow
security authorizationdb write system.preferences.timemachine allow
## security authorizationdb write system.preferences.network allow
## security authorizationdb write system.preferences.security allow
security authorizationdb write system.services.systemconfiguration.network allow

#Deny Access to Sharing Preference Pane
security authorizationdb write system.preferences.sharing admin

#Authorise Printing Preference Pane
security authorizationdb write system.preferences.printing allow
security authorizationdb write system.printingmanager allow
security authorizationdb write system.print.admin allow
security authorizationdb write system.print.operator allow

#Authorise force restart and shutdown (if other users logged in)
security authorizationdb write system.restart allow
security authorizationdb write system.shutdown allow

##  Authorise App store
security authorizationdb write system.install.app-store-software allow

##  Authorise DVD Player Preference Pane
##  (This may be bugging the Sharing Pane Unlocked)
#security authorizationdb write system.device.dvd.setregion allow
#security authorizationdb write system.device.dvd.setregion.chage allow
#security authorizationdb write system.device.dvd.setregion.initial allow
#security authorizationdb write system.device.dvd.setregion.change.comment allow
#security authorizationdb write system.device.dvd.setregion.change.change allow
#security authorizationdb write system.device.dvd.setregion.initial.class allow
#security authorizationdb write system.device.dvd.setregion.change.class allow
#security authorizationdb write system.device.dvd.setregion.change.comment allow
#security authorizationdb write system.device.dvd.setregion.change.group allow
#security authorizationdb write system.device.dvd.setregion.change.group allow
#security authorizationdb write system.device.dvd.setregion.change.shared allow

##  Groups needed to be in for things to unlock
USERNAME=`who |grep console| awk '{print $1}'`

dseditgroup -o edit -a $USERNAME -T group _appstore
dseditgroup -o edit -a $USERNAME -T group lpadmin

/usr/libexec/airportd prefs RequireAdminNetworkChange=NO RequireAdminIBSS=NO

##  Unload locationd
launchctl unload /System/Library/LaunchDaemons/com.apple.locationd.plist

##  Write enabled value to locationd plist
defaults write /var/db/locationd/Library/Preferences/ByHost/com.apple.locationd LocationServicesEnabled -int 1
/usr/libexec/PlistBuddy -c "Set :com.apple.locationd.bundle-/System/Library/PrivateFrameworks/AssistantServices.framework:Authorized true" /var/db/locationd/clients.plist

##  Fix Permissions for the locationd folder
chown -R _locationd:_locationd /var/db/locationd

##  Reload locationd
launchctl load /System/Library/LaunchDaemons/com.apple.locationd.plist

#### Testing ####
#Authorise (Adv) General Layer Preferences
#/usr/bin/security authorizationdb read system.preferences > /tmp/system.preferences.plist
#/usr/bin/defaults write /tmp/system.preferences.plist group everyone
#/usr/bin/security authorizationdb write system.preferences < /tmp/system.preferences.plist

#Authorise (Adv) Printer Preferences
/usr/bin/security authorizationdb read system.preferences.printing > /tmp/system.preferences.printing.plist
/usr/bin/defaults write /tmp/system.preferences.printing.plist group everyone
/usr/bin/security authorizationdb write system.preferences.printing < /tmp/system.preferences.printing.plist
/usr/sbin/dseditgroup -o edit -n /Local/Default -a “everyone” -t group lpadmin

#Authorise (Adv) Timemachine Preferences
usr/bin/security authorizationdb read system.preferences.timemachine > /tmp/system.preferences.printing.plist
/usr/bin/defaults write /tmp/system.preferences.timemachine.plist group everyone
/usr/bin/security authorizationdb write system.preferences.timemachine < /tmp/system.preferences.timemachine.plist

exit 0
