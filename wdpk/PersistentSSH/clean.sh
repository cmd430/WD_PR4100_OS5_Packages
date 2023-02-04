#!/bin/sh

echo $0 $* | tee -a /tmp/PersistentSSH.log

path="$1"

cp -a "/home/root/.ssh" "$path"
rm -f /var/www/PersistentSSH