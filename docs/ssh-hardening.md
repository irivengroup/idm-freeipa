# SSH hardening

[Retour à l'index](index.md)

## Objectif

Le rôle `ssh_hardening` durcit SSH via `/etc/ssh/sshd_config.d/99-idm-hardening.conf` et prépare l’accès sans mot de passe depuis les hôtes d’administration.

## Distribution des clés SSH admin/bastion

Sources :

- `idm_admin`
- `jump_hosts`

Cibles :

- tous les hôtes enrôlés sauf `idm_admin` et `jump_hosts`

Le rôle :

1. génère une clé SSH `ed25519` si absente sur les hôtes sources ;
2. collecte les clés publiques ;
3. les déploie dans `authorized_keys` de `ansible_user` sur les cibles ;
4. préserve RBAC, HBAC, sudo IPA et audit.

## Validation

```bash
ssh idmprimarya.iriven.lab
ssh idmreplicab.iriven.lab
ssh idmloadbalancer1.iriven.lab
```

[Retour à l'index](index.md)
