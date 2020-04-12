# ApkBackup
Lets you backup Apks from your phone and restore them later
Note: Does not backup app data

# Usage

## Backup

Note: Apps must be on internal storage and not on sdcard
Run `Tools/extract-all.sh`

### Features
1. Automatically checks if app has been backup up before, and whether the app has been updated since the backup
2. Completely automatic backup, without any dependencies.
3. Does not require root.

## Restore
Run `Tools/install-all.sh`

## Uninstall
**CAUTION**: Uninstalls all installed user apps from android phone
Run `Tools/uninstall-all.sh`
