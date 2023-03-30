# Bash Read Command
The read command is just as important as positional parameters and the echo command. Great way to catch user input, accept passwords, write functions, loop, and peek into file descriptors? 

## **What is read?**

Read is a bash builtin command that reads the contents of a line into a variable. It allows for word splitting that is tied to the special shell variable IFS. It is primarily used for catching user input but can be used to implement functions taking input from standard input.

### **Bash read builtin command help**

Before we dive into how to use the read command in bash scripts, here is how we get help. There you should see all the options available for the read command along with descriptions that we will try to cover in the examples.

**Command line**
```bash
help read
```
**Output**
```bash
read: read [-ers] [-a array] [-d delim] [-i text] [-n nchars] [-N nchars]  
 [-p prompt] [-t timeout] [-u fd] [name ...]  
  
Read a line from the standard input and split it into fields.  

Reads a single line from the standard input, or from file descriptor FD  
if the -u option is supplied.  The line is split into fields as with word  
splitting, and the first word is assigned to the first NAME, the second  
word to the second NAME, and so on, with any leftover words assigned to  
the last NAME.  Only the characters found in $IFS are recognized as word  
delimiters.  
   
If no NAMEs are supplied, the line read is stored in the REPLY variable.  
   
Options:  
-a array  assign the words read to sequential indices of the array  
variable ARRAY, starting at zero  
-d delim  continue until the first character of DELIM is read, rather  
than newline  
-e        use Readline to obtain the line in an interactive shell  
-i text   use TEXT as the initial text for Readline  
-n nchars return after reading NCHARS characters rather than waiting  
for a newline, but honor a delimiter if fewer than  
  
NCHARS characters are read before the delimiter  
-N nchars return only after reading exactly NCHARS characters, unless  
EOF is encountered or read times out, ignoring any  
delimiter  
-p prompt output the string PROMPT without a trailing newline before  
attempting to read  
-r        do not allow backslashes to escape any characters  
-s        do not echo input coming from a terminal  
-t timeout        time out and return failure if a complete line of  
input is not read within TIMEOUT seconds.  The value of the  
TMOUT variable is the default timeout.  TIMEOUT may be a  
fractional number.  If TIMEOUT is 0, read returns  
immediately, without trying to read any data, returning  
success only if input is available on the specified  
file descriptor.  The exit status is greater than 128  
if the timeout is exceeded  
-u fd     read from file descriptor FD instead of the standard input  
   
Exit Status:  
The return code is zero, unless end-of-file is encountered, read times out  
(in which case it's greater than 128), a variable assignment err
```
### **Catching user input**

Interactive bash scripts are nothing without catching user input. The read builtin provides methods that user input may be caught within a bash script.

### **Catching a line of input**

To catch a line of input NAMEs and options are not required by read. When NAME is not specified, a variable named REPLY is used to store user input.

**Commands**
```bash
{  
echo -n "Type something and press enter: ";  
read;  
echo You typed ${REPLY}  
}
```
**Output**
```bash
Type something and press enter: something(newline)  
You typed something
```
### **Catching a word of input**

To catch a word of input, the -d option is required. In the case of a word we would set -d to a space, read ‘-d ‘. That is when the user presses the space bar read will load REPLY with the word.

Note: When the -d option is set, the backspace does not work as expected. To backspace, while trying to catch a word of input, the -e option may be used, read -e ‘-d ‘.

**Commands**  
```bash
{  
echo -n "Type something and hit space: ";  
read '-d ';  
echo "";  
echo "You typed ${REPLY}"  
}
```
Output
```bash
Type something and hit space: something(space)  
You typed something
```
### **Prompt user**

In interactive bash scripts prompting a user may require a message to tell the user what input is expected. We can always accomplish this using the echo builtin. However, it turns out there is an option using read.

### Prompt User for a Word

In catching a word of input, we used echo to write Type something and hit space: to standard output before read ‘-d ‘. The -p option allows a message to be displayed before reading from standard input.

**Commands**
```bash
{  
read -p 'Type something and hit space: ' '-d ';  
echo "";  
echo "You typed ${REPLY}"  
}
```
Output
```bash
Type something and hit space: something(space)  
You typed something
```
### Prompt User for a Secret

