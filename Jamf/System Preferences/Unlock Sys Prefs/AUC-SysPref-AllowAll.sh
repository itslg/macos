#!/bin/sh

##	Unlocking Preferences

/usr/bin/security authorizationdb read system.preferences > /tmp/system.preferences.plist

/usr/bin/defaults write /tmp/system.preferences.plist group everyone

/usr/bin/security authorizationdb write system.preferences < /tmp/system.preferences.plist

## Allow Editing Printer Preferences

/usr/bin/security authorizationdb read system.preferences.printing > /tmp/system.preferences.printing.plist

/usr/bin/defaults write /tmp/system.preferences.printing.plist group everyone

/usr/bin/security authorizationdb write system.preferences.printing < /tmp/system.preferences.printing.plist

/usr/sbin/dseditgroup -o edit -n /Local/Default -a “everyone” -t group lpadmin

## Timemachine Preferences

usr/bin/security authorizationdb read system.preferences.timemachine > /tmp/system.preferences.printing.plist

/usr/bin/defaults write /tmp/system.preferences.timemachine.plist group everyone

/usr/bin/security authorizationdb write system.preferences.timemachine < /tmp/system.preferences.timemachine.plist







# Allows any user to change the date and time on their Mac.

security authorizationdb write system.preferences allow
security authorizationdb write system.preferences.datetime allow
security authorizationdb write system.preferences.timemachine allow
security authorizationdb write system.preferences.network allow
security authorizationdb write system.preferences.sharing admin