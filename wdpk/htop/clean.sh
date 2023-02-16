#!/bin/sh
APP_PATH="$1"
APP_NAME="$(basename $APP_PATH)"

echo $0 $* | tee -a "/tmp/${APP_NAME}.log"

rm -f "/var/www/${APP_NAME}"
rm -f "/bin/htop"
ln -sfnT "/usr/local/modules/files/terminfo" "/usr/share/terminfo"
