# Displaying Dialogs and Alerts

Dialogs and alerts are great ways to provide information about a script’s progress, report problems, and allow users to make decisions that affect script behaviour.
## Apple Developer
### Displaying a Dialog

Use the `display dialog` command, provided by the Standard Additions scripting addition to show a basic dialog message to the user, such as the one in Figure 22-1. This dialog was produced by the code in Listing 22-1 and Listing 22-2. In these examples, a string is passed to the `display dialog` command as a direct parameter. The result of the command is the button the user clicked in the dialog.

**Figure 22-1** A simple dialog![image: ../Art/dialog_simple_2x.png](https://developer.apple.com/library/archive/documentation/LanguagesUtilities/Conceptual/MacAutomationScriptingGuide/Art/dialog_simple_2x.png)

**APPLESCRIPT**

Open in Script Editor

**Listing 22-1**AppleScript: Displaying a simple dialog

1.  `set theDialogText to "The curent date and time is " & (current date) & "."`
2.  `display dialog theDialogText`
3.  `--> Result: {button returned:"OK"}`

**JAVASCRIPT**

Open in Script Editor

**Listing 22-2**JavaScript: Displaying a simple dialog

1.  `var app = Application.currentApplication()`
2.  `app.includeStandardAdditions = true`

4.  `var dialogText = "The current date and time is " + (app.currentDate())`
5.  `app.displayDialog(dialogText)`
6.  `// Result: {"buttonReturned":"OK"}`

NOTE

This chapter covers a portion of the `display dialog` command’s capabilities. For example, the `display dialog` command can also be used to collect text entered by the user. This is covered in [Prompting for Text](https://developer.apple.com/library/archive/documentation/LanguagesUtilities/Conceptual/MacAutomationScriptingGuide/PromptforText.html#//apple_ref/doc/uid/TP40016239-CH80-SW1). For complete information about the `display dialog` command and its parameters, launch Script Editor, open the Standard Additions scripting addition’s dictionary, and navigate to the command’s definition.

### Customising Dialog Buttons

By default, a dialog produced by the `display dialog` command has two buttons—Cancel and OK (the default). However, the command also has numerous optional parameters, some of which can be used to customise the buttons.

Use the `buttons` parameter to provide a list of between one and three buttons. You can optionally use the `default button` parameter to configure one as the default—it’s highlighted and pressing the Return key activates it to close the dialog. You can also use the `cancel button` parameter to configure one as the cancel button—pressing Escape or Command-Period (.) activates it to close the dialog and produce a user cancelled error.

The dialog shown in Figure 22-2 has been customised to include Don’t Continue (the cancel button) and Continue (the default) buttons. This dialog was produced by the example code in Listing 22-3 and Listing 22-4.

**Figure 22-2**A dialog with custom buttons![image: ../Art/dialog_customButtons_2x.png](https://developer.apple.com/library/archive/documentation/LanguagesUtilities/Conceptual/MacAutomationScriptingGuide/Art/dialog_customButtons_2x.png)

**APPLESCRIPT**

Open in Script Editor

**Listing 22-3**AppleScript: Displaying a dialog with custom buttons

1.  `set theDialogText to "An error has occurred. Would you like to continue?"`
2.  `display dialog theDialogText buttons {"Don't Continue", "Continue"} default button "Continue" cancel button "Don't Continue"`
3.  `--> Result: {{button returned:"Continue"}`

**JAVASCRIPT**

Open in Script Editor

**Listing 22-4**JavaScript: Displaying a dialog with custom buttons

1.  `var app = Application.currentApplication()`
2.  `app.includeStandardAdditions = true`

5.  `var dialogText = "An error has occurred. Would you like to continue?"`
6.  `app.displayDialog(dialogText, {`
7.  `buttons: ["Don't Continue", "Continue"],`
8.  `defaultButton: "Continue",`
9.  `cancelButton: "Don't Continue"`
10.  `})`
11.  `// Result: {"buttonReturned":"Continue"}`

### Adding an Icon to a Dialog

Dialogs can also include an icon, providing users with a visual clue to their importance. You can direct the `display dialog` command to a specific icon by its file path, or resource name or ID if the icon is stored as a resource within your script’s bundle. You can also use the standard system icons `stop`, `note`, and `caution`. Listing 22-5 and Listing 22-6 display a dialog that includes the system caution icon like the one shown in Figure 22-3.

**Figure 22-3**A dialog with an icon![image: ../Art/dialog_customIcon_2x.png](https://developer.apple.com/library/archive/documentation/LanguagesUtilities/Conceptual/MacAutomationScriptingGuide/Art/dialog_customIcon_2x.png)

**APPLESCRIPT**

Open in Script Editor

**Listing 22-5**AppleScript: Displaying a dialog with an icon

1.  `set theDialogText to "The amount of available free space is dangerously low."`
2.  `display dialog theDialogText with icon caution`

**JAVASCRIPT**

Open in Script Editor

**Listing 22-6**JavaScript: Displaying a dialog with an icon

1.  `var app = Application.currentApplication()`
2.  `app.includeStandardAdditions = true`

4.  `var dialogText = "The amount of available free space is dangerously low."`
5.  `app.displayDialog(dialogText, {withIcon: "caution"})`

### Automatically Dismissing a Dialog

Sometimes, you may want to continue with script execution if a dialog isn’t dismissed by a user within a certain timeframe. In this case, you can specify an integer value for the `display dialog` command’s `giving up after` parameter, causing the dialog to _give up_ and close automatically after a specified period of inactivity.

Listing 22-7 and Listing 22-8 display a dialog that automatically closes after five seconds of inactivity.

**APPLESCRIPT**

Open in Script Editor

**Listing 22-7**AppleScript: Displaying a dialog that automatically dismisses after a period of inactivity

1.  `display dialog "Do, or do not. There is no try." giving up after 5`
2.  `--> Result: {button returned:"OK", gave up:true}`

**JAVASCRIPT**

Open in Script Editor

**Listing 22-8**JavaScript: JavaScript a dialog that automatically dismisses after a period of inactivity

1.  `var app = Application.currentApplication()`
2.  `app.includeStandardAdditions = true`

4.  `var dialogText = "Do, or do not. There is no try."`
5.  `app.displayDialog(dialogText, {givingUpAfter: 5})`
6.  `// Result: {"buttonReturned":"OK", "gaveUp":true}`

When using the `giving up after` parameter, the result of the `display dialog` command includes a `gaveUp`property, a Boolean value indicating whether the dialog was auto-dismissed. This information is useful if you want the script to take a different course of action based on whether a dialog is manually or automatically dismissed.

### Displaying an Alert

The `display alert` command is also provided by the Standard Additions scripting addition. It’s similar to the `display dialog` command, but with slightly different parameters. One of the `display alert` command’s optional parameters is `message`, which lets you provide additional text to display in a separate text field, below the bolded alert text. Listing 22-9 and Listing 22-10 show how to display the alert in Figure 22-4, which contains bolded alert text, plain message text, and custom buttons.

**Figure 22-4**An alert![image: ../Art/alert_2x.png](https://developer.apple.com/library/archive/documentation/LanguagesUtilities/Conceptual/MacAutomationScriptingGuide/Art/alert_2x.png)

**APPLESCRIPT**

Open in Script Editor

**Listing 22-9**AppleScript: Displaying an alert with a message

1.  `set theAlertText to "An error has occurred."`
2.  `set theAlertMessage to "The amount of available free space is dangerously low. Would you like to continue?"`
3.  `display alert theAlertText message theAlertMessage as critical buttons {"Don't Continue", "Continue"} default button "Continue" cancel button "Don't Continue"`
4.  `--> Result: {button returned:"Continue"}`

**JAVASCRIPT**

Open in Script Editor

**Listing 22-10**JavaScript: Displaying an alert with a message

1.  `var app = Application.currentApplication()`
2.  `app.includeStandardAdditions = true`

4.  `var alertText = "An error has occurred."`
5.  `var alertMessage = "The amount of available free space is dangerously low. Would you like to continue?"`
6.  `app.displayAlert(alertText, {`
7.  `message: alertMessage,`
8.  `as: "critical",`
9.  `buttons: ["Don't Continue", "Continue"],`
10.  `defaultButton: "Continue",`
11.  `cancelButton: "Don't Continue"`
12.  `})`
13.  `// Result: {"buttonReturned":"OK"}`

NOTE

This chapter covers a portion of the `display alert` command’s capabilities. For complete information about the `display alert` command and its parameters, launch Script Editor, open the Standard Additions scripting addition’s dictionary, and navigate to the command’s definition.

## Notes
#### Adding Custom Icons:

*Method 1*
```
display dialog "Text" with icon alias ((path to desktop as text) & "asd.icns")
```
*Method 2*
```
display dialog "Text" with icon file ((path to desktop as text) & "asd.icns")
```
`path to desktop as text` represents the HFS path to the desktop of the current user:
`"Macintosh HD:Users:user:Desktop:"`
Notes from Apple Developer: 
`with icon` (_alias | file_) An alias or file specifier that specifies a .icns file.

---
