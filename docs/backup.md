[← Back to index](index.md)

Breadcrumbs: [Index](index.md) / **Backup**

# Backup and Restore

## Manual backup

Run on the FreeIPA primary:

```bash
ipa-backup
```

## Recommended backup strategy

<details open>
<summary><strong>Daily backup</strong></summary>

- Schedule `ipa-backup` daily.
- Copy archives off-host.
- Keep at least 7 daily and 4 weekly backups.

</details>

<details open>
<summary><strong>Restore testing</strong></summary>

- Test restore procedure in a non-production environment.
- Validate LDAP, Kerberos, DNS, CA and replication after restore.

</details>

## Critical note

A FreeIPA backup is security-sensitive. Protect it like a privileged credential.

[← Back to index](index.md)
