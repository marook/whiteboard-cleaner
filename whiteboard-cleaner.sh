#!/bin/bash

MAX_IMAGE_SIZE=1000x1000
BLACK_AND_WHITE=0

set -e

usage(){
    cat << EOF
usage: $0 [options] INPUT_FILE [OUTPUT_FILE]

Clean up photographs of whiteboard or paper notes.

OPTIONS:
   -h      Show this message
   -b      'Black and White' image
EOF
}

#-----------------------------------------------------------------------
# main

while getopts "hb" OPTION
do
     case $OPTION in
         h)
             usage
             exit 0
             ;;
         b)
             BLACK_AND_WHITE=1
             ;;
         ?)
             usage
             exit 1
             ;;
     esac
done

# removed arguments parsed by getopts from argument list
shift $(( $OPTIND -1 ))

SOURCE_IMAGE_PATH="$1"
DEST_IMAGE_PATH="$2"

if [ -z "${SOURCE_IMAGE_PATH}" ]
then
    usage
    exit 1
fi

if [ -z "${DEST_IMAGE_PATH}" ]
then
    WORK_IMAGE_PATH=`mktemp`
else
    WORK_IMAGE_PATH="${DEST_IMAGE_PATH}"
fi

POST_PROCESSING=

if [ "${BLACK_AND_WHITE}" == '1' ]
then
    POST_PROCESSING="-type Grayscale -colors 8"
else
    POST_PROCESSING="-colors 64"
fi

convert "${SOURCE_IMAGE_PATH}" -morphology Convolve DoG:15,100,0 -negate -normalize -blur 0x1 -channel RBG -level 60%,91%,0.1 -resize "${MAX_IMAGE_SIZE}>" ${POST_PROCESSING} "${WORK_IMAGE_PATH}"

if [ "${WORK_IMAGE_PATH}" != "${DEST_IMAGE_PATH}" ]
then
    mv "${WORK_IMAGE_PATH}" "${SOURCE_IMAGE_PATH}"
fi
