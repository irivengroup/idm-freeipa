#!/usr/bin/env bash
set -euo pipefail

echo "root:${SSH_ROOT_PASSWORD}" | chpasswd

mkdir -p /run/sshd
ssh-keygen -A

CLIENT_HOSTNAME="$(hostname -f)"

hostname "${CLIENT_HOSTNAME}" || true
hostnamectl set-hostname "${CLIENT_HOSTNAME}" || true

if ! grep -q "${IPA_SERVER_HOSTNAME}" /etc/hosts; then
  echo "${IPA_SERVER_IP} ${IPA_SERVER_HOSTNAME} ${IPA_SERVER_SHORTNAME:-ipa}" >> /etc/hosts
fi

echo "[INFO] Attente du serveur IPA LDAP/Kerberos/HTTPS..."
until nc -z "${IPA_SERVER_IP}" 389 >/dev/null 2>&1 && nc -z "${IPA_SERVER_IP}" 88 >/dev/null 2>&1 && nc -z "${IPA_SERVER_IP}" 443 >/dev/null 2>&1; do
  sleep 10
done

sleep 30

if [ ! -f /etc/ipa/default.conf ]; then
  echo "[INFO] Enrôlement du client ${CLIENT_HOSTNAME}..."

  ipa-client-install \
    --unattended \
    --domain="${DOMAIN}" \
    --realm="${REALM}" \
    --server="${IPA_SERVER_HOSTNAME}" \
    --principal=admin \
    --password="${IPA_ADMIN_PASSWORD}" \
    --mkhomedir \
    --force-join \
    --no-ntp
else
  echo "[INFO] Client déjà enrôlé."
fi
