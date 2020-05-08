# ApkBackup
Lets you backup Apks from your phone and restore them later

# Usage

## Backup

Run `Tools/extract-all.sh`

## Restore
Run `Tools/install-all.sh`

## Uninstall
**CAUTION**: Uninstalls all installed user apps from android phone

Run `Tools/uninstall-all.sh`

# Features
1. Automatically checks if app has been backup up before, and whether the app has been updated since the backup
2. Completely automatic backup, without any dependencies.
3. Does not require root.
4. Supports Split apks
5. Does not require any configuration, and doesn't have any options

# Caveats
1. Apps cannot be on external sdcard
2. Does not backup app data

# For dummies
- [What is adb?](https://www.xda-developers.com/what-is-adb/)
- Where should I download adb and fastboot without downloading the entire android sdk? Downloads: [Windows](https://dl.google.com/android/repository/platform-tools-latest-windows.zip), [macOS](https://dl.google.com/android/repository/platform-tools-latest-darwin.zip), [Linux](https://dl.google.com/android/repository/platform-tools-latest-linux.zip) (These links are maintained by google, you should always get the latest versions)
- How do I download this repository? First [install git](https://phoenixnap.com/kb/how-to-install-git-windows), then [clone the repository](https://help.github.com/en/github/creating-cloning-and-archiving-repositories/cloning-a-repository), or just [download as zip](https://stackoverflow.com/a/2751270).
- How do I install the apks? You need to run install.sh. See how to run a shell script on [windows](https://www.thewindowsclub.com/how-to-run-sh-or-shell-script-file-in-windows-10), [macOS/Linux](https://askubuntu.com/a/38670) 
