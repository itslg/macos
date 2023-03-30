#!/bin/bash
###################################################
### Name: Install JavaRuntime Environment       ###
### Author: MaverickMidori (Levi G)             ###
### Date Created: 2021-06-15                    ###
### Organisation: Avondale University           ###
### Use: Generic / Entity-Agnostic              ###
### Notes: Sourced from Jamf Nation             ###
###################################################
##                { Information }                ##
###################################################
## Created by Clay Nelson on 2/15/19
## Forked by Levi Green on 15/06/21
## Sources:
##  Clay Nelson - https://www.jamf.com/jamf-nation/discussions/29555/script-to-install-update-java
##  Shannon Johnson - https://www.jamf.com/jamf-nation/discussions/29555/script-to-install-update-java
##  Lewis Lebentz - https://lew.im/2017/03/auto-update-chrome/
##  Joe Farage - https://www.jamf.com/jamf-nation/third-party-products/files/764/firefox-install-update
###################################################

# Variables
  dmgfile="javaUpdate.dmg"
  logfile="/Library/Logs/JavaInstallScript.log"

# Get the latest version number of Java available.
  latestver=`/usr/bin/curl -s http://javadl-esd-secure.oracle.com/update/baseline.version | grep "1.8.0"`
  latestJavaVer=`echo "$latestver" | awk -F "." '{print $2}'`
  latestMinorVer=`echo "$latestver" | awk -F "_" '{print $2}'`
  /bin/echo "Latest Version is: $latestver"
  /bin/echo "`date`: Latest Version is: $latestver" >> ${logfile}

# Get the version number of the currently-installed Java, if any.
  if [ -e "/Library/Internet Plug-Ins/JavaAppletPlugin.plugin" ]; then
    currentInstalledVer=`/usr/bin/defaults read "/Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Home/lib/deploy/JavaControlPanel.prefPane/Contents/Info.plist" CFBundleShortVersionString`
    /bin/echo "Current installed version is: $currentInstalledVer"
    /bin/echo "`date`: Current installed version is: $currentInstalledVer" >> ${logfile}
    currentJavaVer=`echo "$currentInstalledVer" | awk -F "." '{print $2}'`
    currentMinorVer=`echo "$currentInstalledVer" | awk -F "_" '{print $2}'`
    if [ ${latestver} = ${currentInstalledVer} ]; then
        /bin/echo "Java is already up to date, running Java ${currentJavaVer} Update ${currentMinorVer}."
        /bin/echo "`date`: Java is already up to date, running Java ${currentJavaVer} Update ${currentMinorVer}." >> ${logfile}
        /bin/echo "--" >> ${logfile}
        exit 0
    fi
  else
    currentInstalledVer="none"
    /bin/echo "Java is not installed"
    /bin/echo "`date`: Java is not installed" >> ${logfile}
  fi

# Getting the latest version of the url for Java download
  latestSite=`/usr/bin/curl -s https://www.oracle.com/technetwork/java/javase/downloads/index.html | grep "/technetwork/java/javase/downloads/jre8-downloads-" | awk -F '"' '{print $4}'`
  url=`/usr/bin/curl -s https://www.oracle.com${latestSite} | grep "macosx-x64.dmg" | grep "${latestJavaVer}u${latestMinorVer}" | awk -F, '{print $3}' | awk -F '"' '{print $4}'`

# Downloading and Installing
  /bin/echo "Latest version of the URL is: $url"
  /bin/echo "`date`: Download URL: $url" >> ${logfile}

  /bin/echo "Downloading latest version..."
  /bin/echo "`date`: Downloading latest version." >> ${logfile}
  /usr/bin/curl -s -j -k -L -H "Cookie: oraclelicense=accept-securebackup-cookie" ${url} > /tmp/${dmgfile}

  /bin/echo "Mounting installer disk image..."
  /bin/echo "`date`: Mounting installer disk image." >> ${logfile}
  /usr/bin/hdiutil attach /tmp/${dmgfile} -nobrowse -quiet

  /bin/echo "Installing..."
  /bin/echo "`date`: Installing..." >> ${logfile}
  sudo installer -pkg /Volumes/Java\ ${latestJavaVer}\ Update\ ${latestMinorVer}/Java\ ${latestJavaVer}\ Update\ ${latestMinorVer}.app/Contents/Resources/JavaAppletPlugin.pkg -target /
  /bin/sleep 10

  /bin/echo "Unmounting installer disk image..."
  /bin/echo "`date`: Unmounting installer disk image." >> ${logfile}
  /usr/bin/hdiutil detach $(/bin/df | /usr/bin/grep "Java" | awk '{print $1}') -quiet

  /bin/sleep 10

  /bin/echo "Deleting disk image..."
  /bin/echo "`date`: Deleting disk image." >> ${logfile}
  /bin/rm /tmp/${dmgfile}

# Double check to see if the new version got updated
  newlyInstalledVer=`/usr/bin/defaults read "/Library/Internet Plug-Ins/JavaAppletPlugin.plugin/Contents/Home/lib/deploy/JavaControlPanel.prefPane/Contents/Info.plist" CFBundleShortVersionString`
  newlyInstalledJavaVer=`/bin/echo "${newlyInstalledVer}" | awk -F "." '{print $2}'`
  newlyInstalledMinorVer=`/bin/echo "${newlyInstalledVer}" | awk -F "_" '{print $2}'`
  if [ "${latestver}" = "${newlyInstalledVer}" ]; then
    /bin/echo "SUCCESS: Java has been updated to: Java ${newlyInstalledJavaVer} Update ${newlyInstalledMinorVer}."
    /bin/echo "`date`: SUCCESS: Java has been updated to: Java ${newlyInstalledJavaVer} Update ${newlyInstalledMinorVer}." >> ${logfile}
    /bin/echo "--" >> ${logfile}
  else
    /bin/echo "ERROR: Java update unsuccessful, version remains at: Java ${currentJavaVer} Update ${currentMinorVer}."
    /bin/echo "`date`: ERROR: Java update unsuccessful, version remains at: Java ${currentJavaVer} Update ${currentMinorVer}." >> ${logfile}
    /bin/echo "--" >> ${logfile}
    exit 1
  fi

  exit 0
