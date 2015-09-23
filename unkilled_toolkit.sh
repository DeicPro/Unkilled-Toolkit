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
	echo $i
}

main_menu(){
	while clear; do
		title
	
		echo -n ' 1|Change resolution & Play
 2|Unlock free chest/energy button & Play
 3|Backup/Restore Android ID

 E|xit
'

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
				exit
			;;
		esac
	done
}

change_resolution(){
	while clear; do
		title

		echo -n 'Resolution:

 1|1920x1080
 2|1280x720
 3|960x540
 4|640x360

 B|ack
'

		wait_input

		if [ "$i" == 1 ] || [ "$i" == 2 ] || [ "$i" == 3 ] || [ "$i" == 4 ] || [ "$i" == b ] || [ "$i" == B ]; then
			if [ "$i" == b ] || [ "$i" == B ]; then
				break
			fi
			while clear; do
				title

				echo 'Smartphone or tablet? [S/T]
'

			wait_input

				if [ "$i" == 1 ]; then
					if [ "$i" == s ] || [ "$i" == S ]; then
						resolution=1080x1920
		
						break
					elif [ "$i" == t ] || [ "$i" == T ]; then
						resolution=1920x1080

						break
					else
						unset i
					fi
				fi
				if [ "$i" == 2 ]; then
					if [ "$i" == s ] || [ "$i" == S ]; then
						resolution=720x1280

						break
					elif [ "$i" == t ] || [ "$i" == T ]; then
						resolution=1280x720

						break
					else
						unset i
					fi
				fi
				if [ "$i" == 3 ]; then
					if [ "$i" == s ] || [ "$i" == S ]; then
						resolution=540x960

						break
					elif [ "$i" == t ] || [ "$i" == T ]; then
						resolution=960x540

						break
					else
						unset i
					fi
				fi
				if [ "$i" == 4 ]; then
					if [ "$i" == s ] || [ "$i" == S ]; then
						resolution=360x640

						break
					elif [ "$i" == t ] || [ "$i" == T ]; then
						resolution=640x360

						break
					else
						unset i
					fi
				fi
			done
		else
			return
		fi
		echo 'Changing resolution...
'
		wm size $resolution
		echo 'Done

Running Unkilled...
'
		am start com.madfingergames.unkilled/com.madfingergames.unityplayer.MFUnityPlayerNativeActivity 2>&1 >/dev/null
		echo 'Done

Press any key to restore resolution and continue...
'

		wait_input

		wm size reset
		am force-stop com.madfingergames.unkilled
		echo Done
		sleep 1

		break
	done
}

backup_restore(){
	while clear; do
		title
	
		clear

		if [ -f /system/bin/sqlite3 ] || [ -f /system/xbin/sqlite3 ]; then
			if [ ! -f $EXTERNAL_STORAGE/unkilled_android_id ]; then
				echo Copying Android ID to $EXTERNAL_STORAGE/unkilled_android_id
				sqlite3 "data/data/com.android.providers.settings/databases/settings.db" 'SELECT value FROM secure WHERE name = "android_id";' > $EXTERNAL_STORAGE/unkilled_android_id
				echo Done
				sleep 1
			
				break
			else
				sqlite3 "data/data/com.android.providers.settings/databases/settings.db" 'UPDATE secure SET value = "$(cat $EXTERNAL_STORAGE/unkilled_android_id)" WHERE name = "android_id";'
				echo 'Reboot to apply changes. Reboot now? [Y/N]'

				wait_input

				case $i in
					y|Y)
					reboot
					echo Rebooting...
					;;
					n|N)
						break
					;;
				esac
			fi
		else
			echo SQLITE3 binary not found. Downloading...
			wget
			echo Done
		fi
	done
}

restore_button(){
	while clear; do
		title
		
		progress_file=$EXTERNAL_STORAGE/Android/data/com.madfingergames.unkilled/files/users/*/.progress
		echo 'Restore free chest/energy button...
'
		if [ -f $progress_file ]; then
			rm -f $progress_file
			if [ ! -f $progress_file ]; then
				echo 'Done
'
			else
				echo 'Fail
'
			fi
		else
			echo 'Skip
'
		fi
		echo 'Running Unkilled...
'
		am start com.madfingergames.unkilled/com.madfingergames.unityplayer.MFUnityPlayerNativeActivity 2>&1 >/dev/null
		echo 'Done

Press any key to continue...
'

     wait_input

		am force-stop com.madfingergames.unkilled
		break
	done
}

if [ -f /system/bin/busybox ] || [ -f /system/xbin/busybox ]; then
	main_menu
else
	title

	echo BUSYBOX binary not found. Downloading...
	am
	echo Done
fi