#!/bin/sh

echo $0 $* | tee -a /tmp/MediaDrivers.log

if [ -e /var/www/MediaDeviceDrivers/ ] ; then
	. /var/www/MediaDeviceDrivers/media-driver-funcs.sh
elif [ -e "${1}" ] ; then
	. ${1}/media-driver-funcs.sh
else
	echo "media driver function library missing...bye bye"
	exit 1
fi


cleanup

remove_media_modules

remove_core_modules

return 0
