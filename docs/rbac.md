[← Retour à l’index](index.md)

# RBAC IRIVEN

**Breadcrumbs :** [Index](index.md) › RBAC

## Objectif

La matrice RBAC IRIVEN vise à supprimer l’administration implicite et à rendre les accès contrôlables, auditables et maintenables.

Le compte `admin` FreeIPA doit devenir un compte d’urgence ou de bootstrap, et non un compte d’exploitation quotidienne.

---

## Groupes utilisateurs

| Groupe | Usage | Niveau d’accès |
|---|---|---|
| linux-admins | Administration Linux senior | SSH + sudo root complet |
| devops-admins | Administration applicative | SSH app + sudo limité |
| security-auditors | Audit sécurité | Lecture seule |
| db-admins | Administration bases de données | DB servers uniquement |
| idm-admins | Administration FreeIPA | IdM, DNS, PKI, policies |
| breakglass-admins | Urgence | Root global exceptionnel |

---

## Hostgroups IPA

| Hostgroup | Source Ansible | Description |
|---|---|---|
| linux-all | idm_servers + idm_clients + idm_loadbalancers + idm_admin + futurs groupes | Tous les systèmes Linux |
| idm-servers | idm_servers | Serveurs FreeIPA |
| app-servers | app_servers | Serveurs applicatifs |
| db-servers | db_servers | Serveurs base de données |
| jump-hosts | jump_hosts ou idm_admin | Bastions / postes d’administration |

Les membres sont construits depuis `inventory/hosts.ini`. Le fichier `rbac.yml` définit uniquement les politiques et descriptions, pas les membres.

---

## Sudo rules

| Règle | Groupe | Scope |
|---|---|---|
| sudo-linux-admins | linux-admins | root complet sur linux-all |
| sudo-idm-admins | idm-admins | root complet sur idm-servers |
| sudo-breakglass-admins | breakglass-admins | root complet global, sans mot de passe en lab |
| sudo-security-auditors | security-auditors | commandes de lecture |
| sudo-devops-admins | devops-admins | commandes d’exploitation applicative |
| sudo-db-admins | db-admins | commandes d’exploitation DB |

---

## HBAC rules

| Règle | Groupe | Scope SSH |
|---|---|---|
| allow-linux-admins | linux-admins | linux-all |
| allow-idm-admins | idm-admins | idm-servers |
| allow-devops-admins | devops-admins | app-servers |
| allow-db-admins | db-admins | db-servers |
| allow-security-auditors | security-auditors | linux-all |
| allow-breakglass-admins | breakglass-admins | linux-all |

---

## Exécution

```bash
ansible-playbook -i inventory/hosts.ini playbooks/50-configure-rbac.yml
```

---

## Désactivation de allow_all

Par défaut, le rôle ne désactive pas `allow_all`.

Avant de le faire :

```bash
ipa hbactest --user=testadmin --host=idmadmin.iriven.lab --service=sshd
```

Puis activer :

```yaml
idm_rbac_disable_allow_all: true
```

---

[← Retour à l’index](index.md)
