# Inventory and host groups

[Retour à l'index](index.md)

## Source de vérité

Le fichier `inventory/hosts.ini` est la source de vérité des hôtes.

## Groupes composites

- `idm_servers` = `idm_primary` + `idm_replica`
- `idm_clients` = `app_servers` + `db_servers` + `idm_admin` + `idm_loadbalancers` + `jump_hosts`
- `idm_all` = `idm_servers` + `idm_clients`

## Extension

Les groupes `app_servers`, `db_servers` et `jump_hosts` sont prêts à l’emploi. Ajouter ou décommenter des hôtes suffit pour les intégrer aux playbooks qui ciblent `idm_clients` ou `idm_all`.

## Mapping RBAC

| Groupe Ansible | Hostgroup IPA |
|---|---|
| `idm_all` | `linux-all` |
| `idm_servers` | `idm-servers` |
| `app_servers` | `app-servers` |
| `db_servers` | `db-servers` |
| `jump_hosts` + `idm_admin` | `jump-hosts` |

[Retour à l'index](index.md)
