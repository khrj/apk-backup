#!/bin/zsh

scriptdir=$(cd ./"$(dirname "$0")"/; pwd)
apkdir=$(cd "$scriptdir"/../Apks/; pwd)/ # APK DIR, Absolute
echo THE APKS ARE STORED IN
echo "$apkdir"

cd "$apkdir"
for folder in *
do
    [[ -e "${folder}" ]] || break
    echo "$folder"
    cd "$folder"
    if [[ $(echo *(.) | wc -l | awk '{print $1}') != '1' ]]
    then
        adb install-multiple ${$(echo *(.) | tr "\n" " ")//version/}
    else
        adb install base.apk
    fi
    cd ..
done
