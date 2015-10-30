#!/system/bin/sh
# Unkilled Toolkit v1.0.1 by Deic

title(){
    red='\033[0;31m'
    nc='\033[0m'
    echo "${red}-= Unkilled Toolkit =-${nc}
"
}

wait_input(){
    $script_dir/busybox stty cbreak -echo
    i=$($script_dir/busybox dd bs=1 count=1 2>/dev/null)
    $script_dir/busybox stty -cbreak echo
}

wait_input_two(){
    $script_dir/busybox stty cbreak -echo
    j=$($script_dir/busybox dd bs=1 count=1 2>/dev/null)
    $script_dir/busybox stty -cbreak echo
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
    $script_dir/busybox chmod 660 /sys/module/lowmemorykiller/parameters/minfree
    $script_dir/busybox cat /sys/module/lowmemorykiller/parameters/minfree > /data/local/tmp/minfree
    echo 10393,14105,18188,27468,31552,37120 > /sys/module/lowmemorykiller/parameters/minfree
    $script_dir/busybox chmod 220 /sys/module/lowmemorykiller/parameters/minfree
    if $script_dir/busybox mv /dev/random /dev/random.orig; then
        $script_dir/busybox ln -s /dev/urandom /dev/random
    fi
    $script_dir/busybox cat /proc/sys/kernel/random/read_wakeup_threshold > /data/local/tmp/read_wakeup_threshold
    $script_dir/busybox cat /proc/sys/kernel/random/write_wakeup_threshold > /data/local/tmp/write_wakeup_threshold
    $script_dir/busybox cat /proc/sys/kernel/randomize_va_space > /data/local/tmp/randomize_va_space
    $script_dir/busybox sysctl -qw kernel.random.read_wakeup_threshold=4096
    $script_dir/busybox sysctl -qw kernel.random.write_wakeup_threshold=4096
    $script_dir/busybox sysctl -qw kernel.randomize_va_space=0
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
            $script_dir/busybox cat /data/local/tmp/minfree > /sys/module/lowmemorykiller/parameters/minfree
            if $script_dir/busybox rm -f /dev/random; then
                $script_dir/busybox mv /dev/random.orig /dev/random
            fi
            $script_dir/busybox sysctl -qw kernel.random.read_wakeup_threshold=$($script_dir/busybox cat /data/local/tmp/read_wakeup_threshold)
            $script_dir/busybox sysctl -qw kernel.random.write_wakeup_threshold=$($script_dir/busybox cat /data/local/tmp/write_wakeup_threshold)
            $script_dir/busybox sysctl -qw kernel.randomize_va_space=$($script_dir/busybox cat /data/local/tmp/randomize_va_space)
            break
        else
            echo 'Write [C] and press [ENTER] to stop boost...'
            $script_dir/busybox sysctl -qw vm.drop_caches=3
            read -t 60 j
        fi
    done
    if [ "$i" == 1 ] || [ "$i" == 2 ] || [ "$i" == 3 ] || [ "$i" == 4 ]; then
        wm size reset
    fi
    $script_dir/busybox kill -9 $($script_dir/busybox pgrep com.madfingergames.unkilled)
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
        $script_dir/sqlite3 "$settings_db" 'SELECT value FROM secure WHERE name = "android_id";' > $android_id_file
        sleep 1
        echo "Backup complete.

A file called 'unkilled_android_id' was created in $EXTERNAL_STORAGE.
Move that file to your other device to restore your Unkilled progress.

Press any key to continue..."

        wait_input
    else
        get_android_id=$($script_dir/busybox cat $android_id_file)
        $script_dir/busybox cat > /data/local/tmp/unkilled_restore_android_id.sh <<-EOF
#!/system/bin/sh
#Script to restore Android ID

red='\033[0;31m'
nc='\033[0m'
echo Restoring Android ID...
$script_dir/sqlite3 "$settings_db" 'UPDATE secure SET value = "$get_android_id" WHERE name = "android_id";'
sleep 1
echo Done.
sleep 1
while clear; do
    echo "${red}-= Unkilled Toolkit =-${nc}

Reboot to apply changes. Reboot now? [Y/N]"
    $script_dir/busybox stty cbreak -echo
    i=replace1
    $script_dir/busybox stty -cbreak echo
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
        $script_dir/busybox sed -i 's/replace1/$(\/data\/local\/unkilled_toolkit\/busybox dd bs=1 count=1 2>\/dev\/null)/' /data/local/tmp/unkilled_restore_android_id.sh
        $script_dir/busybox sed -i 's/replace2/$i/' /data/local/tmp/unkilled_restore_android_id.sh
        sh /data/local/tmp/unkilled_restore_android_id.sh
    fi
}

