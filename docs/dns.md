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

## Managed by role

The `ipa_dns_ntp` role creates or updates these records idempotently.

## Validation

```bash
ipa dnsrecord-find iriven.lab --name=_kerberos._tcp
ipa dnsrecord-find iriven.lab --name=_ldap._tcp
ipa dnsrecord-find iriven.lab --name=_ntp._udp
```

[← Back to index](index.md)
