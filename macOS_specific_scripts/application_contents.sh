#!/bin/bash


is_executable () {
    FILE_TO_TEST=$1
    
    if [[ ! -f ${FILE_TO_TEST} ]] || [[ -z $FILE_TO_TEST ]] || [[ ! -x $FILE_TO_TEST ]]; then
	false
    elif file "$FILE_TO_TEST" | grep -q executable >/dev/null; then
	true
    fi

    false
}






PREFIX=/opt/private
EXEC_DIR="${PREFIX}/bin"
APPLICATIONS_DIR=/Applications


OLD_IFS=$IFS
IFS=$'\n'


for app in ${APPLICATIONS_DIR}/*.app; do

    APP_CONTENTS_PREFIX=${app}/Contents
    APP_RESOURCES_DIR=${APP_CONTENTS_PREFIX}/Resources
    APP_FRAMEWORKS_DIR=${APP_CONTENTS_PREFIX}/Frameworks
    

    APP_EXEC_DIR=${APP_CONTENTS_PREFIX}/MacOS
    APP_EXECUTABLES=$(ls -1 "${APP_EXEC_DIR}/" )

    for binary in ${APP_EXECUTABLES[@]}; do

	executable="${APP_EXEC_DIR}/${binary}"

	if file $executable | grep -q executable; then
	    # debugging
	    sudo ln -s "'$executable'" "${EXEC_DIR}/$(basename $executable)"
	fi
    done
done

IFS=$OLD_IFS
