#!/bin/bash

echo "/etc/systemd/resolved.conf 
DNS=45.90.28.0#cd4873.dns.nextdns.io
DNS=2a07:a8c0::#cd4873.dns.nextdns.io
DNS=45.90.30.0#cd4873.dns.nextdns.io
DNS=2a07:a8c1::#cd4873.dns.nextdns.io
DNSOverTLS=yes" | sudo tee -a /etc/systemd/resolved.conf

sudo systemctl restart systemd-resolved
