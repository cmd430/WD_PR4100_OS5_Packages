#!/bin/sh
APP_PATH="$1"
APP_NAME="$(basename $APP_PATH)"

echo $0 $* | tee -a "/tmp/${APP_NAME}.log"

ln -s "$APP_PATH" "/var/www/${APP_NAME}" 2>/dev/null
ln -s "${APP_PATH}/bin/htop" "/bin/htop"
ln -sfnT "${APP_PATH}/terminfo" "/usr/share/terminfo"

