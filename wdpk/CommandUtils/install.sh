#!/bin/sh
APP_PATH="$1"
APP_NAME="$(basename $APP_PATH)"

echo $0 $* | tee -a "/tmp/${APP_NAME}.log"

INSTALL_SRC="$1"
INSTALL_DEST="$2"

mv "$INSTALL_SRC" "$INSTALL_DEST"

chmod -R 755 "${APP_PATH}/bin"
chmod -R 755 "${APP_PATH}/terminfo"
chown -R root:root "${APP_PATH}/bin"
chown -R root:root "${APP_PATH}/terminfo"
