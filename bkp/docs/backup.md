# Backup et restauration FreeIPA

[Retour à l'index](index.md)

## Objectif

Le rôle `ipa_backup` configure une sauvegarde automatisée du serveur FreeIPA primaire.

La stratégie couvre :

- sauvegarde `ipa-backup` ;
- exécution planifiée via `systemd timer` ;
- rétention locale ;
- journalisation dédiée ;
- point d'extension pour copie externe ;
- validation du timer après déploiement.

## Serveur cible

Le backup doit être exécuté prioritairement sur le serveur FreeIPA principal / CA renewal master.

Dans ce lab :

```text
idmprimarya.iriven.lab
```

## Playbook

```bash
ansible-playbook -i inventory/hosts.ini playbooks/70-configure-backup.yml
```

## Fichiers installés

```text
/usr/local/sbin/ipa-backup-iriven.sh
/etc/systemd/system/ipa-backup-iriven.service
/etc/systemd/system/ipa-backup-iriven.timer
/var/backups/ipa
/var/log/ipa-backup
```

## Variables principales

```yaml
ipa_backup_dir: /var/backups/ipa
ipa_backup_log_dir: /var/log/ipa-backup
ipa_backup_retention_days: 14
ipa_backup_timer_on_calendar: "*-*-* 02:30:00"
ipa_backup_include_data: true
ipa_backup_offsite_enabled: false
ipa_backup_offsite_command: ""
```

## Vérifier le timer

```bash
systemctl status ipa-backup-iriven.timer
systemctl list-timers ipa-backup-iriven.timer --no-pager
```

## Lancer un backup manuel

```bash
sudo systemctl start ipa-backup-iriven.service
sudo journalctl -u ipa-backup-iriven.service --no-pager -n 100
sudo ls -lah /var/backups/ipa
```

## Vérifier les logs

```bash
sudo tail -n 100 /var/log/ipa-backup/ipa-backup-$(date +%F).log
```

## Copie externe

La variable `ipa_backup_offsite_command` permet d'ajouter une copie hors serveur.

Exemple conceptuel :

```yaml
ipa_backup_offsite_enabled: true
ipa_backup_offsite_command: "rsync -a --delete /var/backups/ipa/ backup-host:/srv/backups/freeipa/"
```

Ne pas stocker de secret en clair dans cette variable. Utiliser SSH keys dédiées ou Ansible Vault.

## Restauration

La restauration FreeIPA est une opération destructive et doit être testée dans un environnement isolé.

Étapes générales :

1. provisionner un serveur compatible ;
2. installer les paquets FreeIPA nécessaires ;
3. copier le backup ;
4. exécuter `ipa-restore` ;
5. valider les services ;
6. valider DNS, Kerberos, LDAP, HBAC, sudo ;
7. valider les clients.

Commandes de base :

```bash
sudo ipa-restore /var/backups/ipa/<backup-directory>
sudo ipactl status
sudo ipa-healthcheck --output-type human
```

## Points de contrôle après restauration

```bash
ipactl status
ipa config-show
ipa user-find admin
ipa host-find
ipa dnsrecord-find iriven.lab --name=_ldap._tcp
kinit admin
ipa ping
```

## Bonnes pratiques

- tester la restauration régulièrement ;
- ne jamais considérer un backup valide sans restore test ;
- copier les sauvegardes hors du serveur IPA ;
- protéger les backups comme des secrets ;
- restreindre les permissions ;
- superviser l'échec du timer ;
- documenter le RTO/RPO cible.

[Retour à l'index](index.md)
