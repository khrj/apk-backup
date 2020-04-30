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

read -p "Are you sure you want to uninstall all user apps from your phone (y/n)?" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]
then
    for package in $(adb shell cmd package list packages -3 | cut -d ":" -f 2)
    do
        echo "$package"
        adb uninstall "$package"
    done

fi
