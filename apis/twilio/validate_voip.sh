#!/bin/bash

. ${PWD}/conf/twilio.conf 2>/dev/null || \
    echo "File ${PWD}/conf/twilio.conf does not exist. \
	Please create it and set variables ACCOUNT_SID and TWILIO_AUTH_TOKEN"

[ ! $# -eq 1 ] && { echo "Usage: $0 phone_number"; exit 1; }

LOOKUP_BASE_URL="https://lookups.twilio.com/v2/PhoneNumbers"

# country - optional, length may very from 0-3, 
# area - 1st digit cant be 0 or 1, 2nd cant be 9, 3rd any
# line number - any digit 0-9 for a length of 7
REGEX="[1-9]{0,3}[2-9][0-8][0-9][0-9]{7}"

# remove all nonnumeric chars (i.e "+1 (630) 111-2222")
PHONE_NUMBER="${1//[!0-9a-Z]/}"


# Test phone number is valid
! [[ $PHONE_NUMBER =~ ^${REGEX}$ ]] && { echo "Invalide"; exit 1; }


FIELDS="caller_name,line_type_intelligence,call_forwarding,sim_swap,identity_match"
echo "${LOOKUP_BASE_URL}/${PHONE_NUMBER}?Fields=${FIELDS}"
RESPONSE=$(curl \
		-s \
		-X GET \
		"${LOOKUP_BASE_URL}/${PHONE_NUMBER}?Fields=${FIELDS}" \
		-u "${ACCOUNT_SID}:${TWILIO_AUTH_TOKEN}")
		
if command -v jq; then
    echo ${RESPONSE} | jq
elif command -v python3; then
    echo ${RESPONSE} | python3  -m json.tool 
elif command -v python; then
    echo ${RESPONSE} | python -m json.tool
else
    echo ${RESPONSE}
fi
