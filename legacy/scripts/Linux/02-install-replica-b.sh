#!/usr/bin/env bash
set -euo pipefail
source "$(dirname "$0")/lib.sh"
load_env
docker compose up -d idmreplicab
wait_container_running idmreplicab 300
docker exec idmreplicab bash -lc "ipa-replica-install -U --server ${IDM_PRIMARY_FQDN} --domain ${DOMAIN} --realm ${REALM} -p ${IPA_ADMIN_USER} -w '${IPA_ADMIN_PASSWORD}' --setup-dns --forwarder=${DNS_FORWARDER_1} --forwarder=${DNS_FORWARDER_2} --forward-policy=${DNS_FORWARD_POLICY} --no-reverse --no-ntp --no-ssh --no-sshd --no-dns-sshfp --skip-mem-check"
