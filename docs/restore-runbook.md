# Restore runbook

[Retour à l'index](index.md)

## Objectif

Valider que les sauvegardes FreeIPA sont réellement exploitables.

## Readiness

```bash
ansible-playbook -i inventory/hosts.ini playbooks/71-test-backup-restore-readiness.yml
```

## Sauvegarde manuelle

```bash
sudo systemctl start ipa-backup-iriven.service
sudo journalctl -u ipa-backup-iriven.service --no-pager -n 100
sudo ls -lah /var/backups/ipa
sudo ls -lah /var/backups/ipa/manifests
```

## Restauration conceptuelle

À réaliser en environnement isolé ou fenêtre de maintenance :

```bash
sudo ipa-restore /var/backups/ipa/<backup-directory>
sudo ipactl status
sudo ipa-healthcheck --output-type human
```

## Contrôles post-restore

```bash
ipactl status
kinit admin
ipa ping
ipa host-find
ipa user-find
ipa dnsrecord-find iriven.lab --name=_ldap._tcp
getcert list
```

[Retour à l'index](index.md)
