# Release readiness check

[Retour à l'index](index.md)

## Objectif

Valider que le dépôt IRIVEN IDM est prêt pour livraison, versionnement ou publication.

## Playbook

```bash
ansible-playbook -i inventory/hosts.ini playbooks/98-release-readiness-check.yml
```

## Contrôles

- structure projet ;
- README et docs ;
- inventaire ;
- `vault.yml.example` présent ;
- `vault.yml` absent ;
- playbooks critiques ;
- rôles critiques ;
- workflows GitHub Actions ;
- inventaire Ansible lisible.

## Rapport

```text
/var/log/idm-release-readiness/release-readiness.report
```

[Retour à l'index](index.md)
