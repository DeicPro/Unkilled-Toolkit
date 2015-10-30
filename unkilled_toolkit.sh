#!/system/bin/sh
# Unkilled Toolkit v1.0.1 by Deic

title(){
    red='\033[0;31m'
    nc='\033[0m'
    echo "${red}-= Unkilled Toolkit =-${nc}
"
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

 1|Boost performance & Play
 2|Unlock free treasure chest/energy button
 3|Backup/Restore Android ID

 E|xit'

        wait_input

        case $i in
            1)
                game_boost
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
            *)
                echo Unknown option.
                sleep 1
            ;;
        esac
    done
}

game_boost(){
    while clear; do
        title

        if [ "$non_root" == 1 ]; then
            echo Need a rooted device.
            sleep 1
            return 1
        fi
        echo '- Game Boost -

Resolution:

 1|1920x1080
 2|1280x720
 3|960x540
 4|640x360
 5|Nothing

 B|ack'

        wait_input

        if [ "$i" == 1 ] || [ "$i" == 2 ] || [ "$i" == 3 ] || [ "$i" == 4 ] || [ "$i" == 5 ]; then
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

        if [ "$i" == 1 ] || [ "$i" == 2 ] || [ "$i" == 3 ] || [ "$i" == 4 ]; then
            echo 'Smartphone or tablet? [S/T]'
            if [ "$i" == 1 ]; then
                wait_input_two

                if [ "$j" == s ] || [ "$j" == S ]; then
                    resolution=1080x1920
                    break
                elif [ "$j" == t ] || [ "$j" == T ]; then
                    resolution=1920x1080
                    break
                fi
            fi
            if [ "$i" == 2 ]; then
                wait_input_two

                if [ "$j" == s ] || [ "$j" == S ]; then
                    resolution=720x1280
                    break
                elif [ "$j" == t ] || [ "$j" == T ]; then
                    resolution=1280x720
                    break
                fi
            fi
            if [ "$i" == 3 ]; then
                wait_input_two

                if [ "$j" == s ] || [ "$j" == S ]; then
                    resolution=540x960
                    break
                    elif [ "$j" == t ] || [ "$j" == T ]; then
                    resolution=960x540
                    break
                fi
            fi
            if [ "$i" == 4 ]; then
                wait_input_two

                if [ "$j" == s ] || [ "$j" == S ]; then
                    resolution=360x640
                    break
                elif [ "$j" == t ] || [ "$j" == T ]; then
                    resolution=640x360
                    break
                fi
            fi
            echo Unknown option.
            sleep 1
        fi
        if [ "$i" == 5 ]; then
            break
        fi
    done
    if [ "$i" == 1 ] || [ "$i" == 2 ] || [ "$i" == 3 ] || [ "$i" == 4 ]; then
        echo Changing resolution...
        wm size $resolution
        sleep 1
        echo Done.
        sleep 1
    fi
    echo Boosting performance...
    chmod 660 /sys/module/lowmemorykiller/parameters/minfree
    cat /sys/module/lowmemorykiller/parameters/minfree > /data/local/tmp/minfree
    echo 10393,14105,18188,27468,31552,37120 > /sys/module/lowmemorykiller/parameters/minfree
    chmod 220 /sys/module/lowmemorykiller/parameters/minfree
    if mv /dev/random /dev/random.orig; then
        ln -s /dev/urandom /dev/random
    fi
    cat /proc/sys/kernel/random/read_wakeup_threshold > /data/local/tmp/read_wakeup_threshold
    cat /proc/sys/kernel/random/write_wakeup_threshold > /data/local/tmp/write_wakeup_threshold
    cat /proc/sys/kernel/randomize_va_space > /data/local/tmp/randomize_va_space
    sysctl -qw kernel.random.read_wakeup_threshold=4096
    sysctl -qw kernel.random.write_wakeup_threshold=4096
    sysctl -qw kernel.randomize_va_space=0
    am kill-all 2>/dev/null
    sleep 1
    echo Running Unkilled...
    am start com.madfingergames.unkilled/com.madfingergames.unityplayer.MFUnityPlayerNativeActivity >/dev/null 2>&1
    sleep 1
    echo Done.
    sleep 1
    unset j
    while clear; do
        if [ "$j" == c ] || [ "$j" == C ]; then
            cat /data/local/tmp/minfree > /sys/module/lowmemorykiller/parameters/minfree
            if rm -f /dev/random; then
                mv /dev/random.orig /dev/random
            fi
            sysctl -qw kernel.random.read_wakeup_threshold=$(cat /data/local/tmp/read_wakeup_threshold)
            sysctl -qw kernel.random.write_wakeup_threshold=$(cat /data/local/tmp/write_wakeup_threshold)
            sysctl -qw kernel.randomize_va_space=$(cat /data/local/tmp/randomize_va_space)
            break
        else
            echo 'Write [C] and press [ENTER] to stop boost...'
            sysctl -qw vm.drop_caches=3
            read -t 60 j
        fi
    done
    if [ "$i" == 1 ] || [ "$i" == 2 ] || [ "$i" == 3 ] || [ "$i" == 4 ]; then
        wm size reset
    fi
    kill -9 $(com.madfingergames.unkilled)
    sleep 1
    echo Done.
    sleep 1
}

