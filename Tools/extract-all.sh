scriptdir=$(cd ./$(dirname $0)/; pwd)
apkdir=$(cd $scriptdir/../Apks/; pwd)/ # APK DIR, Absolute
echo THE APKS ARE STORED IN
echo $apkdir

cd $apkdir
for package in $(adb shell "cmd package list packages -3" | cut -d ":" -f 2)
do
    apks=$(adb shell "cmd package path $package" | cut -d ":" -f 2)
    folder=$(echo $apks | cut -d ' ' -f 1 | rev | cut -d '/' -f 2 | rev)
    echo
    if [[ ! -d $folder ]]
    then
        mkdir $folder
        cd $folder
        for apk in $apks
        do
            adb pull $apk
        done
        cd ..
    fi
done
