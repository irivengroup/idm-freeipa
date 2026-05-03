# Troubleshooting avancé

[Retour à l'index](index.md)

## HAProxy ne démarre pas
```bash
systemctl status haproxy --no-pager -l
journalctl -xeu haproxy
haproxy -c -f /etc/haproxy/haproxy.cfg
```

## Enrollment client échoue
Vérifier :
- /etc/hosts
- nmcli DNS
- keytab
- host déjà présent

## Chrony non synchronisé
Symptômes :
- timedatectl => synchronized: no
- chronyc sources => ^? ou ^x

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

[Retour à l'index](index.md)
