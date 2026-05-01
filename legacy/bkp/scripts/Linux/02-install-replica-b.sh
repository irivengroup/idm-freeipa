#!/usr/bin/env bash
set -euo pipefail
set -a; source .env; set +a
docker compose up -d idm-replica
sleep 15
docker exec idm-replica bash -lc "echo '$IPA_ADMIN_PASSWORD' | kinit admin"
docker exec idm-replica bash -lc "ipa-client-install -U --domain='$DOMAIN' --realm='$REALM' --server='idm-primary.$DOMAIN' --principal=admin --password='$IPA_ADMIN_PASSWORD' --mkhomedir --no-ntp"
docker exec idm-replica bash -lc "ipa-replica-install -U --setup-dns --forwarder='$DNS_FORWARDER_1' --forwarder='$DNS_FORWARDER_2' --admin-password='$IPA_ADMIN_PASSWORD' --no-ntp --skip-mem-check || tail -n 120 /var/log/ipareplica-install.log"
echo 'Replica demandée. Vérifier: docker exec idm-primary ipa topologysegment-find domain'
