#!/bin/bash


gen_ssh_key () {
    USER=$1
    HOSTNAME_OR_IP=$2
    KEY_PASSWORD=$3

    ssh-keygen \
	-t rsa \
	-b 4096 \
	-C "${USER}@${HOSTNAME_OR_IP}" \
	-q \
	-f "${HOME}/.ssh/${USER}_at_${HOSTNAME_OR_IP}_id_rsa"
	-N "${KEY_PASSWORD}"
}



copy_ssh_id_top () {

    PRIVATE_KEY=$1
    PORT=$2
    USER_HOSTNAME=$3

    ssh-copy-id \
	-o StrictHostKeyChecking=no \
	-i "${PRIVATE_KEY}" \
	-p "${PORT}" \
	"${USER_HOSTNAME}"
}


write_to_ssh_config () {
    
    HOSTNAME_OR_IP=$1
    PRIVATE_KEY=$2
    PORT=$3

    CONFIG_FILE="${HOME}/.ssh/config"

    cat << EOF >> "$CONFIG_FILE"
    
    Host $HOSTNAME_OR_IP
    	Hostname $HOSTNAME_OR_IP
    	Port $PORT
	AddKeysToAgent yes
        UseKeychain yes
        IdentityFile $PRIV_KEY
EOF
}

