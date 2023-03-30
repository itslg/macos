#!/bin/sh

osascript -e 'set Human_Interaction to (tell app "Terminal" to display dialog "TEST!!!" buttons {"Okay!"})'
osascript -e 'set BUTTON_Returned to button returned of Human_Interaction'






#osascript -e 'tell app "Terminal" to display dialog "TEST!!!" buttons {"Okay!"}'
#if button returned = "Okay!"; then echo "It Worked!"
 #   else echo "no working"
#fi
