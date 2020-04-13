#!/bin/bash

set -e

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
    if [[ $(find . | wc -l | awk '{print $1}') != '1' ]]
    then
        adb install-multiple ${$(find . | tr "\n" " ")//version/}
    else
        adb install base.apk
    fi
    cd ..
done
