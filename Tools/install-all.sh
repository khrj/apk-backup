scriptdir=$(cd ./$(dirname $0)/; pwd)
apkdir=$(cd $scriptdir/../Apks/; pwd)/ # APK DIR, Absolute
echo THE APKS ARE STORED IN
echo $apkdir

cd $apkdir
for folder in $(ls)
do
    echo $folder
    cd $folder
    if [[ $(ls -1 | wc -l | awk '{print $1}') != '1' ]]
    then
        adb install-multiple ${$(ls | tr "\n" " ")//version/}
    else
        adb install base.apk
    fi
    cd ..
done
