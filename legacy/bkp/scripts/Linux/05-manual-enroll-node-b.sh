#!/usr/bin/env bash
set -euo pipefail
set -a; source .env; set +a
docker exec -it node-b bash -lc "ipa-client-install --domain='$DOMAIN' --realm='$REALM' --server='idm-replica.$DOMAIN' --principal=admin --mkhomedir --no-ntp"
