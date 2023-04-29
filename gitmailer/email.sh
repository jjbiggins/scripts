#!/bin/bash

git send-email \
    --from="josephjbiggins@icloud.com"  \
    --reply-to="josephjbiggins@icloud.com" \
    --to="joe@biggins.tech" \
    --subject="RAN" \
    --transfer-encoding="7bit" \
    --mailer="Apple Mail (2.3731.300.101.1.3)" \
    --smtp-domain="smtpclient.apple" \
    --smtp-auth="LOGIN PLAIN ATOKEN WSTOKEN WETOKEN" \
    --smtp-pass="jrzj-udsq-jiuo-zhad" \
    --smtp-encryption="tls" \
    --smtp-server="smtp.mail.me.com"  \
    --smtp-server-port=587 \
    --smtp-user="josephjbiggins@icloud.com" \
    ./body.txt
