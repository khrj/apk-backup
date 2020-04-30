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
