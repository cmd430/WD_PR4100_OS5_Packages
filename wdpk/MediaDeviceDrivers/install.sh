#!/bin/sh

echo $0 $* | tee -a /tmp/MediaDrivers.log

path_src="$1"
path_des="$2"

mv "$path_src" "$path_des"


