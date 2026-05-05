# Backup FreeIPA

[Retour à l'index](index.md)

Le rôle `ipa_backup` configure une sauvegarde FreeIPA automatisée avec manifeste, rétention et export externe optionnel.

## Playbook

```bash
ansible-playbook -i inventory/hosts.ini playbooks/70-configure-backup.yml
```

## Fichiers

```text
/usr/local/sbin/ipa-backup-iriven.sh
/etc/systemd/system/ipa-backup-iriven.service
/etc/systemd/system/ipa-backup-iriven.timer
/var/backups/ipa
/var/backups/ipa/manifests
/var/log/ipa-backup
```

## Export externe

```yaml
ipa_backup_offsite_enabled: true
ipa_backup_offsite_target: "idmadmin.iriven.lab:/srv/backups/freeipa"
```

## Validation

```bash
systemctl start ipa-backup-iriven.service
journalctl -u ipa-backup-iriven.service --no-pager -n 100
ls -lah /var/backups/ipa /var/backups/ipa/manifests
ansible-playbook -i inventory/hosts.ini playbooks/71-backup-restore-readiness-check.yml
```

Voir aussi : [Restore runbook](restore-runbook.md)

[Retour à l'index](index.md)
