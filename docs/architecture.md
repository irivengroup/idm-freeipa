[← Back to index](index.md)

Breadcrumbs: [Index](index.md) / **Architecture**

# Architecture Overview

The IRIVEN IDM PLATFORM provides a resilient identity management platform based on FreeIPA. It includes a primary IPA server, one replica, two load balancers, multiple clients, and an administrative host.

## Logical components

| Component | Role |
|---|---|
| idmprimarya | FreeIPA primary, DNS, KDC, LDAP, CA renewal master |
| idmreplicab | FreeIPA replica, DNS, KDC, LDAP |
| idmloadbalancer1 | HAProxy + Keepalived node |
| idmloadbalancer2 | HAProxy + Keepalived node |
| idmloadbalancer.iriven.lab | Virtual service name mapped to VIP |
| idmadmin | Administration workstation and IPA client |
| idmclient* | Enrolled Linux clients |

## Service flow

<details open>
<summary><strong>Client authentication flow</strong></summary>

1. Client resolves `idmloadbalancer.iriven.lab`.
2. Kerberos traffic reaches HAProxy VIP.
3. HAProxy prefers the primary KDC and fails over to the replica only when needed.
4. LDAP and HTTPS use source-based balancing with replica as backup.
5. SSSD caches identity and policy data locally.

</details>

<details>
<summary><strong>Why Kerberos is handled carefully</strong></summary>

Kerberos is sensitive to time, replay protection, KDC availability, and consistent password state. For this reason, the HAProxy role uses `balance first` and marks the replica as `backup` for Kerberos and password-change traffic.

</details>

## Resilience model

- FreeIPA primary and replica both provide KDC, LDAP, DNS and web/API services.
- HAProxy exposes a stable VIP endpoint.
- Keepalived protects the load balancer VIP.
- Chrony is configured on IPA servers and clients to prevent Kerberos time drift.
- DNS SRV records are managed for LDAP, Kerberos and NTP discovery.

[← Back to index](index.md)
