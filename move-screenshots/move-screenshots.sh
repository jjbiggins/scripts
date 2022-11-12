#!/bin/bash


DESKTOP_DIR=${HOME}/Desktop

PICTURES_DIR=${HOME}/Pictures
SCREENSHOTS_DIR=${PICTURES_DIR}/Screenshots

for screenshot in ${DESKTOP_DIR}/Screenshot*.png; do

    echo "FUCK YOU" >> new.log
    SCREENSHOT_DATE=$(echo $screenshot | cut -d ' ' -f2)
    SCREESHOT_DATE_DIR=${SCREENSHOTS_DIR}/${SCREENSHOT_DATE}

    echo "$SCREENSHOT_DATE" >> new.log
    if [[ ! -d "$SCREESHOT_DATE_DIR"  ]]; then
	echo "$SCREESHOT_DATE_DIR does not exist. Create it now...."
    	mkdir ${SCREESHOT_DATE_DIR}
    fi


    FILE_WITH_UNDERSCORES=$(tr -s ' ' '_' <<< "$screenshot")
    mv "$screenshot" "$FILE_WITH_UNDERSCORES"
    echo "$FILE_WITH_UNDERSCORES"
    
    mv "${FILE_WITH_UNDERSCORES}" "${SCREESHOT_DATE_DIR}/$(basename $FILE_WITH_UNDERSCORES)"

    
    if [[ $? == 0 ]]; then
	echo "SUCCESS: file moved to ${SCREESHOT_DATE_DIR}/$(basename $FILE_WITH_UNDERSCORES)" >> new.log
    fi

    if [[ $? == 1 ]]; then
	echo "ERROR: file $FILE_WITH_UNDERSCORES was not able to be moved" >> new.log
    fi

done
