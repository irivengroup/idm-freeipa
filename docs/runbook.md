# Runbook opérationnel détaillé

[Retour à l'index](index.md)

## Pré-déploiement
- validation inventory Ansible
- FQDN / hostname cohérents
- DNS direct + reverse
- accès SSH + sudo
- NTP synchronisé
- SELinux enforcing
- firewalld actif

## Cas multi-appartenance
### User dans plusieurs groupes
Exemple : linux-admins + devops-admins + security-auditors

Vérifier :
```bash
id opsuser
ipa user-show opsuser
sudo -l -U opsuser
```

Règle : éviter plusieurs groupes d'admin total.

### Host dans plusieurs hostgroups
Exemple : linux-all + jump-hosts

Vérifier :
```bash
ipa host-show idmadmin.iriven.lab
ipa hbactest --user=testadmin --host=idmadmin.iriven.lab --service=sshd
```

## Validation post-installation
- ipactl status
- replication
- DNS SRV
- enrollment client
- sudo + HBAC
- breakglass
- ipa-healthcheck

[Retour à l'index](index.md)
