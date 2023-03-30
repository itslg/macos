#!/bin/sh
###################################################
### Name: Unlock System Preferences (Basic)     ###
### Author: MaverickMidori (Levi G)             ###
### Date Created: 2021-02-15                    ###
### Organisation: Avondale University           ###
### Use: Generic / Entity-Agnostic              ###
### Notes: Does not fully unlock printing       ###
###################################################
## Authorise General System Preferences (Top Layer)
#security authorizationdb write system.preferences allow
security authorizationdb write system.preferences.network allow
security authorizationdb write system.preferences.accessibility allow
security authorizationdb write system.preferences.energysaver allow
security authorizationdb write system.preferences.printing allow
security authorizationdb write system.preferences.datetime allow
security authorizationdb write system.preferences.timemachine allow
security authorizationdb write system.preferences.security allow
security authorizationdb write system.services.systemconfiguration.network allow

## Deny Access to Sharing Preference Pane
security authorizationdb write system.preferences.sharing admin

## Authorise Printing Preference Pane
security authorizationdb write system.preferences.printing allow
security authorizationdb write system.printingmanager allow
security authorizationdb write system.print.admin allow
security authorizationdb write system.print.operator allow

## Authorise force restart and shutdown (if other users logged in)
security authorizationdb write system.restart allow
security authorizationdb write system.shutdown allow
