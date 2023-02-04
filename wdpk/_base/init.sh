#!/bin/sh
APP_PATH="$1"
APP_NAME="$(basename $APP_PATH)"

echo $0 $* | tee -a "/tmp/${APP_NAME}.log"

ln -s "$APP_PATH" "/var/www/${APP_PATH}" 2>/dev/null
