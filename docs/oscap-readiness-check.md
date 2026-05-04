# OpenSCAP readiness check

[Retour à l'index](index.md)

## Objectif

Préparer la plateforme IRIVEN IDM à un audit sécurité standardisé basé sur OpenSCAP.

## Playbook

```bash
ansible-playbook -i inventory/hosts.ini playbooks/97-oscap-readiness-check.yml
```

## Mode par défaut

Le rôle installe les outils, détecte les datastreams SCAP, inventorie les profils et produit un rapport de readiness.

Il ne lance pas de scan complet par défaut.

## Scan optionnel

```bash
ansible-playbook -i inventory/hosts.ini playbooks/97-oscap-readiness-check.yml \
  -e oscap_readiness_run_scan=true
```

## Rapports

```text
/var/log/idm-oscap/
```

[Retour à l'index](index.md)
