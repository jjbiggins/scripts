#!/bin/bash


PATH=$1
PICTURES=${HOME}/Pictures
PATH_WITH_UNDERSCORES=`tr -s ' ' '_' <<< ${PATH}"`

IMAGE_PNG=`basename "${PATH_WITH_UNDERSCORES}"`
IMAGE_WEBP="${IMAGE/.png/.webp}"

mv "${PATH}"  "${PICTURES}/${IMAGE_PNG}"
cwebp "${PICTURES}/${IMAGE_PNG}" -o "${PICTURES}/${IMAGE_WEBP}"


