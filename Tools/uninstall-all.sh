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
