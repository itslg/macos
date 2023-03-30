# Passing Variables via OSASCRIPT
This is dangerously unsafe:
```bash
foo="DO NOT DO THIS; say bad script"
osascript -e "tell application \"Terminal\" to do script \"echo $foo\""
```

(Run that example to see what I mean, then consider what a less friendly string could wreak.)

Double-quoting the variable `$foo` as `"$foo"` gets it safely through the top-level shell script. It does **NOT** get it safely through the AppleScript:

```bash
foo="say \"bad script\""
osascript -e "tell application \"Terminal\" to do script \"echo $foo\""
```

If you run that example, it will fail with an AppleScript compilation error: A identifier can’t go after this “"”. (-2740)

That’s because `osascript` receives the string:

```bash
tell application "Terminal" to do script "echo say "bad script""
```

which is invalid syntax. (Try compiling that line in Script Editor to see.)

The correct way to pass AppleScript arguments is by appending them to `osascript`’s arguments list:

```bash
osascript -ss -e "…" - "arg1" "arg2" "arg3"
```

The `-` separator is required to separate the command’s own options list from the remaining arguments to be forwarded to the AppleScript’s `run` handler.

BTW, is also a good idea to pass the AppleScript via `osascript`’s stdin instead of `-e` options, as that lets you write normal AppleScript code without having to escape it as well:

```bash
osascript -ss - "arg1" "arg2" "arg3" <<EOF

    on run argv -- argv is a list of 3 strings
        argv -- do stuff with argv here
    end run

EOF
```

(You can run that example safely: it just writes the value of `argv` to stdout.)

Okay, so that’s safe as far as passing arguments into AppleScript goes.

..

_However_, OP’s AppleScript creates a new shell script to be run in Terminal.app. Therefore, it is _also_ essential to sanitize the AppleScript strings used to construct that shell script, which is done using AppleScript’s `quoted form of STRING`property.

So here is the correct _safe_ way to sanitize arbitrary strings through all _three_ levels of code generation:

```bash
bar='$test" \t#est*;say bad script' # a proper nasty test string

osascript -  "$bar"  <<EOF

    on run argv -- argv is a list of strings
        tell application "Terminal"
            do script ("echo " & quoted form of item 1 of argv)
        end tell
    end run

EOF
```

Run that example, and the fairly horrible test string I’ve used here is passed safely all the way to `echo`.

And yes, all this string sanitization/code generation stuff _is_ a headache, but that’s what you get for using so many languages designed by crazy people.


Tags: #osascript, #variables, #applescript, #sanitising, #sanitizing, #piping, #pass, 