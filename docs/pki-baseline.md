# PKI baseline

[Retour à l'index](index.md)

## Objectif

Le rôle `pki_baseline` ajoute une couche de contrôle PKI/TLS pour les serveurs FreeIPA / Red Hat IdM.

Il ne remplace pas `certmonger` ni les mécanismes natifs FreeIPA. Il fournit une supervision opérationnelle supplémentaire.

## Périmètre

Cible :

```text
idm_servers
```

Serveurs concernés :

- `idmprimarya.iriven.lab`
- `idmreplicab.iriven.lab`

## Playbook autonome

```bash
ansible-playbook -i inventory/hosts.ini playbooks/75-configure-pki-baseline.yml
```

Le rôle est aussi intégré automatiquement dans les playbooks :

```text
playbooks/10-install-primary.yml
playbooks/20-install-replica.yml
```

## Contrôles effectués

### Certmonger

```bash
systemctl status certmonger
getcert list
```

### CA IPA

Fichiers contrôlés :

```text
/etc/ipa/ca.crt
/var/lib/ipa-client/pki/kdc-ca-bundle.pem
/var/lib/ipa-client/pki/ca-bundle.pem
```

### HTTPD / Web UI IPA

Inventaire de la base NSS HTTPD :

```bash
certutil -L -d /etc/httpd/alias
```

### Directory Server

Recherche des certificats PEM/CRT sous :

```text
/etc/dirsrv
```

## Timer systemd

Fichiers installés :

```text
/usr/local/libexec/idm-pki-baseline/idm-pki-baseline-check.sh
/etc/systemd/system/idm-pki-baseline-check.service
/etc/systemd/system/idm-pki-baseline-check.timer
/var/log/idm-pki-baseline/
```

## Variables principales

```yaml
pki_baseline_warning_days: 30
pki_baseline_critical_days: 15
pki_baseline_timer_on_calendar: "*-*-* 03:15:00"
```

## Validation

```bash
systemctl status idm-pki-baseline-check.timer
systemctl start idm-pki-baseline-check.service
journalctl -u idm-pki-baseline-check.service --no-pager -n 100
tail -n 100 /var/log/idm-pki-baseline/idm-pki-baseline-$(date +%F).log
```

## Use cases

### Certificat proche expiration

Le script journalise un warning si un certificat est sous le seuil `pki_baseline_warning_days`.

### Certificat critique

Le script retourne un statut non nul si un certificat est sous le seuil `pki_baseline_critical_days`.

### Certmonger arrêté

Le script retourne une erreur si `certmonger` est présent mais inactif.

## Bonnes pratiques

- surveiller `getcert list` régulièrement ;
- traiter les erreurs `CA_UNREACHABLE`, `NEED_CSR`, `MONITORING` anormal ;
- conserver les logs PKI ;
- corréler avec les logs FreeIPA, HTTPD et Directory Server ;
- ne pas modifier manuellement les certificats IPA sans procédure de rollback.

[Retour à l'index](index.md)
