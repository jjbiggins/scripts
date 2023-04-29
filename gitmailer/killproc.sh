#!/bin/bash


config_mail_file () {
    MAILFILE=$1
    SUBJECT=$2
    MSG=$3
    LOGFILE=$4

    echo "Subject: ${SUBJECT}" >> "${MAILFILE}"
    if [[ ! -z "${MSG}" ]]; then echo -en "\n${MSG}\n" >> "${MAILFILE}"; fi


    if [[ -f "${LOGFILE}" ]]; then 
	echo -en "\nLOGS\n-------------------------------------------------------------------" >> "${MAILFILE}"
	cat "${LOGFILE}" >> "${MAILFILE}"
    fi
}




# program vars
PROCESS=$1
FNAME=$(TMP="${0#./}"; echo "${TMP%%.*}")
LOGFILE="${HOME}/${FNAME}-${PROCESS}.log"


# mail vars
MAILFILE="./mail-message.txt"
SUBJECT="Execute Logs: ${FNAME} ${PROCESS}"
MSG=" "


call () {
    echo "`date +'%a %D %T'` --> $@" | tee -a ${LOGFILE}
    "$@" 2>&1 | tee -a ${LOGFILE}
    [ ${PIPESTATUS[0]} -ne 0 ] && bad_exit "Failed!"
}


echo -en "\n\nPROCESS TO KILL: ${PROCESS}\n" >> ${LOGFILE}
#for pid in $(ps -Acf | grep "${PROCESS}" | awk '{print $3}'); do echo "jgb8255" | call sudo -S kill "$pid"; done
#for pid in $(ps -Acf | grep "${PROCESS}" | awk '{print $2}'); do echo "jgb8255" | call sudo -S kill "$pid"; done


cat << EOF >>  ${LOGFILE}
\n\nExecute: ps -Acf
--------------------------------------------------------------
ps -Acf | grep $PROCESS
EOF


config_mail_file "${MAILFILE}" "${SUBJECT}" "${MSG}" "${LOGFILE}"
#git_send_mail "${MAILFILE}"

git send-email \
    --from="josephjbiggins@icloud.com"  \
    --reply-to="josephjbiggins@icloud.com" \
    --in-reply-to="josephjbiggins@icloud.com" \
    --to="joe@biggins.tech" \
    --subject="RAN" \
    --smtp-domain="smtpclient.apple" \
    --smtp-auth="LOGIN PLAIN ATOKEN WSTOKEN WETOKEN" \
    --smtp-pass="rrmv-eavk-dvvc-nrbj" \
    --smtp-encryption="tls" \
    --smtp-server="smtp.mail.me.com"  \
    --smtp-server-port=587 \
    --smtp-user="josephjbiggins@icloud.com@smtp.mail.me.com" \
    ./mail-message.txt

#FROM="josephjbiggins@icloud.com"
#REPLY_TO="$FROM"
#RCPT_TO="joe@biggins"
#IN_REPLY_TO=""
#RCPT_TO="joe@biggins.tech"
#SMTP_DOMAIN="smtpclient.apple"
#SMTP_AUTH="LOGIN PLAIN ATOKEN WSTOKEN WETOKEN"
#OT="jrzj-udsq-jiuo-zha"
#SMTP_SERVER="smtp.mail.me.com"
#SMTP_PORT=587
#USERNAME="josephjbiggins@icloud.com"
#SMTP_USER="${USERNAME}@${SMTP_SERVER}"
#
#
#git send-email \
#    --from="$FROM"  \
#    --reply-to="${REPLY_TO}" \
#    --in-reply-to="${IN_REPLY_TO}" \
#    --to="${RCPT_TO}" \
#    --smtp-domain="${SMTP_DOMAIN}" \
#    --smtp-auth="${SMTP_AUTH}" \
#    --smtp-pass="${OTP}" \
#    --smtp-encryption="tls" \
#    --smtp-server="${SMTP_SERVER}"  \
#    --smtp-server-port="${SMTP_PORT}" \
#    --smtp-user="${SMTP_USER}" \
#    "${MAILFILE}"

