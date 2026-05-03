# Role `secrets_baseline`

Validates that required sensitive variables are provided and that the local Vault file is encrypted.

## Scope

This role runs local checks and should be executed before production deployment.

## Required variables

- `idm_admin_password`
- `idm_dm_password`

## Expected Vault file

```text
inventory/group_vars/all/vault.yml
```

This file must be encrypted with Ansible Vault.
