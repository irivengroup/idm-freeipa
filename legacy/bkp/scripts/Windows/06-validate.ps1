$ErrorActionPreference = "Continue"
docker ps --format "table {{.Names}}\t{{.Status}}\t{{.Ports}}"
docker exec idm-primary bash -lc "ipactl status; echo; ipa host-find --sizelimit=0; echo; dig +short SRV _ldap._tcp.iriven.lab @127.0.0.1"
docker exec client-a1 bash -lc "getent passwd admin || true; dig +short idm-primary.iriven.lab"
