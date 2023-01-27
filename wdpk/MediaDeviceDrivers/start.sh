#!/bin/sh

echo $0 $* | tee -a /tmp/MediaDrivers.log

if [ -e /var/www/MediaDeviceDrivers/ ] ; then
	. /var/www/MediaDeviceDrivers/media-driver-funcs.sh
elif [ -e "${1}" ] ; then
	. ${1}/media-driver-funcs.sh
else
	echo "media driver function library missing...bye bye" | tee -a /tmp/MediaDrivers.log
	exit 1
fi

echo "WD EX family usb tv module loader"

insert_core_modules

insert_media_modules

resume_dvb_devices

return 0
