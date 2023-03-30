#!/bin/bash
# Trigger script after succesful binary install.
# Set Default Applications
SWDA="/usr/local/bin/swda"
BROWSER="/Applications/Firefox.app"
CALENDAR="/Applications/Microsoft Outlook.app"
CONTACT="/Applications/Microsoft Outlook.app"
MAIL="/Applications/Microsoft Outlook.app"
SHEET="/Applications/Microsoft Excel.app"
if [ -f "$SWDA" ];
then echo "SWDA Binary is installed. Proceeding to configure..."
    if [ -d "$MAIL" ];
    then echo "Outlook is installed. Dependency Satisfied."
        if [ -d "$BROWSER" ];
        then echo "Firefox is installed. Dependency Satisfied."
### BROWSING ###
# Set Default Browser
echo "Setting Browser to Firefox"
$SWDA setHandler --app "$BROWSER" --browser
# ^^ http, https, public.html ,and public.url handled by the above ^^
# "$SWDA" setHandler --app "$BROWSER" --URL http
# "$SWDA" setHandler --app "$BROWSER" --URL https
# "$SWDA" setHandler --app "$BROWSER" --UTI public.html
# "$SWDA" setHandler --app "$BROWSER" --UTI public.url
"$SWDA" setHandler --app "$BROWSER" --UTI public.xhtml
echo "Browser sucessfully set to Firefox"
### MAIL ###
echo "Setting Mail Client / Handler to Outlook"
# Default Mail Client/Handler
"$SWDA" setHandler --app "$MAIL" --mail
# mailto: links
"$SWDA" setHandler --app "$MAIL" --URL mailto
# message
"$SWDA" setHandler --app "$MAIL" --URL message
# email
"$SWDA" setHandler --app "$MAIL" --UTI com.apple.mail.email
echo "Mail Client sucessfully set to Outlook"
echo "Setting Calendar Client / Handler to Outlook"
### CALENDAR ###
# Default Calendar Client
"$SWDA" setHandler --app "$CALENDAR" --URL ical
# Webcal links
"$SWDA" setHandler --app "$CALENDAR" --URL webcal
# .ics files
"$SWDA" setHandler --app "$CALENDAR" --UTI com.apple.ical.ics
"$SWDA" setHandler --app "$CALENDAR" --UTI com.apple.ical.ics.event
### CONTACT ###
# .vcard files
"$SWDA" setHandler --app "$CONTACT" --UTI public.vcard
echo "Calendar Client sucessfully set to Outlook"
echo "Setting CSV Handler to Excel"
### FILE TYPES ###
# .csv
"$SWDA" setHandler --app "$SHEET" --UTI public.comma-separated-values-text
echo "CSV Handler sucessfully set to Excel"
        else echo "Error: Firefox is not installed. Install Firefox and try again."
        fi
    else echo "Error: Outlook is not installed. Install Outlook and try again."
    fi
else echo "Error: SWDA is not installed. Install SWDA and try again."
fi
