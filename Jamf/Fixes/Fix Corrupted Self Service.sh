#!/bin/sh
###################################################
### Name: Fix Corrupt Self Service              ###
### Author: MaverickMidori (Levi G)             ###
### Date Created: 2020-09-30                    ###
### Organisation: Avondale University           ###
### Use: Generic / Entity-Agnostic              ###
### Notes: If Jamf corrupt, won't reinstall     ###
###################################################
## Fix Corrupted Self Service
rm -rf /Applications/Self Service.app
rm -rf com.jamfsoftware.SelfService.privatekey
rm -rf com.jamfsoftware.SelfService.publickey
jamf recon
