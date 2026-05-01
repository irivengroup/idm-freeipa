#!/bin/sh
set -eu

mkdir -p /etc/nginx/certs

if [ ! -f /etc/nginx/certs/ipa-proxy.crt ]; then
  openssl req -x509 -nodes -newkey rsa:2048 -days 3650 \
    -keyout /etc/nginx/certs/ipa-proxy.key \
    -out /etc/nginx/certs/ipa-proxy.crt \
    -subj "/CN=ipa.lab.local" \
    -addext "subjectAltName=DNS:ipa.lab.local,DNS:localhost,IP:127.0.0.1"
fi
