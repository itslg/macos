# Create .APP's from Shell Scripts
The internal folder structure may vary between apps, but you can be sure that every Mac app will have a `Contents` folder with a `MacOS` subfolder in it. Inside the `MacOS` directory, there’s an extension-less file with the exact same name as the app itself. This file can be anything really, but in its simplest form it’s a shell script. As it turns out, this folder/file structure is all it takes to create a functional app.

After this discovery, [Thomas Aylott](http://subtlegradient.com/) came up with [a clever “appify” script](https://gist.github.com/mathiasbynens/674099) that allows you to easily create Mac apps from shell scripts. 

## Instructions:
```
#Open Terminal
sudo nano /usr/local/bin/appify
```
*Paste the following contents:*
```
#!/usr/bin/env bash  
  
APPNAME=${2:-$(basename "${1}" '.sh')};  
DIR="${APPNAME}.app/Contents/MacOS";  
  
if [ -a "${APPNAME}.app" ]; then  
echo "${PWD}/${APPNAME}.app already exists :(";  
exit 1;  
fi;  
  
mkdir -p "${DIR}";  
cp "${1}" "${DIR}/${APPNAME}";  
chmod +x "${DIR}/${APPNAME}";  
  
echo "${PWD}/$APPNAME.app";
```
*Chmod the file to make it executable:*
```
chmod +x /usr/local/bin/appify
```

## Operational Syntax
```
appify ~/Desktop/CrazyHardcoreHackingScript.sh "Do Not Open.app"

```