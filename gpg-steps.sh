#!/bin/bash

archive=$1

# gpg --verify [sig or asc file] [archive to verify]
gpg --verify "${archive}".[sa][is][gc] ${archive}

# Likely Response: Example: 
# gpg: assuming signed data in `bash-5.1.16.tar.gz'
# gpg: Signature made Tue Jan  4 10:53:16 2022 CST using DSA key ID 64EA74AB
# gpg: Can't check signature: public key not found

# Get public key from keyserver using key ID
KEYID=$(gpg --verify "${archive}".[sa][is][gc] ${archive} | \
	grep key\ ID | \
	awk '{print $NF}' ) 
gpg --keyserver keyserver.ubuntu.com --recv-keys ${KEYID}
