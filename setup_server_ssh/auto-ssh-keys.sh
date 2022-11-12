#!/bin/bash 

USER=$1
HOSTNAME_OR_IP=$2
REMOTE_LOGIN_PASSWORD=$3
PORT=$4
SSH_KEY_PASS=$5


if [[ -z "$USER" || -z "$HOSTNAME_OR_IP" || -z "$REMOTE_LOGIN_PASSWORD" ]]; then
    echo "Usage: $0 USER HOSTNAME_OR_IP REMOTE_LOGIN_PASSWORD [PORT] [PASSWORD]"
    exit 1
fi


if [[ -z "$PORT" ]]; then
    PORT=22
fi


LOGIN="${USER}@${HOSTNAME_OR_IP}" 
PRIV_KEY="${HOME}/.ssh/${USER}_at_${HOSTNAME_OR_IP}_id_rsa" 
CONFIG_FILE="${HOME}/.ssh/config"

ssh-keygen \
    -t rsa \
    -b 4096 \
    -C "${LOGIN}" \
    -q \
    -f "${PRIV_KEY}" \
    -N "${SSH_KEY_PASS}"


COPY_ID_ARGS="-i ${PRIV_KEY} -p ${PORT} ${LOGIN}"
echo "$COPY_ID_ARGS"

sshpass \
    -p "${REMOTE_LOGIN_PASSWORD}" \
ssh-copy-id \
    -o StrictHostKeyChecking=no \
    -i "$PRIV_KEY" \
    -p "$PORT" \
    "$LOGIN"

#spawn ssh-copy-id "$COPY_ID_ARGS"
#expect "password: "
#send "${REMOTE_LOGIN_PASSWORD}\n"
#expect EOF

if [[ $? -eq 1 ]]; then
    echo "ERROR: ssh-copy-id Failed"
    exit 1
fi

cat << EOF >> "$CONFIG_FILE"

Host $HOSTNAME_OR_IP
	Hostname $HOSTNAME_OR_IP
	Port $PORT
	AddKeysToAgent yes
	UseKeychain yes
	IdentityFile $PRIV_KEY
EOF



sshpass \
    -p "$REMOTE_LOGIN_PASS" \
ssh \
    "$LOGIN" \
    -p "$PORT" \
'cat << EOF >> ~/.ssh/config 
Host '$HOSTNAME_OR_IP'
	Hostname '$HOSTNAME_OR_IP'
	Port '$PORT'
	
EOF'
    





