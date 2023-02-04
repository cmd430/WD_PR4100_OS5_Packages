#!/bin/sh

for d in wdpk/*/ ; do
  [ "$d" = "wdpk/_base/" ] && continue
  cd "./$d";
  ./build.sh;
  cd ../..
done
