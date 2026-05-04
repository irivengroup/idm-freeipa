# Compliance check

[Retour à l'index](index.md)

## Objectif

Le rôle `compliance_check` produit un état de conformité non destructif de la plateforme IRIVEN IDM.

Il agrège les baselines déjà mises en place :

- SSH hardening ;
- audit baseline ;
- journald ;
- rsyslog ;
- log rotation ;
- firewalld ;
- Chrony ;
- PKI baseline ;
- backup baseline ;
- HAProxy ;
- FreeIPA service state.

## Playbook

```bash
ansible-playbook -i inventory/hosts.ini playbooks/96-compliance-check.yml
```

## Mode strict

Par défaut, le rôle génère un rapport sans faire échouer le playbook.

Pour rendre la non-conformité bloquante :

```bash
ansible-playbook -i inventory/hosts.ini playbooks/96-compliance-check.yml \
  -e compliance_check_fail_on_non_compliance=true
```

## Rapports

Les rapports sont créés dans :

```text
/var/log/idm-compliance/
```

Exemple :

```bash
cat /var/log/idm-compliance/idmprimarya-compliance.report
```

## Checks principaux

### Tous les hôtes

- `firewalld` actif ;
- `chronyd` actif ;
- `rsyslog` actif ;
- `logrotate.timer` activé ;
- drop-in SSH présent ;
- configuration `sshd -t` valide ;
- audit sudoers présent ;
- journald audit présent ;
- politique logrotate présente.

### Serveurs IDM

- `ipactl status` ;
- timer PKI baseline.

### Primary

- timer backup.

### Load balancers

- HAProxy actif.

## Critères d'acceptation

Un hôte est considéré conforme si :

- les fichiers de baseline sont présents ;
- les services critiques sont actifs ;
- les configurations SSH/logrotate sont valides ;
- les timers critiques sont activés selon le rôle de l’hôte ;
- aucun élément n’est listé dans `non_compliant_items`.

## Limites

Ce check ne remplace pas :

- un audit CIS complet ;
- OpenSCAP ;
- une politique SIEM ;
- des tests de restauration ;
- une revue IAM manuelle.

[Retour à l'index](index.md)
