# Audit baseline

[Retour à l'index](index.md)

## Objectif

Le rôle `audit_baseline` prépare le lab IRIVEN à une exploitation audit-ready.

Il couvre :

- logs journald persistants ;
- traces sudo renforcées ;
- journalisation SSH/SSSD/IPA exploitable ;
- base rsyslog locale ;
- option de forwarding vers un collecteur externe ;
- règles auditd sur les fichiers sensibles.

## Playbook

```bash
ansible-playbook -i inventory/hosts.ini playbooks/85-configure-audit-baseline.yml
```

## Journald persistant

Fichier géré :

```text
/etc/systemd/journald.conf.d/99-idm-audit.conf
```

Paramètres principaux :

```text
Storage=persistent
ForwardToSyslog=yes
SystemMaxUse=1G
MaxRetentionSec=1month
```

Validation :

```bash
journalctl --disk-usage
ls -ld /var/log/journal
```

## Sudo audit

Fichier géré :

```text
/etc/sudoers.d/99-idm-audit
```

Fonctionnalités :

- log sudo dédié ;
- logs I/O ;
- `use_pty` ;
- horodatage complet.

Validation :

```bash
sudo -l
sudo whoami
sudo tail -n 50 /var/log/sudo.log
sudo ls -lah /var/log/sudo-io
```

## Rsyslog

Fichier géré :

```text
/etc/rsyslog.d/99-idm-audit.conf
```

Forwarding distant désactivé par défaut.

Exemple d'activation :

```yaml
audit_baseline_rsyslog_forwarding_enabled: true
audit_baseline_rsyslog_remote_host: logs.iriven.lab
audit_baseline_rsyslog_remote_port: 514
audit_baseline_rsyslog_remote_protocol: tcp
```

## Auditd

Fichier géré :

```text
/etc/audit/rules.d/99-idm-audit.rules
```

Surveille notamment :

- `/etc/sudoers`
- `/etc/sudoers.d/`
- `/etc/ssh/sshd_config`
- `/etc/ssh/sshd_config.d/`
- `/etc/sssd/sssd.conf`
- `/etc/krb5.conf`
- `/etc/ipa/default.conf`
- `/etc/hosts`
- `/etc/resolv.conf`

Validation :

```bash
auditctl -l
ausearch -k sudoers
ausearch -k sshd_config
ausearch -k sssd_config
```

## Use cases

### Audit d'un usage sudo

```bash
grep sudo /var/log/secure
tail -n 100 /var/log/sudo.log
```

### Audit d'une connexion SSH

```bash
journalctl -u sshd --since today
grep sshd /var/log/secure
```

### Audit d'un refus HBAC ou SSSD

```bash
journalctl -u sssd --since today
grep -i denied /var/log/secure
```

### Audit d'une modification de configuration sensible

```bash
ausearch -k sshd_config
ausearch -k sudoers
ausearch -k kerberos_config
```

## Limites

Cette baseline n'est pas un SIEM.

Étapes suivantes recommandées :

- forwarding vers un serveur rsyslog central ;
- Graylog / ELK / Splunk / Sentinel ;
- règles d'alerte ;
- corrélation SSH + sudo + SSSD + IPA ;
- conservation longue durée.

[Retour à l'index](index.md)
