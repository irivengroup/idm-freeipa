[← Back to index](index.md)

Breadcrumbs: [Index](index.md) / **IP Addressing**

# IP Addressing Plan

| Host | FQDN | IP | Purpose |
|---|---|---:|---|
| idmprimarya | idmprimarya.iriven.lab | 192.168.1.51 | FreeIPA primary |
| idmreplicab | idmreplicab.iriven.lab | 192.168.1.52 | FreeIPA replica |
| idmloadbalancer1 | idmloadbalancer1.iriven.lab | 192.168.1.53 | HAProxy/Keepalived node 1 |
| idmloadbalancer2 | idmloadbalancer2.iriven.lab | 192.168.1.54 | HAProxy/Keepalived node 2 |
| idmloadbalancer | idmloadbalancer.iriven.lab | 192.168.1.55 | VIP |
| idmadmin | idmadmin.iriven.lab | 192.168.1.50 | Admin client |
| idmclient1a | idmclient1a.iriven.lab | 192.168.1.61 | IPA client |
| idmclient2a | idmclient2a.iriven.lab | 192.168.1.62 | IPA client |
| idmclient1b | idmclient1b.iriven.lab | 192.168.1.63 | IPA client |
| idmclient2b | idmclient2b.iriven.lab | 192.168.1.64 | IPA client |

## Network

- Domain: `iriven.lab`
- Realm: `IRIVEN.LAB`
- Lab subnet: `192.168.1.0/24`
- VIP: `192.168.1.55`

## Ports

| Service | Port | Protocol |
|---|---:|---|
| HTTP | 80 | TCP |
| HTTPS | 443 | TCP |
| LDAP | 389 | TCP |
| LDAPS | 636 | TCP |
| Kerberos | 88 | TCP |
| kpasswd | 464 | TCP |
| NTP | 123 | UDP |
| HAProxy stats | 8404 | TCP |

[← Back to index](index.md)
