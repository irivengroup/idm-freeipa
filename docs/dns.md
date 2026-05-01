[← Back to index](index.md)

Breadcrumbs: [Index](index.md) / **DNS**

# DNS and Naming Model

The FreeIPA DNS zone is `iriven.lab`. The project manages core service records needed by clients.

## Required SRV records

```text
_kerberos._tcp.iriven.lab SRV 0 100 88 idmprimarya.iriven.lab.
_kerberos._tcp.iriven.lab SRV 0 100 88 idmreplicab.iriven.lab.
_ldap._tcp.iriven.lab     SRV 0 100 389 idmprimarya.iriven.lab.
_ldap._tcp.iriven.lab     SRV 0 100 389 idmreplicab.iriven.lab.
_ntp._udp.iriven.lab      SRV 0 100 123 idmprimarya.iriven.lab.
_ntp._udp.iriven.lab      SRV 0 100 123 idmreplicab.iriven.lab.
```


## Client resolver configuration

During client enrollment, `NetworkManager` is managed by the `ipa_client` role so enrolled hosts use the IdM DNS servers as nameservers. The nameserver list is built dynamically from the inventory group `idm_servers`, which avoids duplicating IP addresses in variables.

Expected client resolver model:

```text
search iriven.lab
nameserver 192.168.1.51
nameserver 192.168.1.52
options timeout:2 attempts:3
```

This is applied before `ipa-client-install` and re-applied after enrollment to keep Kerberos, LDAP and FreeIPA SRV discovery reliable.

## Managed by role

The `ipa_dns_ntp` role creates or updates these records idempotently.

## Validation

```bash
ipa dnsrecord-find iriven.lab --name=_kerberos._tcp
ipa dnsrecord-find iriven.lab --name=_ldap._tcp
ipa dnsrecord-find iriven.lab --name=_ntp._udp
```

[← Back to index](index.md)
