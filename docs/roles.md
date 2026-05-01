[← Back to index](index.md)

Breadcrumbs: [Index](index.md) / **Roles**

# Ansible Roles

The project uses roles to keep playbooks short and predictable.

| Role | Responsibility |
|---|---|
| common_hosts | Hostname and local hosts baseline |
| chrony_server | NTP server configuration on IPA servers |
| chrony_client | NTP client configuration on clients/LBs/admin |
| ipa_primary | FreeIPA primary installation and service setup |
| ipa_replica | FreeIPA replica installation and service setup |
| ipa_client | FreeIPA client enrollment |
| haproxy_freeipa_lb | HAProxy and Keepalived configuration |
| ipa_dns_ntp | DNS SRV records for Kerberos/LDAP/NTP |
| ipa_rbac | Baseline groups, sudo and HBAC policies |
| ipa_healthcheck | Healthcheck package, PKI permission correction, healthcheck run |
| validation | End-to-end platform checks |

<details open>
<summary><strong>Idempotence principles</strong></summary>

- Existing IPA installation is detected using `/etc/ipa/default.conf`.
- HAProxy configuration is validated before deployment.
- DNS records are added or modified rather than duplicated.
- IPA groups/rules are checked before creation.
- Chrony files are template-managed.
- Runtime directories are explicitly created.

</details>

<details>
<summary><strong>Resilience principles</strong></summary>

- Services are enabled and started.
- HAProxy config changes are validated before reload.
- Keepalived tracks HAProxy health.
- Chrony is configured before IPA-sensitive validations.
- Replica and primary are both checked independently.

</details>

[← Back to index](index.md)
