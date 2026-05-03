# Log rotation

[Retour à l'index](index.md)

## Objectif

Le rôle `log_rotation` évite la saturation disque liée aux logs locaux et centralisés.

Il complète :

- `audit_baseline`
- `ipa_monitoring_baseline`
- `pki_baseline`
- `ipa_backup`
- `log_collector`

## Playbook

```bash
ansible-playbook -i inventory/hosts.ini playbooks/87-configure-log-rotation.yml
```

## Fichier géré

```text
/etc/logrotate.d/idm-lab
```

## Journaux couverts

```text
/var/log/remote/*/*.log
/var/log/sudo.log
/var/log/idm-monitoring/*.log
/var/log/idm-pki-baseline/*.log
/var/log/ipa-backup/*.log
```

## Politique par défaut

- rotation quotidienne
- compression
- `delaycompress`
- ignore les fichiers absents
- ignore les fichiers vides
- permissions explicites à la création

## Rétention

```yaml
log_rotation_remote_logs_retention: 30
log_rotation_local_logs_retention: 14
log_rotation_backup_logs_retention: 30
```

## Validation

```bash
logrotate -d /etc/logrotate.d/idm-lab
logrotate -f /etc/logrotate.d/idm-lab
ls -lah /var/log/remote/
ls -lah /var/log/idm-monitoring/
ls -lah /var/log/idm-pki-baseline/
ls -lah /var/log/ipa-backup/
```

## Bonnes pratiques

- superviser l’espace disque du collecteur ;
- adapter la rétention selon la volumétrie réelle ;
- externaliser les logs critiques vers SIEM ;
- sauvegarder les journaux d’audit selon les exigences de conformité.

[Retour à l'index](index.md)

## Activation automatique

Le rôle active `logrotate.timer` lorsque l'unité systemd est disponible.

Validation :

```bash
systemctl status logrotate.timer
systemctl list-timers logrotate.timer --no-pager
```

[Retour à l'index](index.md)
