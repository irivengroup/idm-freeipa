# Baseline integration

[Retour à l'index](index.md)

## Objectif

Les rôles transverses ne doivent pas dépendre d'une exécution manuelle séparée.

Les baselines suivantes sont intégrées automatiquement dans les playbooks métier selon le niveau de responsabilité des hôtes :

- `ssh_hardening`
- `audit_baseline`
- `ipa_monitoring_baseline`
- `pki_baseline`

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

Rôles appliqués automatiquement :

```text
common_hosts
chrony_server
ipa_primary / ipa_replica
pki_baseline
ssh_hardening
audit_baseline
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

Rôles appliqués automatiquement :

```text
common_hosts
chrony_client
haproxy_freeipa_lb
ssh_hardening
audit_baseline
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

Rôles appliqués automatiquement :

```text
common_hosts
chrony_client
ipa_client
ssh_hardening
audit_baseline
ipa_monitoring_baseline
```

## Playbooks autonomes conservés

Les playbooks suivants restent disponibles pour réappliquer uniquement une baseline :

```bash
ansible-playbook -i inventory/hosts.ini playbooks/80-configure-monitoring-baseline.yml
ansible-playbook -i inventory/hosts.ini playbooks/85-configure-audit-baseline.yml
```

Ils ne sont plus requis dans le flux principal `site.yml`.

## Flux principal

```bash
ansible-playbook -i inventory/hosts.ini playbooks/site.yml
```

Le flux principal applique désormais automatiquement :

1. socle commun ;
2. Chrony ;
3. installation IDM ;
4. load balancers ;
5. enrollment clients/admin ;
6. RBAC ;
7. backup ;
8. healthcheck ;
9. validation.

## Règle pour les futurs rôles transverses

Tout futur rôle transverse doit être intégré dans les playbooks métier correspondant au périmètre de responsabilité :

- IDM servers ;
- admin hosts ;
- load balancers ;
- clients.

Il peut également avoir un playbook autonome de réapplication ciblée.

[Retour à l'index](index.md)
