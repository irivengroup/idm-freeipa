#!/usr/bin/env bash
set -euo pipefail
load_env() { set -a; source .env; set +a; }
step() { echo -e "\n> $*"; "$@"; }
wait_container_running() {
  local name="$1" timeout="${2:-900}" start now status
  start=$(date +%s)
  while true; do
    status=$(docker inspect "$name" --format '{{.State.Status}}' 2>/dev/null || true)
    [[ "$status" == "running" ]] && return 0
    now=$(date +%s)
    (( now - start > timeout )) && { echo "Timeout waiting for $name" >&2; return 1; }
    sleep 2
  done
}
