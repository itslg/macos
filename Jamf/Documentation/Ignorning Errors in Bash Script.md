# Ignoring Errors in Bash
In order to cause bash to ignore errors for specific commands you can say:

```bash
some-arbitrary-command || true
```

This would make the script continue. For example, if you have the following script:

```bash
$ cat foo
set -e
echo 1
some-arbitrary-command || true
echo 2
```

Executing it would return:

```bash
$ bash foo
1
z: line 3: some-arbitrary-command: command not found
2
```

In the absence of `|| true` in the command line, it'd have produced:

```bash
$ bash foo
1
z: line 3: some-arbitrary-command: command not found
```

Quote from the [manual](http://www.gnu.org/software/bash/manual/bashref.html#The-Set-Builtin):

> The shell does not exit if the command that fails is part of the command list immediately following a `while` or `until` keyword, part of the test in an `if` statement, part of any command executed in a `&&` or `||` list except the command following the final `&&` or `||`, any command in a pipeline but the last, or if the command’s return status is being inverted with `!`. A trap on `ERR`, if set, is executed before the shell exits.

EDIT: In order to change the behaviour such that in the execution should continue _only if_ executing `some-arbitrary-command` returned `file not found` as part of the error, you can say:

```bash
[[ $(some-arbitrary-command 2>&1) =~ "file not found" ]]
```

As an example, execute the following (no file named `MissingFile.txt` exists):

```bash
$ cat foo 
#!/bin/bash
set -u
set -e
foo() {
  rm MissingFile.txt
}
echo 1
[[ $(foo 2>&1) =~ "No such file" ]]
echo 2
$(foo)
echo 3
```

This produces the following output:

```bash
$ bash foo 
1
2
rm: cannot remove `MissingFile.txt': No such file or directory
```

Note that `echo 2` was executed but `echo 3` wasn't.