#!/bin/bash 

DATE_FORMAT=$(date +'%F-%T-%Z')
FILE=$1

#echo $FILE | xargs -n1 basename 


BASENAME=$( basename "$FILE" )
DIRNAME=$( dirname "$FILE" )

if [[ -d "$FILE" ]]; then
    BACKUP_BASENAME="${BASENAME}.bak"
else
    BACKUP_BASENAME="${BASENAME}"
fi




VERSIONS=$(find "${DIRNAME}" -follow -maxdepth 1 -name \*${BASENAME}\* ) 
COUNT=$( echo "${#VERSIONS[*]} - 1" | bc )

if [[ "$COUNT" == 0 ]]; then
    PREFIX=orginial
fi


BACKUP_FILENAME="${PREFIX}.${BACKUP_BASENAME}.${DATE_FORMAT}.bak"
cp "${FILE}" "${DIRNAME}/${BACKUP_FILENAME}"
