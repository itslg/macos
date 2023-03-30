# Escaping Special Characters (Bash)
To ensure no special characters get applied as modifiers in the desired language, ensure that a password or desired phrase to parse is escaped correctly.
The example below uses double quotes twice, once escaped and the second not escaped.
> -p"\"$PASSWORD\""

### Method #1
---
The following method uses double quotations and backslashes to escape the special characters in the password.
```bash
#!/bin/sh
source pass.cre
/usr/bin/ssh -p 91899 user@remoteHost 'mysqldump -u db_user -p"\"$MYPASSWORD\"" my_database |  gzip -c >  my_database.sql.gz'
```

### Method #2
---
```bash
/usr/bin/ssh -p 91899 user@remoteHost "mysqldump -u db_user -p\"'io#bc@14@9$#jf7AZlk99'\" my_database | gzip -c > my_database.sql.gz"
```

### Examples
---
```bash
% source pass.cre
% ssh user@host mysqldump -u root -p$MYPASSWORD    
user@host's password: 
zsh:1: bad pattern: -p#8111*@uu(

% source pass.cre
% ssh user@host mysqldump -u root -p"$MYPASSWORD"   
user@host's password: 
zsh:1: bad pattern: -p#8111*@uu(

% source pass.cre
% ssh user@host mysqldump -u root -p"\"$MYPASSWORD\""
user@host's password: 
Warning: Using a password on the command line interface can be insecure.
```

Source: https://askubuntu.com/questions/644092/bash-script-and-escaping-special-characters-in-password
