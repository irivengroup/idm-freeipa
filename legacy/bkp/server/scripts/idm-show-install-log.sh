#!/usr/bin/env bash
set -euo pipefail
for f in /var/log/ipaserver-install.log /var/log/ipareplica-install.log /var/log/ipaclient-install.log; do
  [ -f "$f" ] && { echo "===== $f ====="; tail -n 200 "$f"; }
done
