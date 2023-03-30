# Shell & Bash Essentials Script Notes

## Nested 'if' Statements
```bash
#!/bin/bash

if EXPRESSION1; then
    STATEMENT1
	
    if EXPRESSION2; then
        STATEMENT2
	fi

fi
```

## if - File Exists
```bash
#!/bin/bash

# using [ expression ] syntax and in place 
# of File.txt you can write your file name 
if [ -f "File.txt" ]; 
then

# if file exist the it will be printed 
echo "File is exist"
else

# is it is not exist then it will be printed
echo "File is not exist"
fi
```



#### If File Exists
In this article, we will write a bash script to check if files exist or not. 

### Syntax :

```perl
test [expression]
[ expression ]
[[ expression ]]
```

Here, in expression, we write **parameter** and **file name**. Let us see some parameters that can be used in the expression: –
```bash
–f:  It returns True if the file exists as a common ( regular ) file.
-d: it returns True if directory exists.
-e: It returns True if any type of file exists.
-c: It returns True if the character file exists.
-r: It returns True if a readable file exists.
–w: It returns True if a writable file exists.
-x: It returns True if an executable file exists.
-p: It returns True if the file exists as a pipe.
-S: It returns True if the file exists as a socket.
-s: it returns True if a file exists and the size of the file is not zero.
-L: It returns True if the file of symbolic link exists.
-g: It returns True if the file exists and hold set group id flag is set..
-G: It returns True if the file exists and holds the same group id that is in process.
 -k: It returns True if the file exists and the sticky bit flag is set.
```
Now, there are some more parameters for comparison between the two files.
```bash
-ef: It returns True if both files exist and indicate the same file.
```

**Make Script Executable**
```bash
chmod +x ./FirstFile.sh
./FirstFile.sh
```

### if Directory Exists
```bash
!/bin/bash
if [[ -d "GFG_dir" ]] ; # Here GFG_dir
 is directory and in place of GFG_dir you can write your Directory name
then
echo "Directory is exist" # If GFG_dir exist then it will be printed
else
echo "Directory is not exist" # If GFG_dir is not exist then it will be printed
fi
```

**Creating Persistent Environmental Variable**
```bash
# Below will export a variable from a child process into an environmental variable. Allows system wide calling, however not persistent.
twitter=“Elon Musk”
export $twitter
# Adding the above lines to .bashrc provides persistence. Generates variable at login.
```
---
Source: https://www.geeksforgeeks.org/bash-scripting-how-to-check-if-file-exists/
Tags:

---
## Using Commands in `if` statement in bash

The most fundamental construct in any decision-making structure is an if condition. The general syntax of a basic if statement is as follows:

```bash
if [ condition ]; then
  your code
fi
```

The `if` statement is closed with a `fi` (reverse of if).

**Pay attention to white space!**

-   There must be a space between the opening and closing brackets and the condition you write. Otherwise, the shell will complain of error.
-   There must be space before and after the conditional operator (=, ==, <= etc). Otherwise, you'll see an error like "unary operator expected".

Now, let's create an example script **root.sh.** This script will echo the statement “you are root” only if you run the script as the root user:

```bash
#!/bin/bash

if [ $(whoami) = 'root' ]; then
	echo "You are root"
fi
```

Source: https://linuxhandbook.com/if-else-bash/
