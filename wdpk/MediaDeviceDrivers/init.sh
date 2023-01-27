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

initialize "$1"

return 0
