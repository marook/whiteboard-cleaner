#!/bin/bash

MAX_IMAGE_SIZE=1000x1000

set -e

#-----------------------------------------------------------------------
# main

SOURCE_IMAGE_PATH="$1"
DEST_IMAGE_PATH="$2"

if [ -z "${DEST_IMAGE_PATH}" ]
then
    WORK_IMAGE_PATH=`mktemp`
else
    WORK_IMAGE_PATH="${DEST_IMAGE_PATH}"
fi

convert "${SOURCE_IMAGE_PATH}" -morphology Convolve DoG:15,100,0 -negate -normalize -blur 0x1 -channel RBG -level 60%,91%,0.1 -resize "${MAX_IMAGE_SIZE}>" "${WORK_IMAGE_PATH}"

if [ "${WORK_IMAGE_PATH}" != "${DEST_IMAGE_PATH}" ]
then
    mv "${WORK_IMAGE_PATH}" "${SOURCE_IMAGE_PATH}"
fi
