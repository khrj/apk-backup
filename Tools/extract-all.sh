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
printf "%s\n${NC}" "${apkdir}"

cd "${apkdir}"
for package in $(adb shell "cmd package list packages -3" | cut -d ":" -f 2)
do
    apks=$(adb shell "cmd package path ${package}" | cut -d ":" -f 2)
    printf "\n"
    if [[ ! -d "${apkdir}"/${package} ]] # If the apk hasn't been previously backed up
    then
        printf "%s has not been backed up before\n" "${package}"
        mkdir "${package}"
        cd "${apkdir}"/"${package}"
        for apk in ${apks}
        do
            adb pull "${apk}"
        done
        cd "${apkdir}"
    else
        printf "%s has been previously backed up\n" "${package}"
        cd "${apkdir}"/"${package}"
        for apk in ${apks}
        do
            apklocal=$(echo "${apk}" | rev | cut -d '/' -f 1 | rev)
            if [[ $(adb shell sha256sum "${apk}" | cut -d ' ' -f 1) != $(sha256sum "${apklocal}" | cut -d ' ' -f 1) ]]
            then
                printf "${ORANGE}%s has been updated since last backup\n${NC}, backing up again" "${apk}"
                rm "${apkdir}"/"${package}"/"${apklocal}"
                adb pull "${apk}"
            else
                printf "${GREEN}%s has not changed since last backup\n${NC}" "${apk}"
            fi
        done
        cd "${apkdir}"
    fi
done
