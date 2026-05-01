#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/lib.sh"
load_env
docker compose up -d idmclient1a idmclient2a idmclient1b idmclient2b idmnode1a idmnode1b
for c in "$IDMCLIENT1A_HOST" "$IDMCLIENT2A_HOST" "$IDMCLIENT1B_HOST" "$IDMCLIENT2B_HOST"; do
  wait_container_running "$c" 300
  fqdn=$(docker inspect "$c" --format '{{.Config.Hostname}}')
  docker exec "$c" bash -lc "ipa-client-install -U --server=${IDM_PRIMARY_FQDN} --domain=${DOMAIN} --realm=${REALM} --hostname=${fqdn} -p ${IPA_ADMIN_USER} -w '${IPA_ADMIN_PASSWORD}' --mkhomedir --no-ntp --force-join"
done
echo 'Manual nodes are running but intentionally not enrolled.'
