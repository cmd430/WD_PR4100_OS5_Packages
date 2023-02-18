#!/bin/sh
APP_PATH="$1"
APP_NAME="$(basename $APP_PATH)"

echo $0 $* | tee -a "/tmp/${APP_NAME}.log"

ln -s "$APP_PATH" "/var/www/${APP_NAME}" 2>/dev/null
find "${APP_PATH}/bin" -maxdepth 1 -type f | while read file;
do 
  ln -s "${file}" "/bin/$(basename "${file}")";
done
echo 'export LC_ALL=en_US.utf8' >> "/home/root/.profile"
ln -sfnT "${APP_PATH}/share/terminfo" "/usr/share/terminfo"
