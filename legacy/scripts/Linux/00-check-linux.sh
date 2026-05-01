#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/lib.sh"
load_env
docker version
docker compose version
docker compose config --quiet
echo 'OK - Linux/Docker prerequisites look valid.'
