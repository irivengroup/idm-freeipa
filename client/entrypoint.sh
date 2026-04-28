#!/usr/bin/env bash
set -euo pipefail

echo "root:${SSH_ROOT_PASSWORD}" | chpasswd

mkdir -p /run/sshd
ssh-keygen -A

CLIENT_HOSTNAME="$(hostname -f)"
hostname "${CLIENT_HOSTNAME}" || true

grep -q "${IPA_SERVER_HOSTNAME}" /etc/hosts || echo "${IPA_SERVER_IP} ${IPA_SERVER_HOSTNAME} ipa" >> /etc/hosts

echo "[INFO] Attente du serveur IPA LDAP..."
until nc -z "${IPA_SERVER_IP}" 389 >/dev/null 2>&1; do
  sleep 10
done

echo "[INFO] Attente supplémentaire des services IPA..."
sleep 45

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

echo "[INFO] Démarrage systemd..."
exec /usr/sbin/init
