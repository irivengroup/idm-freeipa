#!/usr/bin/env bash
set -euo pipefail

ROLE="${IDM_SERVER_ROLE:-init}"
DOMAIN="${DOMAIN:-iriven.lab}"
REALM="${REALM:-${DOMAIN^^}}"
IPA_FQDN="${IPA_FQDN:-$(hostname -f 2>/dev/null || hostname)}"
IPA_ADMIN_PASSWORD="${IPA_ADMIN_PASSWORD:?IPA_ADMIN_PASSWORD is required}"
IPA_DM_PASSWORD="${IPA_DM_PASSWORD:?IPA_DM_PASSWORD is required}"
DNS_FORWARDER_1="${DNS_FORWARDER_1:-}"
DNS_FORWARDER_2="${DNS_FORWARDER_2:-}"
MASTER_HOST="${IDM_MASTER_HOST:-idm-primary.${DOMAIN}}"

forwarder_args=()
if [[ -n "${DNS_FORWARDER_1}" ]]; then
  forwarder_args+=("--forwarder=${DNS_FORWARDER_1}")
fi
if [[ -n "${DNS_FORWARDER_2}" ]]; then
  forwarder_args+=("--forwarder=${DNS_FORWARDER_2}")
fi
if [[ ${#forwarder_args[@]} -eq 0 ]]; then
  forwarder_args+=("--no-forwarders")
fi

common_server_args=(
  --setup-dns
  "${forwarder_args[@]}"
  --auto-reverse
  --allow-zone-overlap
  --no-ntp
  --skip-mem-check
)

case "${ROLE}" in
  master)
    echo "[idmcluster] Preparing primary IdM server install for ${IPA_FQDN} (${DOMAIN}/${REALM})"

    export PASSWORD="${IPA_ADMIN_PASSWORD}"
    export IPA_SERVER_INSTALL_OPTS="$(
      printf '%q ' \
        -U \
        -r "${REALM}" \
        -n "${DOMAIN}" \
        -p "${IPA_DM_PASSWORD}" \
        -a "${IPA_ADMIN_PASSWORD}" \
        "${common_server_args[@]}"
    )"

    exec /usr/sbin/init
    ;;

  replica)
    echo "[idmcluster] Starting replica container in standby mode for ${IPA_FQDN}; master=${MASTER_HOST}"
    echo "[idmcluster] Run scripts/*/02-install-replica-b.* after idm-primary is ready."
    exec /usr/sbin/init
    ;;

  init|standby)
    echo "[idmcluster] Starting FreeIPA container in standby/init mode."
    exec /usr/sbin/init
    ;;

  *)
    echo "[idmcluster] Unknown IDM_SERVER_ROLE='${ROLE}'. Expected: master, replica, init, standby." >&2
    exit 64
    ;;
esac