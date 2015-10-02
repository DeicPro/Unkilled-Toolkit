#!/system/bin/sh
#Unkilled Toolkit v1.0 by Deic

title(){
    echo '-= Unkilled Toolkit =-
'
}

wait_input(){
    stty cbreak -echo
    i=$(dd bs=1 count=1 2>/dev/null)
    stty -cbreak echo
}

wait_input_two(){
    stty cbreak -echo
    j=$(dd bs=1 count=1 2>/dev/null)
    stty -cbreak echo
}

main_menu(){
    while clear; do
        title

        echo 'Menu:

 1|Change resolution & Play
 2|Unlock free chest/energy button & Play
 3|Backup/Restore Android ID

 E|xit'

        wait_input

        case $i in
            1)
                change_resolution
            ;;
            2)
                restore_button
            ;;
            3)
                backup_restore
            ;;
            e|E)
                clear
                exit
            ;;
        esac
    done
}

change_resolution(){
    while clear; do
        title

        echo 'Resolution:

 1|1920x1080
 2|1280x720
 3|960x540
 4|640x360

 B|ack'

        wait_input

        if [ "$i" == 1 ] || [ "$i" == 2 ] || [ "$i" == 3 ] || [ "$i" == 4 ]; then
            break
        fi
        if [ "$i" == b ] || [ "$i" == B ]; then
            return 1
        fi
        echo Unknown option.
        sleep 1
    done
    while clear; do
        title

        echo 'Smartphone or tablet? [S/T]'
        if [ "$i" == 1 ]; then
            wait_input_two

            if [ "$j" == s ] || [ "$j" == S ]; then
                resolution=1080x1920
            elif [ "$j" == t ] || [ "$j" == T ]; then
                resolution=1920x1080
            fi
        fi
        if [ "$i" == 2 ]; then
            wait_input_two

            if [ "$j" == s ] || [ "$j" == S ]; then
                resolution=720x1280
            elif [ "$j" == t ] || [ "$j" == T ]; then
                resolution=1280x720
            fi
        fi
        if [ "$i" == 3 ]; then
            wait_input_two

            if [ "$j" == s ] || [ "$j" == S ]; then
                resolution=540x960
            elif [ "$j" == t ] || [ "$j" == T ]; then
                resolution=960x540
            fi
        fi
        if [ "$i" == 4 ]; then
            wait_input_two

            if [ "$j" == s ] || [ "$j" == S ]; then
                resolution=360x640
            elif [ "$j" == t ] || [ "$j" == T ]; then
                resolution=640x360
            fi
        fi
        if [ "$j" == s ] || [ "$j" == S ] || [ "$j" == t ] || [ "$j" == T ]; then
            break
        fi
        echo Unknown option.
        sleep 1
    done
    echo Changing resolution...
    wm size $resolution
    sleep 1
    echo 'Done.
Running Unkilled...'
    am start com.madfingergames.unkilled/com.madfingergames.unityplayer.MFUnityPlayerNativeActivity >/dev/null 2>&1
    sleep 1
    echo 'Done.
Press any key to restore resolution and continue...'

    wait_input

    wm size reset
    am force-stop com.madfingergames.unkilled
    sleep 1
    echo Done.
    sleep 1
}

