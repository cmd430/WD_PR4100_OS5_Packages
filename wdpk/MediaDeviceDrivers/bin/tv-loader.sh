#!/bin/sh

if [ -e /var/www/MediaDeviceDrivers/ ] ; then
	. /var/www/MediaDeviceDrivers/media-driver-funcs.sh
else
	echo "media driver function library missing...bye bye"
	exit 1
fi

echo "WD EX family usb tv module loader"

if [ "${1}" == "start" ] ; then

	insert_core_modules

	insert_media_modules

	resume_dvb_devices

elif [ "${1}" == "stop" ] ; then

	suspend_dvb_devices

	remove_media_modules

	remove_core_modules

else
	echo "error, missing parameter..."
	echo -e "\t$0 [start|stop]"
fi

return 0
