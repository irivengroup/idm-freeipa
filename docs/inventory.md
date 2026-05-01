[← Back to index](index.md)

Breadcrumbs: [Index](index.md) / **Inventory**

# Inventory and Variables

Inventory file:

```text
inventory/hosts.ini
```

Group variables:

```text
inventory/group_vars/all.yml
inventory/group_vars/vault.yml
```

## Server grouping

The project explicitly defines IPA servers as a children group:

```ini
[idm_servers:children]
idm_primary
idm_replica
```

This group is used by Chrony, healthcheck and validation playbooks.

## Secrets

Secrets must be placed in `inventory/group_vars/vault.yml` and encrypted with Ansible Vault.

```bash
cp inventory/group_vars/vault.yml.example inventory/group_vars/vault.yml
ansible-vault encrypt inventory/group_vars/vault.yml
```

[← Back to index](index.md)
