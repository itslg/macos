# Recovery Lock - Apple Silicon
## Introduction
---
In Big Sur 11.5, Apple introduced the ability to [set a recovery lock password](https://support.apple.com/en-us/HT211911) on Apple Silicon computers. This was a very welcome announcement, since many of us have been mourning the loss of the `EFI` firmware password that was so effective on Intel Macs.

The firmware password was an important security feature, especially in environments like schools. It prevented students from booting to Recovery Mode, where they would be able to erase the hard drive, run terminal commands, reset passwords, use Safari unfiltered, and do all kinds of other nefarious acts.

Apple’s answer to these security concerns is simply to enable `FileVault`. This is flawed for a couple reasons:

1.  `FileVault` removes the ability to control lab computers through ARD. After a restart, there is no way to remotely take action on these computers until the disk is unlocked by someone physically sitting at the computer and typing in a password. This is a huge pain for things like updates and remotely installing software.
2.  Even when `FileVault` is enabled, students can erase the computer from the `FileVault` unlock screen. Try it for yourself – no password is needed and you can erase the disk.

## Jamf
---
### Configure Recovery Lock
The Recovery Lock can be set via *`Computers` > `PreStage Enrollments` > `Set Recovery Lock Password`*
Jamf offers two options regarding passwords:
1. Jamf Randomly Set Password (One Password per Machine)
2. Admin Set Password (One Password for all Machines)

### View Recovery Lock
To locate the `Recovery Lock Password` navigate to *`Computers` > `Selected Compputer` > `Inventory` > `Security` > `Recovery Lock Password
`*
![[JamfRecoveryLock.webp]]
![[RecoveryLock.jpeg]]

### Jamf Documentation
Recovery Lock functionality— You can set Recovery Lock for computers with Apple silicon (i.e., M1 chip) with macOS 11.5 or later during enrollment. Enabling this feature prevents access to macOS Recovery without a password, providing additional security for the computers in your environment. Jamf Pro allows you to create and store this password for each computer. You can view the information in the computer's inventory information. For more information about Recovery Lock, see [Use macOS Recovery on a Mac with Apple silicon](https://support.apple.com/guide/mac-help/macos-recovery-a-mac-apple-silicon-mchl82829c17/mac) from Apple's macOS User Guide.    

You can select one of the following methods to configure the Recovery Lock password:    
-   Manually enter a password that is applied to all computers in the scope of the PreStage
-   Enable Jamf Pro to generate a random password that is unique to each computer in the scope
To enhance the security of the Recovery Lock password, you can configure Jamf Pro to generate a new, random Recovery Lock password 60 minutes after the password is viewed in a computer’s inventory information.


---
## Apple Developer Resources
[[Set Recovery Lock Command]]

---
## Set Recovery Lock  (Python) - GitHub
https://github.com/shbedev/jamf-recovery-lock
---
## Set Recovery Lock (Bash) - GingerScripting
```zsh
#!/bin/zsh

#authentication - you can fill in these lines and add your information if you don't want to be prompted interactively when the script runs
#the jamfURL should be exactly what you type into the address bar to access Jamf (no slash at the end)
jamfURL=
jamfUsername=
jamfPassword=

if [ -z $jamfURL ]; then
    echo "Please enter the Jamf Pro URL (with no slash at the end):"
    read -r jamfURL
fi 

if [ -z $jamfUsername ]; then
    echo "Please enter your Jamf Pro username:"
    read -r jamfUsername
fi 

if [ -z $jamfPassword ]; then 
    echo "Please enter the Jamf Pro password for account: $jamfUsername:"
    read -r -s jamfPassword
fi

#encoding credentials so they aren't sent in plaintext
encodedCreds=$(printf "$jamfUsername:$jamfPassword" | iconv -t ISO-8859-1 | base64 -i -)

#using encoded credentials to get bearer token
token=$(curl -s "${jamfURL}/api/v1/auth/token" -H "Authorization: Basic $encodedCreds" -X POST | jq -r '.token')

#setting field separator to newline
IFS=$'\n'

#search number - you can fill in the search number here if you don't want to be prompted
#this search should have less than 2000 computers in it
searchNumber=
if [ -z $searchNumber ]; then
    echo "Please enter the number of the advanced computer search you want to send the command to:"
    read -r searchNumber
fi 

#recovery password - you can fill in the recovery password here if you don't want to be prompted
recoveryPassword=
if [ -z $recoveryPassword ]; then
    echo "Please enter the recovery password you would like to set on these computers:"
    read -r recoveryPassword
    echo "Password will be set to $recoveryPassword"
fi

#looping through computers in advanced search
computers=($(curl -s "${jamfURL}/JSSResource/advancedcomputersearches/id/$searchNumber" -H "Accept: application/json" -H "Authorization: Bearer ${token}" -X GET | jq ".advanced_computer_search.computers[].id" ))
    for computerID in "${computers[@]}"; do
        #get the Management ID for computers in the search
        echo "Processing computer number $computerID"
        managementID=$(curl -s "${jamfURL}/api/preview/computers?page-size=2000" -H "Accept: application/json" -H "Authorization: Bearer ${token}" | jq -r '.results[] | select (.id=='\"$computerID\"') | .managementId' )
        #send the recovery lock command
        curl -s "${jamfURL}/api/preview/mdm/commands" -H "Content-Type: application/json" -H "Authorization: Bearer ${token}" -X POST -d "{\"clientData\":[{\"managementId\":\""$managementID"\",\"clientType\":\"COMPUTER\"}],\"commandData\":{\"commandType\": \"SET_RECOVERY_LOCK\",\"newPassword\":\""$recoveryPassword"\"}}"    1 > /dev/null
        echo "Recovery Lock command sent to computer number $computerID."
    done

#cleaning up
curl -s -k "${jamfURL}/api/v1/auth/invalidate-token" -H "Authorization: Bearer ${token}" -X POST
unset IFS

echo "Complete. All computers in the advanced search have been sent the Recovery Lock command."
```
Tags: #RecoveryLock, #FirmwareLock, #UEFI, #PreBoot, #Jamf 
Links: 
