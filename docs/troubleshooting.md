[← Back to index](index.md)

Breadcrumbs: [Index](index.md) / **Troubleshooting**

# Troubleshooting Guide

<details open>
<summary><strong>Kerberos password incorrect but password is correct</strong></summary>

Check HAProxy backend strategy and Chrony time sync:

```bash
chronyc sources
timedatectl
curl http://192.168.1.55:8404/stats
```

Kerberos should not be random round-robin across KDCs.

</details>

<details open>
<summary><strong>Chrony shows ^x or reach 0</strong></summary>

`^x` means source rejected, commonly due to large time offset.

```bash
chronyc tracking
chronyc sources
```

Correct IPA server time first, then restart client Chrony.

</details>

<details open>
<summary><strong>HAProxy fails with admin.sock error</strong></summary>

Ensure runtime directory exists:

```bash
mkdir -p /run/haproxy
chown haproxy:haproxy /run/haproxy
systemctl restart haproxy
```

The role manages this automatically.

</details>

<details>
<summary><strong>IPA client already configured</strong></summary>

Validate before reinstalling:

```bash
klist -k
sssctl domain-status iriven.lab
ipa host-show $(hostname -f)
```

Only uninstall if the join is demonstrably broken.

</details>

[← Back to index](index.md)
