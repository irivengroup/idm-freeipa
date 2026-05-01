#!/usr/bin/env bash
set -euo pipefail
docker compose build
docker compose up -d idm-primary
echo 'Suivre installation: docker logs -f idm-primary'
echo 'Quand idm-primary est prêt: ./scripts/Linux/02-install-replica-b.sh'
