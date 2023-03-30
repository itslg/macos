###################################################
### Name: Set Asset Tag - First Run             ###
### Author: MaverickMidori (Levi G)             ###
### Date Created: 2021-06-20                    ###
### Organisation: Avondale University           ###
### Use: Generic / Entity-Agnostic              ###
### Notes: Update Default Answer per Deploy     ###
###################################################

# Create Dialogue Box to enter Asset Tag
userValue=$(osascript << EOF
text returned of (display dialog "Enter your asset tag" default answer "21MBA" buttons {"OK"} default button 1)

EOF)

# Update Computer Name
scutil --set ComputerName "$userValue"
scutil --set LocalHostName "$userValue"
scutil --set HostName "$userValue"
# Update Jamf Name and Asset Tag
jamf recon -assetTag "$userValue"
jamf setComputerName -name "$userValue"
