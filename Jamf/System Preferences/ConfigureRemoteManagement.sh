#!/bin/sh
# Define Serial Number
SN= eval system_profiler SPHardwareDataType | awk '/Serial/ {print $4}'
vncpw= # See Password Manager
# Define Asset Tag
ASSETTAG= eval scutil --get LocalHostName
# Enable VNC Agent
/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -clientopts -setvnclegacy -vnclegacy yes
# Set VNC Password
/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -clientopts -setvncpw -vncpw $vncpw
# Set Info Fields
/System/Library/CoreServices/RemoteManagement/ARDAgent.app/Contents/Resources/kickstart -configure -computerinfo -set1 -1 $ASSETTAG -set2 -2 $SN
