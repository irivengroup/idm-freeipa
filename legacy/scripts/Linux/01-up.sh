#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/lib.sh"
load_env
docker compose config --quiet
docker compose build idmclient1a idmclient2a idmclient1b idmclient2b idmnode1a idmnode1b
docker compose up -d idmprimarya
echo 'Follow primary install: docker logs -f idmprimarya'
echo 'Validate when finished: ./scripts/Linux/04-status.sh'