sh_ota(){ # v2.1_custom By Deic
    # Configuration
    version=v1.0.1
    cloud=https://github.com/DeicPro/Download/releases/download/cloud/unkilled_toolkit.version
    # Optional
    changelog_cloud=https://github.com/DeicPro/Download/releases/download/cloud/unkilled_toolkit.changelog
    # 0/1 = Disabled/Enabled
    show_version=1
    show_changelog=1

    # Don't touch from here
    if [ "$arch" == x86 ]; then
        while clear; do
            title

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

    title

    echo Checking updates...
    if [ "$check_update" == 0 ]; then
        main_menu
    elif [ "$check_update" == 1 ]; then
        am start -a android.intent.action.VIEW $cloud >/dev/null 2>&1
    else
        $script_dir/curl -k -L -s -o /data/local/tmp/unkilled_toolkit.version $cloud
    fi
    if [ "$show_changelog" == 1 ]; then
        if [ "$arch" == x86 ]; then
            file_location=$EXTERNAL_STORAGE/download
        else
            $script_dir/curl -k -L -s -o /data/local/tmp/unkilled_toolkit.changelog $changelog_cloud
            file_location=/data/local/tmp
        fi
    fi
    while :; do
        if [ -f $file_location/unkilled_toolkit.version ]; then
            clear

            title

            if [ "$($script_dir/busybox grep $version $file_location/unkilled_toolkit.version 2>/dev/null)" ]; then
                echo You have the latest version.
                sleep 1
                install=0
                break
            else
                if [ "$show_version" == 1 ]; then
                    version_opt=": $($script_dir/busybox cat $file_location/unkilled_toolkit.version 2>/dev/null | $script_dir/busybox tr '\n' ',' | $script_dir/busybox cut -d ',' -f1)"
                else
                    version_opt=...
                fi
                echo "A new version of the script was found$version_opt
"
                if [ "$show_changelog" == 1 ] && [ -f $file_location/unkilled_toolkit.changelog ]; then
                    $script_dir/busybox cat $file_location/unkilled_toolkit.changelog
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
                    ;;
                esac
            fi
        fi
    done
    if [ "$install"  == 1 ]; then
        clear

        title

        echo Downloading...
        if [ "$arch" == x86 ]; then
            am start -a android.intent.action.VIEW $($script_dir/busybox cat $file_location/unkilled_toolkit.version | $script_dir/busybox tr '\n' ',' | $script_dir/busybox cut -d ',' -f2) >/dev/null 2>&1
        else
            $script_dir/curl -k -L -s -o $file_location/unkilled_toolkit.sh $($script_dir/busybox cat $file_location/unkilled_toolkit.version | $script_dir/busybox tr '\n' ',' | $script_dir/busybox cut -d ',' -f2)
        fi
        sleep 1
    fi
    while :; do
        if [ "$install" == 0 ]; then
            $script_dir/busybox rm -f $file_location/unkilled_toolkit.version
            $script_dir/busybox rm -f $file_location/unkilled_toolkit.changelog
            break
        fi
        if [ -f $file_location/unkilled_toolkit.sh ]; then
            am force-stop com.android.browser 2>/dev/null
            am force-stop com.android.chrome 2>/dev/null
            sleep 5
            echo Installing...
            sleep 5
            $script_dir/busybox cp -f $file_location/unkilled_toolkit.sh $0
            sleep 1
            $script_dir/busybox chmod 755 $0
            $script_dir/busybox rm -f $file_location/unkilled_toolkit.sh
            echo Installed.
            sleep 1
            $script_dir/busybox rm -f $file_location/unkilled_toolkit.version
            $script_dir/busybox rm -f $file_location/unkilled_toolkit.changelog
            sh $0
            clear
            exit
        fi
    done
}

clear

title

