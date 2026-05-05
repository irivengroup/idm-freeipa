# HAProxy runtime directory fix

[Retour à l'index](index.md)

## Problème

HAProxy peut échouer au démarrage avec :

```text
cannot bind UNIX socket (No such file or directory) [/run/haproxy/admin.sock]
```

## Correction

Le rôle `haproxy_freeipa_lb` crée maintenant :

```text
/run/haproxy
/etc/tmpfiles.d/haproxy.conf
```

puis applique :

```bash
systemd-tmpfiles --create /etc/tmpfiles.d/haproxy.conf
```

## Validation

```bash
sudo haproxy -c -f /etc/haproxy/haproxy.cfg
sudo systemctl restart haproxy
sudo systemctl status haproxy --no-pager -l
sudo ss -lntp | grep haproxy
echo "show servers state" | sudo socat - /run/haproxy/admin.sock
```

[Retour à l'index](index.md)
