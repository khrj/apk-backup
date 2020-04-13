#!/bin/bash

set -e

# Color coding
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Start of script
scriptdir=$(cd ./"$(dirname "${0}")"/; pwd)
apkdir=$(cd "${scriptdir}"/../Apks/; pwd)/ # APK DIR, Absolute

printf "${YELLOW}THE APKS ARE STORED IN\n"
printf "${apkdir}\n${NC}"

cd "${apkdir}"
for package in $(adb shell "cmd package list packages -3" | cut -d ":" -f 2)
do
    apks=$(adb shell "cmd package path ${package}" | cut -d ":" -f 2)
    folder=$(echo "${apks}" | tr '\n' ' ' | cut -d ' ' -f 1 | rev | cut -d '/' -f 2 | rev | cut -d '-' -f 1)
    printf "\n"
    if [[ ! -d "${apkdir}"/${folder} ]] # If the apk hasn't been previously backed up
    then
        printf "${folder} has not been backed up before\n"
        mkdir "${folder}"
        cd "${apkdir}"/"${folder}"
        for apk in ${apks}
        do
            adb pull "${apk}"
        done
        cd "${apkdir}"
    else
        printf "${folder} has been previously backed up\n"
        cd "${apkdir}"/"${folder}"
        for apk in ${apks}
        do
            apklocal=$(echo "${apk}" | rev | cut -d '/' -f 1 | rev)
            if [[ $(adb shell sha256sum "${apk}" | cut -d ' ' -f 1) != $(sha256sum "${apklocal}" | cut -d ' ' -f 1) ]]
            then
                printf "${ORANGE}${apk} has been updated since last backup\n${NC}, backing up again"
                rm "${apkdir}"/"${folder}"/"${apklocal}"
                adb pull "${apk}"
            else
                printf "${GREEN}${apk} has not changed since last backup\n${NC}"
            fi
        done
        cd "$apkdir"
    fi
done
