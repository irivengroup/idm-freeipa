# SSH hardening

[Retour à l'index](index.md)

## Objectif

Sécuriser l’accès SSH et faire de `idmadmin` le bastion principal.

## Contrôles appliqués

- `PermitRootLogin no`
- groupes autorisés via `AllowGroups`
- GSSAPI/Kerberos conservé
- SSH piloté par RBAC + SSSD + HBAC

## Groupes autorisés

- linux-admins
- devops-admins
- security-auditors
- idm-admins
- breakglass-admins

## Validation

```bash
sshd -t
systemctl status sshd
ssh testadmin@idmadmin.iriven.lab
sudo -l
```

## Évolution cible

Phase suivante :

```text
PasswordAuthentication no
```

avec clés SSH / GSSAPI / certificats SSH.

[Retour à l'index](index.md)
