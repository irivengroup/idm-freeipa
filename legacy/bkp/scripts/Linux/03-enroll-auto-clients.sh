#!/usr/bin/env bash
set -euo pipefail
set -a; source .env; set +a
docker compose up -d client-a1 client-a2 client-b1 client-b2 node-a node-b
for c in client-a1 client-a2 client-b1 client-b2; do
  echo "[ENROLL] $c"
  docker exec "$c" bash -lc "ipa-client-install -U --domain='$DOMAIN' --realm='$REALM' --server='idm-primary.$DOMAIN' --principal=admin --password='$IPA_ADMIN_PASSWORD' --mkhomedir --no-ntp || true"
done
