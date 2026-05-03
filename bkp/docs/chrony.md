[← Back to index](index.md)

Breadcrumbs: [Index](index.md) / **Chrony / NTP**

# Chrony and NTP Configuration

Kerberos requires tightly synchronized time. Even a few minutes of drift can break authentication.

## IPA servers

IPA servers are configured as NTP servers for the lab subnet:

```conf
pool 2.pool.ntp.org iburst
allow 192.168.1.0/24
local stratum 10
```

The `local stratum 10` line lets IPA servers continue serving stable local time if upstream internet NTP is temporarily unavailable.

## Clients and load balancers

Clients use the IPA servers as time sources:

```conf
server idmprimarya.iriven.lab iburst
server idmreplicab.iriven.lab iburst
```

## Firewall

NTP must be opened on IPA servers:

```bash
firewall-cmd --permanent --add-service=ntp
firewall-cmd --reload
```

## Validation

```bash
chronyc sources
timedatectl
```

Expected outcome:

```text
System clock synchronized: yes
```

[← Back to index](index.md)
