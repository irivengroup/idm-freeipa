# SSH hardening

[Retour à l'index](index.md)

## Objectif

Sécuriser l’accès SSH sans écraser le fichier principal `/etc/ssh/sshd_config`.

Le rôle `ssh_hardening` utilise un fichier drop-in dédié :

```text
/etc/ssh/sshd_config.d/99-idm-hardening.conf
```

## Contrôles appliqués

```text
PermitRootLogin no
PasswordAuthentication yes
PubkeyAuthentication yes
GSSAPIAuthentication yes
KerberosAuthentication yes
UsePAM yes

MaxAuthTries 3
LoginGraceTime 30
ClientAliveInterval 300
ClientAliveCountMax 2

X11Forwarding no
AllowTcpForwarding no
PermitEmptyPasswords no

AllowGroups linux-admins devops-admins security-auditors idm-admins breakglass-admins
```

## Pourquoi un drop-in

Cette approche évite :

- l’écrasement du fichier principal ;
- les conflits avec les paquets OpenSSH ;
- les pertes de configuration locales ;
- les diffs difficiles à auditer.

## Groupes autorisés

- `linux-admins`
- `devops-admins`
- `security-auditors`
- `idm-admins`
- `breakglass-admins`

## Validation

```bash
sshd -t
systemctl status sshd
cat /etc/ssh/sshd_config.d/99-idm-hardening.conf
ssh testadmin@idmadmin.iriven.lab
sudo -l
```

## Évolution cible

Phase suivante :

```text
PasswordAuthentication no
```

avec clés SSH, GSSAPI ou certificats SSH.

[Retour à l'index](index.md)
