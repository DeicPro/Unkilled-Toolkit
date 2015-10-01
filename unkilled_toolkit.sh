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
    am start com.madfingergames.unkilled/com.madfingergames.unityplayer.MFUnityPlayerNativeActivity 2>&1 >/dev/null
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
        am start com.madfingergames.unkilled/com.madfingergames.unityplayer.MFUnityPlayerNativeActivity 2>&1 >/dev/null
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
        echo sqlite3 binary not found. Downloading...
        sqlite_cloud=https://github.com/DeicPro/Download/releases/download/Unkilled_Toolkit_Bins/sqlite3.armv7-pie
        wget -q $sqlite_cloud -O /system/xbin/
        while true; do
            if [ -f /system/xbin/sqlite3.armv7-pie ]; then
                sleep 5
                mv /system/xbin/sqlite3.armv7-pie /system/xbin/sqlite3
                chmod 755 /system/xbin/sqlite3

                break
            fi
        done
        echo Done.
        sleep 1
    fi
}

if [ -f /system/bin/busybox ] || [ -f /system/xbin/busybox ]; then
    main_menu
else
    title
    
    abi=$(getprop ro.product.cpu.abi)
    abilist=$(getprop ro.product.cpu.abilist)
    if [ "$abi" == x86 ] || [ "$abilist" == x86 ]; then
        arch=x86
    else
        arch=arm
    fi
    echo busybox binary not found. Downloading...
    busybox_cloud="https://github.com/DeicPro/Download/releases/download/Unkilled_Toolkit_Bins/busybox.$arch"
    am start -a android.intent.action.VIEW -n com.android.browser/.BrowserActivity $busybox_cloud 2>&1 >/dev/null
    while true; do
        if [ -f $EXTERNAL_STORAGE/download/busybox.bin ]; then
            am force-stop com.android.browser
            sleep 5
            cp $EXTERNAL_STORAGE/download/busybox.bin /system/xbin/busybox
            chmod 755 /system/xbin/busybox
            busybox --install -s /system/xbin
            rm -f $EXTERNAL_STORAGE/download/busybox.bin

            break
        fi
    done
    echo Done.
    sleep 1

    main_menu
fi
