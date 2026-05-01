[← Back to index](index.md)

Breadcrumbs: [Index](index.md) / **Vault**

# Secret Management with Ansible Vault

Secrets must not be stored in clear text in Git.

## Create vault file

```bash
cp inventory/group_vars/vault.yml.example inventory/group_vars/vault.yml
vi inventory/group_vars/vault.yml
ansible-vault encrypt inventory/group_vars/vault.yml
```

## Run playbooks

```bash
ansible-playbook --ask-vault-pass playbooks/site.yml
```

## Required secrets

| Variable | Purpose |
|---|---|
| idm_admin_principal | IPA administrative principal |
| idm_admin_password | IPA admin password |
| idm_dm_password | Directory Manager password |

[← Back to index](index.md)
