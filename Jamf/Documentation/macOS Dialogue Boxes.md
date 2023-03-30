# macOS Dialogue Boxes
Dialogue Boxes are a function of AppleScript and can be called upon in Bash/Shell scripts via the `osascript` binary.

### Basics of Dialogue Boxes:
```
# Defining Buttons
display dialog "Answer to life the universe and everything?" buttons {"Yes", "42"}

# Defining Default Button
display dialog "Answer to life the universe and everything?" buttons {"Yes", "42"} default button 2

# Receiving Button Responses
set answer to the button returned of (display dialog "How old are you?" buttons {"Less than 1", "Older than 1"} default button 2)

# Display Answer
display dialog "You selected " & answer

# Basic Icons
display dialog "Hello World" with icon note
display dialog "Hello World" with icon stop
display dialog "Hello World" with icon caution


```


## Operational Example:
In this example, a dialogue box has been created with variables to receive and utilise the response received from the dialogue box buttons. This script uses `osascript` to leverage AppleScript. The quickest method is to call ```osascript -e``` and enter the AppleScript command you wish to send. However, the method below opens up the CLI to be purely AppleScript until told otherwise.

```
#!/bin/bash

osascript >/dev/null 2>&1 <<-EOF
tell application id "com.apple.systemevents"
   set myMsg to "Do you want to continue?" & return & return & " Please wait..."
   set theResp to display dialog myMsg buttons {"Cancel", "Okay"} default button 2 
end tell

# Following is not really necessary. Cancel returns 1 and OK 0 ...
if button returned of theResp is "Cancel" then
   return 1
end if
EOF

# Check status of osascript
if [ "$?" != "0" ] ; then
   echo "User aborted. Exiting..."
   exit 1
fi

#-- other bash stuff here
echo "All good, moving on...."
```