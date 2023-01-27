#!/bin/sh

APP_NAME="$(basename $(pwd))"
DATE="$(date +"%m%d%Y")"
CWD="$(pwd)"
VERSION="$(awk '/Version/{print $NF}' apkg.rc)"

echo "Building ${APP_NAME} version ${VERSION}"

RELEASE_DIR="../../packages/${APP_NAME}"
mkdir -p "${RELEASE_DIR}"

MODELS="MyCloudPR4100-PR4100"

for fullmodel in $MODELS; do
  model=${fullmodel%-*}
  name=${fullmodel#*-}
  echo "$model  $name"
  ../../mksapkg -E -s -m $model > /dev/null
  mv ../${model}*.bin* "${RELEASE_DIR}/${APP_NAME}_${VERSION}_${name}_OS5.bin"
done

echo "Bundle sources"
SRC_TAR="${RELEASE_DIR}/${APP_NAME}_${VERSION}_OS5_src.tar.gz"
tar -czf $SRC_TAR .