restore_button(){
    while clear; do
        title

        progress_file=$EXTERNAL_STORAGE/Android/data/com.madfingergames.unkilled/files/users/*/.progress
        echo Restore free treasure chest/energy button...
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
        am start --user 0 com.madfingergames.unkilled/com.madfingergames.unityplayer.MFUnityPlayerNativeActivity >/dev/null 2>&1
        sleep 1
        echo Done.
        sleep 1
        echo Press any key to continue...

        wait_input

        am force-stop com.madfingergames.unkilled 2>/dev/null
        kill -9 $(pgrep com.madfingergames.unkilled) 2>/dev/null
        break
    done
}

backup_restore(){
    clear

    title

    if [ "$non_root" == 1 ]; then
        echo Need a rooted device.
        sleep 1
        return 1
    elif [ "$arch" == x86 ]; then
        echo x86 arch is not supported.
        sleep 1
        return 1
    fi
    settings_db=/data/data/com.android.providers.settings/databases/settings.db
    android_id_file=$EXTERNAL_STORAGE/unkilled_android_id
    if [ ! -f $android_id_file ]; then
        echo Backing up Android ID...
        sqlite3 "$settings_db" 'SELECT value FROM secure WHERE name = "android_id";' > $android_id_file
        sleep 1
        echo "Backup complete.

A file called 'unkilled_android_id' was created in $EXTERNAL_STORAGE.
Move that file to your other device to restore your Unkilled progress.

Press any key to continue..."

        wait_input
    else
        get_android_id=$(cat $android_id_file)
        cat > /data/local/tmp/unkilled_restore_android_id.sh <<-EOF
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
        sed -i 's/replace1/$(dd bs=1 count=1 2>\/dev\/null)/' /data/local/tmp/unkilled_restore_android_id.sh
        sed -i 's/replace2/$i/' /data/local/tmp/unkilled_restore_android_id.sh
        sh /data/local/tmp/unkilled_restore_android_id.sh
    fi
}

sh_ota(){ # v2.1_custom By Deic
    # Configuration
    version=v1.0.1
    cloud=https://github.com/DeicPro/Download/releases/download/cloud/unkilled_toolkit.version
    # Optional
    notes_cloud=https://github.com/DeicPro/Download/releases/download/cloud/unkilled_toolkit.changelog
    # 0/1 = Disabled/Enabled
    show_version=1
    show_changelog=1

    # Don't touch from here
    if [ "$arch" == x86 ]; then
        while clear; do
            echo 'Want check for update? (Y/N)'

            wait_input

            case $i in
                y|Y )
                    check_update=1
                    break
                ;;
                n|N )
                    check_update=0
                    break
                ;;
                * )
                    echo 'Press [Y] or [N] key...'
                    sleep 1
                ;;
            esac
        done
    fi
    clear
    echo Checking updates...
    if [ "$check_update" == 0 ]; then
        main_menu
    elif [ "$check_update" == 1 ]; then
        am start -a android.intent.action.VIEW $cloud >/dev/null 2>&1
    else
        curl -k -L -s -o /data/local/tmp/unkilled_toolkit.version $cloud
    fi
    if [ "$show_changelog" == 1 ]; then
        if [ "$arch" == x86 ]; then
            file_location=$EXTERNAL_STORAGE/download
        else
            curl -k -L -s -o /data/local/tmp/unkilled_toolkit.changelog $notes_cloud
            file_location=/data/local/tmp
        fi
    fi
    while true; do
        if [ -f $file_location/unkilled_toolkit.version ]; then
            sleep 1
            if [ "$(cat $file_location/unkilled_toolkit.version | tr '\n' ',' | cut -d ',' -f1)" == $version ]; then
                clear
                echo You have the latest version.
                sleep 1
                install=0
                break
            else
                if [ "$show_version" == 1 ]; then
                    version_opt=": $(cat $file_location/unkilled_toolkit.version | tr '\n' ',' | cut -d ',' -f1)"
                else
                    version_opt=...
                fi
                clear
                echo "A new version of the script was found$version_opt
"
                if [ "$show_changelog" == 1 ] && [ -f $file_location/unkilled_toolkit.changelog ]; then
                    cat $file_location/unkilled_toolkit.changelog
                    echo
                fi
                echo 'Want install it? (Y/N)'

                wait_input

                case $i in
                    y|Y )
                        install=1
                        break
                    ;;
                    n|N )
                        install=0
                        break
                    ;;
                    * )
                        echo 'Press [Y] or [N] key...'
                        sleep 1
                    ;;
                esac
            fi
        fi
    done
    if [ "$install"  == 1 ]; then
        clear
        echo Downloading...
        if [ "$arch" == x86 ]; then
            am start -a android.intent.action.VIEW $(cat $file_location/unkilled_toolkit.version | tr '\n' ',' | cut -d ',' -f2) >/dev/null 2>&1
        else
            curl -k -L -s -o $file_location/unkilled_toolkit.sh $(cat $file_location/unkilled_toolkit.version | tr '\n' ',' | cut -d ',' -f2)
        fi
        sleep 1
    fi
    while true; do
        if [ "$install" == 0 ]; then
            rm -f $file_location/unkilled_toolkit.version
            rm -f $file_location/unkilled_toolkit.changelog
            break
        fi
        if [ -f $file_location/unkilled_toolkit.sh ]; then
            am force-stop com.android.browser 2>/dev/null
            am force-stop com.android.chrome 2>/dev/null
            sleep 5
            echo Installing...
            sleep 5
            cp -f $file_location/unkilled_toolkit.sh $0
            sleep 1
            chmod 755 $0
            rm -f $file_location/unkilled_toolkit.sh
            echo Installed.
            sleep 1
            rm -f $file_location/unkilled_toolkit.version
            rm -f $file_location/unkilled_toolkit.changelog
            sh $0
            clear
            exit
        fi
    done
}

clear

title

if [ "$USER" == root ]; then
    mount -w -o remount rootfs
    mount -w -o remount /system
    mkdir -p /data/local/unkilled_toolkit 2>/dev/null
    if [ -f /data/local/unkilled_toolkit/busybox ]; then
        for i in $(/data/local/unkilled_toolkit/busybox --list); do
            eval alias ${i}=\"/data/local/unkilled_toolkit/busybox ${i}\"
        done
    fi
else
    if [ -f $EXTERNAL_STORAGE/download/unkilled_toolkit.sh ]; then
        echo Installing Unkilled Toolkit...
        cp -f $EXTERNAL_STORAGE/download/unkilled_toolkit.sh $EXTERNAL_STORAGE/utk
        sleep 1
        echo Clean up downloaded file...
        rm -f $EXTERNAL_STORAGE/download/unkilled_toolkit.sh
        sleep 1
        echo Done.
        sleep 1
        clear
        echo "Now write 'sh $EXTERNAL_STORAGE/utk' only to run Unkilled Toolkit."
        exit
    fi
    non_root=1
    main_menu
fi
if [ "$(getprop ro.product.cpu.abi)" == x86 ] || [ "$(getprop ro.product.cpu.abilist)" == x86 ]; then
    arch=x86
else
    arch=arm
fi
if [ -f /data/local/unkilled_toolkit/busybox ] || [ -f $EXTERNAL_STORAGE/unkilled_toolkit/busybox ]; then
    echo '' >/dev/null 2>&1
else
    if [ "$arch" == x86 ]; then
        busybox_cloud=https://github.com/DeicPro/Download/releases/download/cloud/busybox.x86
        #busybox_size=883644
    else
        busybox_cloud=https://github.com/DeicPro/Download/releases/download/cloud/busybox.arm
        #busybox_size=1469764
    fi
    echo BusyBox binary not found. Downloading...
    sleep 1
    am start -a android.intent.action.VIEW $busybox_cloud >/dev/null 2>&1
    while true; do
        if [ -f $EXTERNAL_STORAGE/download/busybox.$arch ]; then
            am force-stop com.android.browser 2>/dev/null
            am force-stop com.android.chrome 2>/dev/null
            sleep 5
            echo Copying BusyBox...
            sleep 5
            cp -f $EXTERNAL_STORAGE/download/busybox.$arch /data/local/unkilled_toolkit/busybox
            sleep 1
            echo Setting up permissions...
            chmod -R 755 /data/local/unkilled_toolkit
            sleep 1
            echo Installing...
            for i in $(/data/local/unkilled_toolkit/busybox --list); do
                eval alias ${i}=\"/data/local/unkilled_toolkit/busybox ${i}\"
            done
            sleep 1
            echo Clean up downloaded file...
            rm -f $EXTERNAL_STORAGE/download/busybox.$arch
            sleep 1
            echo Done.
            sleep 1
            break
        fi
    done
fi
if [ -f /data/local/tmp/unkilled_toolkit.sh ] || [ -f $EXTERNAL_STORAGE/download/unkilled_toolkit.sh ]; then
    echo Installing Unkilled Toolkit...
    if [ -f /data/local/tmp/unkilled_toolkit.sh ]; then
        cp -f /data/local/tmp/unkilled_toolkit.sh /system/xbin/utk
    fi
    if [ -f $EXTERNAL_STORAGE/download/unkilled_toolkit.sh ]; then
        cp -f $EXTERNAL_STORAGE/download/unkilled_toolkit.sh /system/xbin/utk
    fi
    sleep 1
    echo Setting up permissions...
    chmod 755 /system/xbin/utk
    sleep 1
    echo Clean up downloaded file...
    rm -f /data/local/tmp/unkilled_toolkit.sh
    rm -f $EXTERNAL_STORAGE/download/unkilled_toolkit.sh
    sleep 1
    echo Done.
    sleep 1
    clear
    echo "Now write 'utk' only to run Unkilled Toolkit."
    exit
fi
if [ "$arch" == x86 ]; then
    sh_ota

    main_menu
fi
if [ -f /data/local/unkilled_toolkit/curl ]; then
    echo '' >/dev/null 2>&1
else
    curl_cloud=https://github.com/DeicPro/Download/releases/download/cloud/curl.arm
    echo cURL binary not found. Downloading...
    sleep 1
    am start -a android.intent.action.VIEW $curl_cloud >/dev/null 2>&1
    while true; do
        if [ "$(wc -c $EXTERNAL_STORAGE/download/curl.arm 2>/dev/null | awk '{print $1}')" == 345616 ]; then
            kill -9 $(pgrep com.android.browser) 2>/dev/null
            kill -9 $(pgrep com.android.chrome) 2>/dev/null
            sleep 1
            echo Copying cURL...
            sleep 1
            cp -f $EXTERNAL_STORAGE/download/curl.arm /data/local/unkilled_toolkit/curl
            sleep 1
            echo Setting up permissions...
            chmod 755 /data/local/unkilled_toolkit/curl
            sleep 1
            echo Cleaning up downloaded file...
            rm -f $EXTERNAL_STORAGE/download/curl.arm
            sleep 1
            echo Done.
            sleep 1
            break
        fi
    done
fi
if [ -f /data/local/unkilled_toolkit/sqlite3 ]; then
    echo '' >/dev/null 2>&1
else
    sqlite_cloud=https://github.com/DeicPro/Download/releases/download/cloud/sqlite3.arm
    echo SQLite3 binary not found. Downloading...
    curl -k -L -s -o /data/local/tmp/sqlite3 $sqlite_cloud 2>/dev/null
    while true; do
        if [ "$(wc -c /data/local/tmp/sqlite3 2>/dev/null | awk '{print $1}')" == 877144 ]; then
            sleep 1
            echo Copying SQLite3...
            sleep 1
            cp -f /data/local/tmp/sqlite3 /data/local/unkilled_toolkit
            sleep 1
            echo Setting up permissions...
            chmod 755 /data/local/unkilled_toolkit/sqlite3
            sleep 1
            echo Done.
            sleep 1
            break
        fi
    done
fi

sh_ota

main_menu
