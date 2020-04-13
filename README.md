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
