#!/bin/bash

read -p -r "Are you sure you want to uninstall all user apps from your phone (y/n)?" choice
case "$choice" in
  y|Y )
    for package in $(adb shell cmd package list packages -3 | cut -d ":" -f 2)
    do
        echo "$package"
        adb uninstall "$package"
    done
    ;;
  n|N )
    exit 1
    ;;
  * )
    exit 1
    ;;
esac
