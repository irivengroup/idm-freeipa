[← Back to index](index.md)

Breadcrumbs: [Index](index.md) / **Load Balancers**

# Load Balancers

The `haproxy_freeipa_lb` role configures both HAProxy and Keepalived.

## HAProxy listeners

| Frontend | Port | Backend |
|---|---:|---|
| idm_http | 80 | ipa_http |
| idm_https | 443 | ipa_https |
| idm_ldap | 389 | ipa_ldap |
| idm_ldaps | 636 | ipa_ldaps |
| idm_kerberos_tcp | 88 | ipa_kerberos_tcp |
| idm_kpasswd_tcp | 464 | ipa_kpasswd_tcp |
| stats | 8404 | local stats |

## Keepalived

- MASTER: `idmloadbalancer1`
- BACKUP: `idmloadbalancer2`
- VIP: `192.168.1.55`

## Validation

```bash
curl -kI https://192.168.1.55/ipa/ui/
curl http://192.168.1.55:8404/stats
```

[← Back to index](index.md)
