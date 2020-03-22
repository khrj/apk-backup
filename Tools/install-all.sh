echo THE APKS ARE STORED IN
scriptdir=./$(dirname $0)/
apkdir=$(cd $scriptdir/../Apks/; pwd) # APK DIR, Absolute
echo $apkdir

find $apkdir -name "* *" -type f | rename 's/ /_/g' # Replace spaces with _s
for out in $(ls $apkdir)
do
    adb install $apkdir/$out
done
