#!/bin/sh
# Find Management ID of Computer
curl --location --request GET 'https://YOUR_JAMF_PRO_URL/api/preview/computers' --header 'Authorization: Bearer YOUR_BEARER_TOKEN'
# Send Recovery Lock MDM Command
curl --location --request POST 'https://avondalecollege.jamfcloudL/api/preview/mdm/commands' \
--header 'Authorization: Bearer JAMF_PRO_AUTH_TOKEN' \
--header 'Content-Type: application/json' \
--data-raw '{
    "clientData": [
        {
            "managementId": "A9C3D1F0-DCB2-4D52-84C6-D5AD60140B04",
            "clientType": "COMPUTER"
        }
    ],
    "commandData": {
        "commandType": "SET_RECOVERY_LOCK",
        "newPassword": "password",
    }
}'
jamf recon