When catching user input without it showing up int the terminal, the -s option comes in handy. read -s -p allows you to catch and hide user input as follows.

**Commands**
```bash
{  
read -s -p 'Type something I promise to keep it a secret: '  
echo "";  
echo "Your secret is safe with me" ; unset REPLY ;  
echo "${REPLY}"  
}
```
Output
```bash
Type something I promise to keep it a secret:  
Your secret is safe with me
```
## **Functions using `Read`**

Here are examples of functions in bash that use read and standard input

### **Core concept**

Functions using read make use of piped standard input and parameters. Main input to be process such as lines in a file are passed in through standard input via a pipe. Other input if-any and option are passed in as parameters.
```bash
read -t 1 NAME1 NAME2 ...  
   
read is a builtin command
```
-t 1 prevent the bash script from waiting indefinitely for a line to be returned through standard input. If standard input is initially empty, the function returns with an exit code of 142 signifying that no date was read within the set timeout period
```bash
NAME1 NAME2 are variable names  
   
... many variable names may be listed
```
Now that the groundworks are set, let’s see what familiar functions look like implemented using read.

### **Join function using read**

Suppose we want a join function that takes a list of words and returns another list of words joined by a delimiter. Here is how we may implement a join function using read.

Script  
```bash
#!/bin/bash  
## join  
## version 0.0.2 - fix recursion parameters  
##################################################  
join() { { local indelimiter; indelimiter="${1- }" ; local outdelimiter;  
outdelimiter="${2-.}" ; }  
local car  
local cdr  
local IFS  
IFS="${indelimiter}"  
read -t 1 car cdr || return  
test "${cdr}" || { echo "${car}" ; return ; }  
echo "${car}${outdelimiter}${cdr}" | ${FUNCNAME} "${indelimiter}"  
 "${outdelimiter}"  
}  
##################################################  
## generated by create-stub2.sh v0.1.2  
## on Mon, 17 Jun 2019 12:24:59 +0900  
## see <https://github.com/temptemp3/sh2>  
##################################################
```
Source: [join.sh](https://github.com/temptemp3/linuxhint.com/blob/master/join.sh)  
**Command line**
```bash
echo a b | join
```
**Output**
```bash
a.b
```
**Command line**
```bash
echo a b | join | join . \|
```
**Output**
```bash
a|b
```
### **Map functions using read**

Suppose we want a map function that takes a list and returns another list containing the same number of elements that are modified by another function. Here is how we may implement a map function using read.

Script  
```bash 
#!/bin/bash  
## map  
## version 0.0.1 - initial  
##################################################  
map() { { local function_name ; function_name="${1}" ; }  
local car  
local cdr  
local IFS  
IFS="${indelimiter- }"  
read -t 1 car cdr || return  
test "$( declare -f ${function_name} )" || return  
test "${car}" || { true ; return ; }  
${function_name} ${car}  
echo "${cdr}" | ${FUNCNAME} "${function_name}"  
}  
##################################################  
## generated by create-stub2.sh v0.1.2  
## on Tue, 18 Jun 2019 08:33:49 +0900  
## see <https://github.com/temptemp3/sh2>  
##################################################
```
Source: [map.sh](https://github.com/temptemp3/linuxhint.com/blob/master/map.sh)  
**Commands**
```bash
pow() { local -i i=${1} ; echo $(( i ** 2 )) ; }  
echo {1..10} | map pow
```
**Output**
```bash
1  
4  
9  
16  
25  
36  
49  
64  
81  
100
```
### **Filter function using read**

Suppose we want a filter function that takes a list and returns a sublist of elements satisfying conditions set by another function. Here is how we may implement a filter function using read.

Script  
```bash   
#!/bin/bash  
## filter  
## version 0.0.1 - initial  
##################################################  
filter() { { local function_name ; function_name="${1}" ; }  
local car  
local cdr  
local IFS  
IFS="${indelimiter- }"  
read -t 1 car cdr || return  
test "$( declare -f ${function_name} )" || return  
test "${car}" || { true ; return ; }  
${function_name} "${car}" || echo -n "${car} "  
echo "${cdr}" | ${FUNCNAME} "${function_name}"  
}  
##################################################  
## generated by create-stub2.sh v0.1.2  
## on Tue, 18 Jun 2019 13:19:54 +0900  
## see <https://github.com/temptemp3/sh2>  
##################################################
```

Source: [filter.sh](https://github.com/temptemp3/linuxhint.com/blob/master/filter.sh)

**Commands**
```bash
odd() { local -i i=${1} ; test ! $(( i % 2 )) -eq 1 ; }  
echo {1..10} | filter odd
```
**Output**
```bash
1 3 5 7 9
```

## **Loops using read**

Loops using read allow you to iterate through lines of a file that is to be generated or already exists.

### **Basic while read loop for the lefthand side (lhs)**

We have a command or function (lhs) that can generate lines in a file that can be looped through using read and a while loop.
```bash
Construct  
   
lhs | while read  
do  
true  
done  
lhs is a command that returns a list of lines
```
**Commands**
```bash
seq 5 | while read i  
do  
echo ${i}  
done
```
**Output**
```bash
1  
2  
3  
4  
5
```

### **Basic while read loop for the righthand side (rhs)**

We have a file (rhs) with lines that can be looped through using read and a while loop.
```bash
Construct  
   
while read  
do  
true  
done < rhs  
   
rhs is a file containing lines
```

**Commands**
```bash
seq 5 > rhs  
while read i  
do  
echo ${i}  
done < rhs  
```

**Output**  
```bash
1  
2  
3  
4  
5
```
### **Custom lhs while loop using read**

We have a stream of words that we would like to loop through using read.
```bash
Construct  
   
(  
IFS=" "  
lhs | while read  
do  
true  
done  
)  
   
lhs is a list of words
```

**Commands**
```bash
(  
IFS=" "  
echo {1..5} | while read i  
do  
echo "${i}  
done  
)
```

**Output**
```bash
1 2 3 4 5
```

### Reading from any fd instead of standard input

The read builtin option often left untouched is the one that allows you to specific what file descriptor to read from, read -u FD. By default FD is taken to be standard input.

### **Core concept**
---
When a file opened file descriptors are assigned. IO redirection in bash allow a file to be left  open with a specific file descriptor. We are allowed to write to the file, read from it, and close it when we are done.
```bash
_ ()  
{  
cat /dev/null > myfifo; # empty myfifo  
exec 3< myfifo; # open file myfifo as fd 3  
echo "Hello, World! - from fd 3" > myfifo; # write to myfifo  
read -u 3; # read line from fd 3  
exec 3>&-; # close fd 3  
echo ${REPLY} # output line read from fd 3 before closing  
}  
_ # Hello, World! from fd 3
```
### **Building a train with file descriptors and read -u FD**

Just for fun I decided to build a train with file descriptors and read -u FD. To each file descriptor a number is written. Each file descriptor reads from the file descriptor 1 below and appends to itself.

**Command line**
```
bash linuxhint.com/build/test-read-fd.sh train 10
```
**Output**
```bash
initializing fds ...  
initializing fd 3 ...  
fd 3 intialized  
initializing fd 4 ...  
fd 4 intialized  
fds intialized  
reading from fd 3 and 4 ...  
4 3  
fds before cleaning up  
0  1  2  3  4  5  
cleaning up ...  
cleaning up fds ...  
done cleaning up fds  
fds after cleaning up  
0  1  2  3
```
### **Skip function using read -u FD**
If you are running
```bash
uname -a  
MINGW64_NT-10.0 DESKTOP-XVVVVVV 2.7.0(0.307/5/3)  
 2017-02-17 14:20 x86_64 Msys  
bash --version  
GNU bash, version 4.4.12(1)-release (x86_64-pc-msys)
```

It may be possible due to a bug to implement a skip function that skips the following line in a bash script outside of functions before the script source is read. Note that it does not work on most systems. For example,
```bash
uname -a  
Linux 4.9.0-8-amd64 #1 SMP Debian 4.9.144-3.1 (2019-02-19) x86_64 GNU/Linux  
bash --version  
GNU bash, version 4.4.12(1)-release (x86_64-pc-linux-gnu)  
   
skip does not fly.  
   
Function  
   
skip () { read -u 31 ; }  
```


**Commands**
```bash
skip  
echo line skipped  
true
```

**Output**
```bash
(empty)
```
