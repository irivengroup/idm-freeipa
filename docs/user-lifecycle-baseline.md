# User lifecycle baseline

[Retour à l'index](index.md)

## Objectif

Créer les comptes génériques d’automatisation associés aux groupes RBAC et à leurs scopes.

## Playbook

```bash
ansible-playbook --ask-vault-pass -i inventory/hosts.ini playbooks/52-user-lifecycle-baseline.yml
```

## Comptes

| Compte | Groupe RBAC | Scope |
|---|---|---|
| `LINUXADMAUTOMUSER` | `linux-admins` | `linux-all` |
| `DEVOPSADMAUTOMUSER` | `devops-admins` | `app-servers` |
| `SECAUDITAUTOMUSER` | `security-auditors` | `linux-all` |
| `DBADMAUTOMUSER` | `db-admins` | `db-servers` |
| `IDMADMAUTOMUSER` | `idm-admins` | `idm-servers` |
| `BREAKGLASSAUTOMUSER` | `breakglass-admins` | `linux-all` |

[Retour à l'index](index.md)
