#!/bin/sh

echo $0 $* | tee -a /tmp/PersistentSSH.log

path_src="$1"
path_des="$2"

cp -a "/home/root/.ssh" "$path_src"
mv "$path_src" "$path_des"
