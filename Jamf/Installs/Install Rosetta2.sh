#!/bin/bash
###################################################
### Name: Install Rosetta2 on Silicon Machines  ###
### Author: MaverickMidori (Levi G)             ###
### Date Created: 2021-04-07                    ###
### Organisation: Avondale University           ###
### Use: Generic / Entity-Agnostic              ###
### Notes: Checks Architecture before Install   ###
###################################################
arch=$(/usr/bin/arch)
if [ "$arch" == "arm64" ]; then
    echo "Apple Silicon - Installing Rosetta"
    /usr/sbin/softwareupdate --install-rosetta --agree-to-license
elif [ "$arch" == "i386" ]; then
    echo "Intel - Skipping Rosetta"
else
    echo "Unknown Architecture"
fi
