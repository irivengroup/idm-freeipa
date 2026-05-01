#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/lib.sh"
load_env
docker ps -a --format 'table {{.Names}}\t{{.Status}}\t{{.Ports}}'
echo
docker exec idmprimarya bash -lc 'ipactl status; echo; ipa config-show 2>/dev/null | head -40 || true'
