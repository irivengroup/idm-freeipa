[← Back to index](index.md)

Breadcrumbs: [Index](index.md) / **High Availability**

# High Availability Design

The load balancer layer uses HAProxy and Keepalived.

<details open>
<summary><strong>VIP behaviour</strong></summary>

- `idmloadbalancer1` starts as MASTER.
- `idmloadbalancer2` starts as BACKUP.
- VIP: `192.168.1.55`.
- Keepalived tracks HAProxy health.

</details>

<details open>
<summary><strong>HAProxy backend strategy</strong></summary>

- HTTP/HTTPS/LDAP/LDAPS: source-based balancing with replica as backup.
- Kerberos/Kpasswd: `balance first` with replica as backup.

This avoids unstable Kerberos authentication caused by random KDC selection.

</details>

## Validation

```bash
curl -kI https://idmloadbalancer.iriven.lab/ipa/ui/
curl http://192.168.1.55:8404/stats
kdestroy && kinit admin
```

[← Back to index](index.md)
