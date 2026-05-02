# Troubleshooting avancé

[Retour à l'index](index.md)

## HAProxy ne démarre pas
```bash
systemctl status haproxy --no-pager -l
journalctl -xeu haproxy
haproxy -c -f /etc/haproxy/haproxy.cfg
```
Cas fréquents : pidfile dupliqué, admin.sock absent, backend invalide, port occupé, blocage SELinux.

## Enrollment Client IPA échoue
Vérifier :
- /etc/hosts
- nmcli DNS
- résolution primary/replica
- keytab
- host déjà présent

si host déjà présent dans IPA:
```bash
klist -k
sssctl domain-status iriven.lab
ipa host-show <fqdn>
ipa-client-install --uninstall
```

## Chrony non synchronisé
Symptômes :
- timedatectl => synchronized: no
- chronyc sources => ^? ou ^x

> Vérifier ntp/firewalld, UDP 123, chronyd, source upstream.

## allow_all désactivé trop tôt
```bash
kinit admin
ipa hbacrule-enable allow_all
```

## Sudo rule non appliquée
```bash
sss_cache -E
sudo -l
ipa sudorule-show <rule>
```

## allow_all désactivé trop tôt
```bash
kinit admin
ipa hbacrule-enable allow_all
```

## Gestion des appartenances multiples (Users et Hosts)

### Un utilisateur appartient à plusieurs groupes
Cas fréquent :

user: opsuser
member of:
- linux-admins
- devops-admins
- security-auditors

> Comportement attendu :

* cumul des autorisations HBAC compatibles
* cumul des sudo rules applicables
* principe du moindre privilège à contrôler
* éviter les conflits fonctionnels

> Vérification :
```bash
id opsuser
ipa user-show opsuser
ipa group-show linux-admins
ipa group-show devops-admins
sudo -l -U opsuser
```

Bonne pratique :

- ne jamais utiliser plusieurs groupes “admin total”
- séparer accès opérationnel et accès breakglass
- tracer les exceptions

### Un host appartient à plusieurs hostgroups

Cas fréquent :

host: idmadmin.iriven.lab
member of:
- linux-all
- jump-hosts

> Comportement attendu :

* plusieurs règles HBAC peuvent s’appliquer
* plusieurs sudo scopes peuvent être cumulés
* attention aux règles trop permissives

> Vérification :
```bash
ipa host-show idmadmin.iriven.lab
ipa hostgroup-show linux-all
ipa hostgroup-show jump-hosts
ipa hbactest --user=testadmin --host=idmadmin.iriven.lab --service=sshd
```

Bonne pratique :

- linux-all = socle global
- hostgroups spécialisés = règles métier ciblées
- éviter hostcat=all sauf cas strictement justifié
- Sudo rule IPA non appliquée

### Sudo rule IPA non appliquée
```bash
sss_cache -E
id <user>
sudo -l
ipa sudorule-show <rule>
```

[Retour à l'index](index.md)
