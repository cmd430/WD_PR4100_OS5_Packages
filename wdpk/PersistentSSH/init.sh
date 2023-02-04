#!/bin/sh

echo $0 $* | tee -a /tmp/PersistentSSH.log

path="$1"

ln -s "$path" /var/www/PersistentSSH 2>/dev/null
cp -a "$path/.ssh" "/home/root"
