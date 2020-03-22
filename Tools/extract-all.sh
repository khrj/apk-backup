echo THE APKS ARE STORED IN
scriptdir=$(cd ./$(dirname $0)/; pwd)
apkdir=$(cd $scriptdir/../Apks/; pwd)/ # APK DIR, Absolute
echo $apkdir

adb push $apkdir/.gitignore /sdcard/ExtractedApks/
$scriptdir/adb-sync --reverse --delete /sdcard/ExtractedApks/ $apkdir
find $apkdir -name "* *" -type f | rename 's/ /_/g' # Replace spaces with _
