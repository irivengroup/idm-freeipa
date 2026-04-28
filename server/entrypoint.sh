#!/usr/bin/env bash
set -euo pipefail

echo "root:${SSH_ROOT_PASSWORD}" | chpasswd

mkdir -p /run/sshd /data
ssh-keygen -A

grep -q "${IPA_SERVER_HOSTNAME}" /etc/hosts || echo "${IPA_SERVER_IP} ${IPA_SERVER_HOSTNAME} ipa" >> /etc/hosts

hostname "${IPA_SERVER_HOSTNAME}" || true

if [ ! -f /data/ipa-installed ]; then
  echo "[INFO] Installation du serveur FreeIPA/IdM..."

  ipa-server-install \
    --unattended \
    --realm="${REALM}" \
    --domain="${DOMAIN}" \
    --hostname="${IPA_SERVER_HOSTNAME}" \
    --ds-password="${IPA_DM_PASSWORD}" \
    --admin-password="${IPA_ADMIN_PASSWORD}" \
    --setup-dns \
    --forwarder="${DNS_FORWARDER}" \
    --auto-reverse \
    --no-ntp

  touch /data/ipa-installed
else
  echo "[INFO] FreeIPA déjà installé."
fi

echo "[INFO] Démarrage systemd..."
exec /usr/sbin/init
