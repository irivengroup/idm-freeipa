#!/usr/bin/env bash
set -euo pipefail
: "${SSH_ROOT_PASSWORD:=rocky}"
echo "root:${SSH_ROOT_PASSWORD}" | chpasswd
sed -ri 's/^#?PermitRootLogin .*/PermitRootLogin yes/' /etc/ssh/sshd_config
sed -ri 's/^#?PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config
/usr/sbin/sshd -D -e
