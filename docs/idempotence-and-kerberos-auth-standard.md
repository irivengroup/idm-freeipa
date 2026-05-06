# Idempotence and Kerberos authentication standard

[Retour à l'index](index.md)

## `/etc/hosts`

Les entrées sont gérées avec `lineinfile` et un `regexp` basé sur le FQDN cible afin de créer, corriger ou mettre à jour une seule ligne sans doublon.

## `kinit`

Les rôles doivent tenter, dans l’ordre :

1. ticket Kerberos déjà présent ;
2. keytab locale si disponible ;
3. mot de passe `idm_admin_password` depuis Vault si nécessaire.

[Retour à l'index](index.md)
