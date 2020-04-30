# Copyright 2020 Khushraj Rathod
#
# This file is part of ApkBackup.
#
# ApkBackup is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# ApkBackup is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with ApkBackup.  If not, see <https://www.gnu.org/licenses/>.

#!/bin/bash

set -e

# Color coding
GREEN="\033[0;32m"
ORANGE="\033[0;33m"
YELLOW="\033[1;33m"
NC="\033[0m" # No Color

# Start of script
scriptdir=$(cd ./"$(dirname "${0}")"/; pwd)
apkdir=$(cd "${scriptdir}"/../Apks/; pwd)/ # APK DIR, Absolute

declare -a INSTALLED_PACKAGES=()

# shellcheck disable=SC2059
printf "${YELLOW}THE APKS ARE STORED IN\n"
printf "%s\n${NC}" "${apkdir}"

cd "${apkdir}"
for package in $(adb shell "cmd package list packages -3" | cut -d ":" -f 2)
do
    apks=$(adb shell cmd package path "${package}" | cut -d ":" -f 2)
    version=$(adb shell dumpsys package "${package}" | grep versionName | tr -d "[:space:]")
    INSTALLED_PACKAGES+=("${package}")
    printf "\n"
    if [[ ! -d "${apkdir}"/${package} ]] # If the apk hasn't been previously backed up
    then
        printf "%s has not been backed up before\n" "${package}"
        mkdir "${package}"
        cd "${apkdir}"/"${package}"
        echo "${version}" > ./version
        for apk in ${apks}
        do
            adb pull "${apk}"
        done
        cd "${apkdir}"
    else
        cd "${apkdir}"/"${package}"
        if [[ ${version} != $(cat ./version) ]]
        then
            printf "${ORANGE}%s has been updated since last backup, backing up again\n${NC}" "${package}"

            cd ..
            rm -r ./"${package}"
            mkdir "${package}"
            cd "${package}"

            echo "${version}" > ./version
            for apk in ${apks}
            do
                adb pull "${apk}"
            done
        else
            printf "${GREEN}%s has not changed since last backup\n${NC}" "${package}"
        fi
        cd "${apkdir}"
    fi
done

# shellcheck disable=SC2059
printf "\n${YELLOW}Deleting APKs that were uninstalled since last backup\n${NC}"

declare -a REMOVED_PACKAGES=()

for backup in *
do
    [[ -e "$backup" ]] || break
    if [[ ! "${INSTALLED_PACKAGES[*]}" =~ "$(echo "${backup}" | tr -d "[:space:]")" ]]; then
        REMOVED_PACKAGES+=("${backup}")
        rm -r "${apkdir:?}"/"${backup}"
    fi
done

printf "%s\n" "${REMOVED_PACKAGES[@]}"
# shellcheck disable=SC2059
printf "\n${YELLOW}SUCCESS!${NC}\n"
