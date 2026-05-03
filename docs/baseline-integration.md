# Baseline integration

[Retour à l'index](index.md)

## Objectif

Les rôles transverses doivent être intégrés automatiquement dans les playbooks métier selon le niveau de responsabilité des hôtes.

Les baselines actuellement intégrées sont :

- `ssh_hardening`
- `audit_baseline`
- `log_rotation`
- `ipa_monitoring_baseline`
- `pki_baseline` pour les serveurs IDM

## Mapping par responsabilité

### Serveurs IDM

Groupes :

```text
idm_primary
idm_replica
idm_servers
```

Playbooks :

```text
playbooks/10-install-primary.yml
playbooks/20-install-replica.yml
```

Rôles transverses appliqués :

```text
pki_baseline
ssh_hardening
audit_baseline
log_rotation
ipa_monitoring_baseline
```

### Load balancers

Groupe :

```text
idm_loadbalancers
```

Playbook :

```text
playbooks/40-configure-loadbalancers.yml
```

Rôles transverses appliqués :

```text
ssh_hardening
audit_baseline
log_rotation
ipa_monitoring_baseline
```

### Clients et host d'administration

Groupes :

```text
idm_clients
idm_admin
```

Playbook :

```text
playbooks/30-enroll-clients.yml
```

Rôles transverses appliqués :

```text
ssh_hardening
audit_baseline
log_rotation
ipa_monitoring_baseline
```

## Log rotation automatique

Le rôle `log_rotation` déploie :

```text
/etc/logrotate.d/idm-lab
```

et active automatiquement `logrotate.timer` lorsque l'unité existe.

Validation :

```bash
systemctl status logrotate.timer
systemctl list-timers logrotate.timer --no-pager
logrotate -d /etc/logrotate.d/idm-lab
```

## Règle pour les futurs rôles

Tout futur rôle transverse doit respecter cette règle :

1. être intégré dans les playbooks métier correspondant à son scope ;
2. disposer éventuellement d'un playbook autonome de réapplication ciblée ;
3. être documenté dans `docs/` ;
4. ne pas dépendre d'une exécution manuelle pour être actif dans le flux principal `site.yml`.

[Retour à l'index](index.md)
