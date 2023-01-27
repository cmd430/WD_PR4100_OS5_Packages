#!/bin/sh

for d in wdpk/*/ ; do
  cd "./$d";
  ./build.sh;
  cd ../..
done
