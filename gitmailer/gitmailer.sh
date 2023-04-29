#!/bin/bash

git send-email \
    --from="joe@biggins.tech"  \
    --reply-to="joe@biggins.tech" \
    --in-reply-to="joe@biggins.tech" \
    --to="admin@biggins.tech" \
    --subject="RAN" \
    --smtp-domain="smtpclient.apple" \
    --smtp-auth="LOGIN PLAIN ATOKEN WSTOKEN WETOKEN" \
    --smtp-pass="rrmv-eavk-dvvc-nrbj" \
    --smtp-encryption="tls" \
    --smtp-server="smtp.mail.me.com"  \
    --smtp-server-port=587 \
    --smtp-user="josephjbiggins@icloud.com@smtp.mail.me.com" \
    $PWD/body.txt
