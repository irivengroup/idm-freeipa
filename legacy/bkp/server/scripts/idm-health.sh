#!/usr/bin/env bash
set -euo pipefail
systemctl --no-pager --failed || true
ipactl status || true
ipa-healthcheck --failures-only || true
