#!/bin/sh
APP_PATH="$1"
APP_NAME="$(basename $APP_PATH)"

echo $0 $* | tee -a "/tmp/${APP_NAME}.log"

rm -f "/var/www/${APP_NAME}"
find "${APP_PATH}/bin" -maxdepth 1 -type f | while read file;
do 
  rm -f "/bin/$(basename "${file}")";
  rm -rf "/home/root/.config/$(basename "${file}")"
done
rm -f "/home/root/.profile"
ln -sfnT "/usr/local/modules/files/terminfo" "/usr/share/terminfo"