restore_button(){
    while clear; do
        title

        progress_file=$EXTERNAL_STORAGE/Android/data/com.madfingergames.unkilled/files/users/*/.progress
        echo Restore free chest/energy button...
        sleep 1
        if [ -f $progress_file ]; then
            rm -f $progress_file
            if [ ! -f $progress_file ]; then
                echo Done.
            else
                echo Fail.
            fi
        else
            echo Skipping...
        fi
        sleep 1
        echo Running Unkilled...
        am start com.madfingergames.unkilled/com.madfingergames.unityplayer.MFUnityPlayerNativeActivity >/dev/null 2>&1
        sleep 1
        echo 'Done.
Press any key to continue...'

        wait_input

        am force-stop com.madfingergames.unkilled
        break
    done
}

backup_restore(){
    clear

    title

    if [ -f /system/bin/sqlite3 ] || [ -f /system/xbin/sqlite3 ]; then
        settings_db=/data/data/com.android.providers.settings/databases/settings.db
        android_id_file=$EXTERNAL_STORAGE/unkilled_android_id
        if [ ! -f $android_id_file ]; then
            echo Backing up Android ID...
            sqlite3 "$settings_db" 'SELECT value FROM secure WHERE name = "android_id";' > $android_id_file
            sleep 1
            echo Done.
            sleep 1
        else
            get_android_id=$(cat $android_id_file)
            cat > $EXTERNAL_STORAGE/unkilled_restore_android_id.sh <<-EOF
#!/system/bin/sh
#Script to restore Android ID

echo Restoring Android ID...
sqlite3 "$settings_db" 'UPDATE secure SET value = "$get_android_id" WHERE name = "android_id";'
sleep 1
echo Done.
sleep 1
while clear; do
    echo '-= Unkilled Toolkit =-

Reboot to apply changes. Reboot now? [Y/N]'
    stty cbreak -echo
    i=replace1
    stty -cbreak echo
    case replace2 in
        y|Y)
            reboot
            echo Rebooting...
        ;;
        n|N)
            exit
        ;;
        *)
            echo Unknown option.
            sleep 1
        ;;
    esac
done
EOF
            sed -i 's/replace1/$(dd bs=1 count=1 2>\/dev\/null)/' $EXTERNAL_STORAGE/unkilled_restore_android_id.sh
            sed -i 's/replace2/$i/' $EXTERNAL_STORAGE/unkilled_restore_android_id.sh
            sh $EXTERNAL_STORAGE/unkilled_restore_android_id.sh
        fi
    else
        if [ "$abi" == x86 ] || [ "$abilist" == x86 ]; then
            echo x86 arch is not supported.
            sleep 1
            return 1
        else
            sqlite_cloud=https://github.com/DeicPro/Download/releases/download/Unkilled_Toolkit_Bins/sqlite3.arm-pie
        fi
        echo sqlite3 binary not found. Downloading...
        curl -k -L -o /system/xbin/sqlite3 $sqlite_cloud 2>/dev/null
        while true; do
            if [ -f /system/xbin/sqlite3 ]; then
                sleep 5
                echo Setting up permissions...
                chmod 755 /system/xbin/sqlite3
                sleep 1


                break
            fi
        done
        echo Done.
        sleep 1
    fi
}

clear

title

abi=$(getprop ro.product.cpu.abi)
abilist=$(getprop ro.product.cpu.abilist)
if [ -f /system/bin/busybox ] || [ -f /system/xbin/busybox ]; then
    echo '' >/dev/null 2>&1
else
    if [ "$abi" == x86 ] || [ "$abilist" == x86 ]; then
        arch=i686
    else
        arch=armv7l
    fi
    busybox_cloud="http://www.busybox.net/downloads/binaries/latest/busybox-$arch"
    echo busybox binary not found. Downloading...
    sleep 1
    am start -a android.intent.action.VIEW -n com.android.browser/.BrowserActivity $busybox_cloud >/dev/null 2>&1
    while true; do
        if [ -f $EXTERNAL_STORAGE/download/busybox-$arch* ]; then
            am force-stop com.android.browser
            sleep 10
            echo Copying busybox...
            cp $EXTERNAL_STORAGE/download/busybox-$arch* /system/xbin/busybox
            sleep 1
            echo Setting up permissions...
            chmod 755 /system/xbin/busybox
            sleep 1
            echo Installing...
            busybox --install -s /system/xbin
            sleep 1
            echo Clean up downloaded file...
            rm -f $EXTERNAL_STORAGE/download/busybox-$arch*
            sleep 1
            echo Done.
            sleep 1

            break
        fi
    done
fi
if [ -f /system/bin/curl ] || [ -f /system/xbin/curl ]; then
    echo '' >/dev/null 2>&1
else
    if [ "$abi" == x86 ] || [ "$abilist" == x86 ]; then
        echo '' >/dev/null 2>&1
    else
        curl_cloud=http://curl.haxx.se/gknw.net/7.40.0/dist-android/curl-7.40.0-rtmp-ssh2-ssl-zlib-static-bin-android.tar.gz
        echo curl binary not found. Downloading...
        sleep 1
        am start -a android.intent.action.VIEW -n com.android.browser/.BrowserActivity $curl_cloud >/dev/null 2>&1
        while true; do
            if [ -f $EXTERNAL_STORAGE/download/curl-7.40.0-rtmp-ssh2-ssl-zlib-static-bin-android.tar.gz ]; then
                kill -9 $(pgrep com.android.browser)
                sleep 10
                echo Extracting curl...
                tar -xz -f $EXTERNAL_STORAGE/download/curl-7.40.0-rtmp-ssh2-ssl-zlib-static-bin-android.tar.gz
                while true; do
                    if [ -f $EXTERNAL_STORAGE/download/curl-7.40.0-rtmp-ssh2-ssl-zlib-static-bin-android/RELEASE-NOTES ]; then
                        echo Copying curl...
                        cp $EXTERNAL_STORAGE/download/curl-7.40.0-rtmp-ssh2-ssl-zlib-static-bin-android/data/local/bin/curl /system/xbin/
                        sleep 1
                        echo Setting up permissions...
                        chmod 755 /system/xbin/curl
                        sleep 1
                        echo Cleaning up downloaded file...
                        rm -f $EXTERNAL_STORAGE/download/curl-7.40.0-rtmp-ssh2-ssl-zlib-static-bin-android.tar.gz
                        sleep 1
                        echo Done.
                        sleep 1

                        break
                    fi
                done
                break
            fi
        done
    fi
fi

main_menu
