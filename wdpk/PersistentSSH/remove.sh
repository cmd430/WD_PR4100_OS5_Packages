#!/bin/sh

echo $0 $* | tee -a /tmp/PersistentSSH.log

app_path="$1"

rm -f /var/www/PersistentSSH
rm -rf "$app_path"
