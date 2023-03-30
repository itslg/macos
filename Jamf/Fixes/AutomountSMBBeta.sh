#!/bin/sh
###################################################
### Name: Automount SMB Shares                  ###
### Author: MaverickMidori (Levi G)             ###
### Date Created: 2021-10-01                    ###
### Organisation: Avondale University           ###
### Use: Generic / Entity-Agnostic              ###
### Notes: Needs dialogue boxes                 ###
###################################################
userName="first_l"
userPass="RANDOMLYGENERATEDPASSWORD"
shareName="lmfs01.avondale.edu.au/fac&dep"
whereToMount="/Volumes/"
mount_smbfs //$userName:$userPass@$shareName $whereToMount
