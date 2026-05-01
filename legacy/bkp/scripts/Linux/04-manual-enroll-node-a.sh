#!/usr/bin/env bash
set -euo pipefail
set -a; source .env; set +a
docker exec -it node-a bash -lc "ipa-client-install --domain='$DOMAIN' --realm='$REALM' --server='idm-primary.$DOMAIN' --principal=admin --mkhomedir --no-ntp"
