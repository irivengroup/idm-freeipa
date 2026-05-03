# Common hosts baseline

[Retour à l'index](index.md)

## Objectif

Le rôle `common_hosts` applique le socle système commun à tous les hôtes Linux du lab IRIVEN.

## Fonctionnalités

- hostname système au format FQDN ;
- bloc `/etc/hosts` centralisé pour les serveurs IPA et la VIP load balancer ;
- installation des paquets de base ;
- activation de `firewalld` ;
- passage SELinux en mode permissive runtime et persistant.

## Validation

```bash
hostname -f
cat /etc/hosts
rpm -q vim curl wget bind-utils chrony firewalld python3 sudo
systemctl status firewalld --no-pager
getenforce
grep '^SELINUX=' /etc/selinux/config
```

[Retour à l'index](index.md)
