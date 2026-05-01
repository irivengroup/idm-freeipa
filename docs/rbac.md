[← Back to index](index.md)

Breadcrumbs: [Index](index.md) / **RBAC**

# RBAC, Sudo and HBAC

The baseline role creates an initial controlled access model.

## Groups

| Group | Purpose |
|---|---|
| linux-admins | Full Linux administration |
| idm-admins | FreeIPA server administration |
| breakglass-admins | Emergency privileged access |

## Hostgroups

| Hostgroup | Members |
|---|---|
| idm-servers | idmprimarya, idmreplicab |

## Sudo rules

<details open>
<summary><strong>sudo-linux-admins</strong></summary>

- Users: group `linux-admins`
- Hosts: all
- Commands: all
- Option: `!authenticate` for lab convenience

For production, remove `!authenticate` unless explicitly required.

</details>

<details open>
<summary><strong>sudo-idm-admins</strong></summary>

- Users: group `idm-admins`
- Hosts: hostgroup `idm-servers`
- Commands: all

</details>

## HBAC rules

| Rule | Users | Hosts | Service |
|---|---|---|---|
| allow-linux-admins | linux-admins | all | sshd |
| allow-idm-admins | idm-admins | idm-servers | sshd |

## Validation

```bash
ipa sudorule-show sudo-linux-admins
ipa hbacrule-show allow-linux-admins
ssh testadmin@idmadmin.iriven.lab
sudo -l
sudo whoami
```

[← Back to index](index.md)