script_dir=/data/local/unkilled_toolkit
if [ "$USER" == root ]; then
    mount -w -o remount rootfs
    mount -w -o remount /system
    mkdir -p $script_dir 2>/dev/null
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
        echo Now write 'sh $EXTERNAL_STORAGE/utk' only to run Unkilled Toolkit.
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
if [ -f $script_dir/busybox ]; then
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
            echo Clean up downloaded file...
            rm -f $EXTERNAL_STORAGE/download/busybox.$arch
            sleep 1
            echo Done.
            sleep 1
            break
        fi
    done
fi
if [ "$arch" == x86 ] && [ -f $EXTERNAL_STORAGE/download/unkilled_toolkit.sh ]; then
    echo Installing Unkilled Toolkit...
    $script_dir/busybox cp -f $EXTERNAL_STORAGE/download/unkilled_toolkit.sh /system/xbin/utk
    sleep 1
    echo Setting up permissions...
    $script_dir/busybox chmod 755 /system/xbin/utk
    sleep 1
    echo Clean up downloaded file...
    $script_dir/busybox rm -f $EXTERNAL_STORAGE/download/unkilled_toolkit.sh
    sleep 1
    echo Done.
    sleep 1
    clear
    echo Now write 'utk' only to run Unkilled Toolkit.
    exit
fi
if [ "$arch" == x86 ]; then
    sh_ota

    main_menu
fi
if [ -f $script_dir/curl ]; then
    echo '' >/dev/null 2>&1
else
    curl_cloud=https://github.com/DeicPro/Download/releases/download/cloud/curl.arm
    echo cURL binary not found. Downloading...
    sleep 1
    am start -a android.intent.action.VIEW $curl_cloud >/dev/null 2>&1
    while true; do
        if [ "$($script_dir/busybox wc -c $EXTERNAL_STORAGE/download/curl.arm 2>/dev/null | $script_dir/busybox awk '{print $1}')" == 345616 ]; then
            $script_dir/busybox kill -9 $(pgrep com.android.browser) 2>/dev/null
            $script_dir/busybox kill -9 $(pgrep com.android.chrome) 2>/dev/null
            sleep 1
            echo Copying cURL...
            sleep 1
            $script_dir/busybox cp -f $EXTERNAL_STORAGE/download/curl.arm $script_dir/curl
            sleep 1
            echo Setting up permissions...
            $script_dir/busybox chmod 755 $script_dir/curl
            sleep 1
            echo Cleaning up downloaded file...
            $script_dir/busybox rm -f $EXTERNAL_STORAGE/download/curl.arm
            sleep 1
            echo Done.
            sleep 1
            break
        fi
    done
fi
if [ -f $script_dir/sqlite3 ]; then
    echo '' >/dev/null 2>&1
else
    sqlite_cloud=https://github.com/DeicPro/Download/releases/download/cloud/sqlite3.arm
    echo SQLite3 binary not found. Downloading...
    $script_dir/curl -k -L -s -o /data/local/tmp/sqlite3 $sqlite_cloud 2>/dev/null
    while true; do
        if [ "$($script_dir/busybox wc -c /data/local/tmp/sqlite3 2>/dev/null | $script_dir/busybox awk '{print $1}')" == 877144 ]; then
            sleep 1
            echo Copying SQLite3...
            sleep 1
            $script_dir/busybox cp -f /data/local/tmp/sqlite3 /data/local/unkilled_toolkit
            sleep 1
            echo Setting up permissions...
            $script_dir/busybox chmod 755 $script_dir/sqlite3
            sleep 1
            echo Done.
            sleep 1
            break
        fi
    done
fi
if [ -f $EXTERNAL_STORAGE/download/unkilled_toolkit.sh ]; then
    echo Installing Unkilled Toolkit...
    $script_dir/busybox cp -f $EXTERNAL_STORAGE/download/unkilled_toolkit.sh /system/xbin/utk
    sleep 1
    echo Setting up permissions...
    $script_dir/busybox chmod 755 /system/xbin/utk
    sleep 1
    echo Clean up downloaded file...
    $script_dir/busybox rm -f $EXTERNAL_STORAGE/download/unkilled_toolkit.sh
    sleep 1
    echo Done.
    sleep 1
    clear
    echo Now write 'utk' only to run Unkilled Toolkit.
    exit
fi

sh_ota

main_menu
