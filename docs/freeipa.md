[← Back to index](index.md)

Breadcrumbs: [Index](index.md) / **FreeIPA**

# FreeIPA Primary and Replica

## Primary

The primary is installed with DNS enabled and no reverse zone automation by default:

```text
idmprimarya.iriven.lab
```

It is also configured as the CA renewal master.

## Replica

The replica joins the primary and provides DNS/KDC/LDAP/HTTP services:

```text
idmreplicab.iriven.lab
```

## Idempotence

The installation roles check `/etc/ipa/default.conf`. If the file exists, installation is skipped and services are only validated/started.

## Operational checks

```bash
ipactl status
ipa-replica-manage list
ipa topologysegment-find domain
ipa topologysegment-find ca
```

[← Back to index](index.md)
