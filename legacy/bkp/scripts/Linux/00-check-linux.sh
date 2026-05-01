#!/usr/bin/env bash
set -euo pipefail
echo '[CHECK] Docker'
docker version
docker compose version
echo '[CHECK] Compose syntax'
docker compose config >/dev/null
echo 'OK - prérequis Linux/Docker valides.'
