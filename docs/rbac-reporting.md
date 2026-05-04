# RBAC reporting

[Retour à l'index](index.md)

## Objectif

Exporter l’état RBAC effectif de FreeIPA pour rendre les accès contrôlables, auditables et maintenables.

## Playbook

```bash
ansible-playbook -i inventory/hosts.ini playbooks/55-rbac-reporting.yml
```

## Rapports

```text
/var/log/idm-rbac-reporting/rbac-effective-report.md
/var/log/idm-rbac-reporting/rbac-effective-report.json
```

## Données exportées

- groupes utilisateurs ;
- hostgroups ;
- sudo rules ;
- HBAC rules ;
- rôles IPA ;
- groupes attendus manquants ;
- hostgroups attendus manquants.

[Retour à l'index](index.md)
