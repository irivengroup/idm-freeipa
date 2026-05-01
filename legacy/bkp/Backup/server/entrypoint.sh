#!/usr/bin/env bash
set -euo pipefail

echo "root:${SSH_ROOT_PASSWORD}" | chpasswd

mkdir -p /run/sshd /data /run/named
chown named:named /run/named || true
ssh-keygen -A

if ! grep -q "${IPA_SERVER_HOSTNAME}" /etc/hosts; then
  echo "${IPA_SERVER_IP} ${IPA_SERVER_HOSTNAME} ${IPA_SERVER_SHORTNAME:-ipa}" >> /etc/hosts
fi

hostname "${IPA_SERVER_HOSTNAME}" || true
hostnamectl set-hostname "${IPA_SERVER_HOSTNAME}" || true

systemctl daemon-reload || true
systemctl reset-failed named ipa || true

if [ ! -f /data/ipa-installed ]; then
  echo "[INFO] Installation du serveur FreeIPA/IdM..."

  if ! ipa-server-install \
    --unattended \
    --realm="${REALM}" \
    --domain="${DOMAIN}" \
    --hostname="${IPA_SERVER_HOSTNAME}" \
    --ip-address="${IPA_SERVER_IP}" \
    --ds-password="${IPA_DM_PASSWORD}" \
    --admin-password="${IPA_ADMIN_PASSWORD}" \
    --setup-dns \
    --forwarder="${DNS_FORWARDER}" \
    --auto-reverse \
    --allow-zone-overlap \
    --no-dnssec-validation \
    --no-ntp \
    --skip-mem-check; then

    echo "[WARN] ipa-server-install a retourné une erreur. Tentative de démarrage forcé IPA..."
    systemctl daemon-reload || true
    systemctl reset-failed named ipa || true
    ipactl start --ignore-service-failure || true

    if [ ! -f /etc/ipa/default.conf ]; then
      echo "[ERROR] FreeIPA n'est pas configuré. Voir /var/log/ipaserver-install.log"
      exit 1
    fi
  fi

  touch /data/ipa-installed
  echo "[INFO] Installation FreeIPA terminée."
else
  echo "[INFO] FreeIPA déjà installé."
fi

echo "[INFO] Démarrage des services IPA..."
systemctl daemon-reload || true
systemctl unmask named httpd ipa-custodia ipa-dnskeysyncd || true
systemctl reset-failed named ipa || true
ipactl start --ignore-service-failure || ipactl restart --ignore-service-failure || true
ipactl status || true
