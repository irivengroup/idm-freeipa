#!/usr/bin/env bash
set -euo pipefail

if [[ -n "${SSH_ROOT_PASSWORD:-}" ]]; then
  echo "root:${SSH_ROOT_PASSWORD}" | chpasswd
fi

sed -i 's/^#\?PermitRootLogin .*/PermitRootLogin yes/' /etc/ssh/sshd_config || true
sed -i 's/^#\?PasswordAuthentication .*/PasswordAuthentication yes/' /etc/ssh/sshd_config || true
mkdir -p /run/sshd
exec /usr/sbin/sshd -D -e
