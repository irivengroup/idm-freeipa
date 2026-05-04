# Disaster Recovery readiness check

[Retour à l'index](index.md)

## Objectif

Le rôle `dr_readiness_check` valide que la plateforme FreeIPA dispose des prérequis minimaux pour une reprise d’activité.

Il ne lance pas de restauration. Il vérifie la capacité de reprise.

## Playbook

```bash
ansible-playbook --ask-vault-pass -i inventory/hosts.ini playbooks/95-dr-readiness-check.yml
```

## Périmètre

Cible :

```text
idm_primary
```

Le primary est utilisé comme point de contrôle principal pour :

- les backups ;
- les manifestes ;
- la topologie de réplication ;
- les secrets critiques ;
- les certificats suivis par certmonger ;
- les enregistrements DNS SRV critiques.

## Checks réalisés

### Commandes critiques

```text
ipa
ipa-backup
ipa-restore
ipactl
getcert
kinit
```

### Fichiers critiques

```text
/etc/ipa/default.conf
/etc/krb5.conf
/etc/hosts
/etc/resolv.conf
```

### Backups

Le rôle vérifie :

- présence du répertoire backup ;
- présence d’au moins un backup `ipa-full-*` ;
- présence d’au moins un manifeste.

### Secrets

Variables attendues :

```yaml
idm_admin_password
idm_dm_password
```

### DNS

Enregistrements contrôlés :

```text
_ldap._tcp
_kerberos._tcp
```

### Réplication

Commande utilisée :

```bash
ipa topologysegment-find domain
```

### PKI

Commande utilisée :

```bash
getcert list
```

## Rapport

Un rapport est généré dans :

```text
/var/log/idm-dr-readiness/<hostname>-dr-readiness.report
```

## Critères d'acceptation

- `ipactl status` retourne `0` ;
- au moins un backup existe ;
- au moins un manifeste existe ;
- les commandes critiques sont disponibles ;
- les fichiers critiques existent ;
- les secrets requis sont disponibles via Vault ;
- la topologie de réplication est consultable ;
- `getcert list` est exploitable.

## Ce que ce check ne fait pas

- il ne restaure pas le serveur ;
- il ne modifie pas la topologie ;
- il ne redémarre pas les services ;
- il ne supprime aucun backup.

## Procédure recommandée

1. Exécuter le backup.
2. Exécuter le DR readiness check.
3. Copier le backup vers une cible isolée.
4. Tester `ipa-restore` dans un environnement de validation.
5. Documenter le résultat.

[Retour à l'index](index.md)
