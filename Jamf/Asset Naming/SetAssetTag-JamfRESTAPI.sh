#!/bin/sh
###################################################
### Name: AssetTagNamingREST                    ###
### Author: MaverickMidori (Levi G)             ###
### Date Created: 2021-04-20                    ###
### Organisation: Avondale University           ###
### Use: Avondale University Specific RESTAPI   ###
### Notes: RestAPI Script to Pull Asset Tag     ###
###################################################
Username="mdm"
Password= # See PASSWORD VAULT
Server="https://avondalecollege.jamfcloud.com:443"
# Find Serial Number
serial=$(ioreg -c IOPlatformExpertDevice -d 2 | awk -F\" '/IOPlatformSerialNumber/{print $(NF-1)}')
# Establish RestAPI Credentials and Server
response=$(curl -k -H "accept: application/xml" -u $Username:$Password $Server/JSSResource/computers/serialnumber/${serial}/subset/general)
# Fields to Utilise
assetTag=$(echo $response | /usr/bin/awk -F'<asset_tag>|</asset_tag>' '{print $2}');
barcode1=$(echo $response | /usr/bin/awk -F'< barcode_1 >|</barcode_1 >' '{print $2}');
barcode2=$(echo $response | /usr/bin/awk -F'< barcode_2 >|</barcode_2 >' '{print $2}');

computerName=$assetTag
# Setting computername
echo "Setting computer name..."
scutil --set ComputerName "$computerName"
scutil --set HostName "$computerName"
scutil --set LocalHostName "$computerName"

exit 0
