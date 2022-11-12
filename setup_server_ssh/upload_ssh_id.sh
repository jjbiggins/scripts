#!/usr/bin/expect -f

PRIVATE_KEY=$1
PORT=$2
USER=$3
HOSTNAME_OR_IP=$4
SSH_PASSWORD=$5

spawn ssh-copy-id \
    -i "$PRIVATE_KEY" \
    -p "$PORT" \
    "${USER}@${HOSTNAME_OR_IP}"
expect "password: "
send "${SSH_PASSWORD}\n"
expect eof

