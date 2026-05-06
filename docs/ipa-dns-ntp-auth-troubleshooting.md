# IPA DNS/NTP authentication troubleshooting

[Retour à l'index](index.md)

## Symptôme

```text
TASK [ipa_dns_ntp : Ensure Kerberos, LDAP, and NTP SRV records exist] failed
```

avec une sortie censurée par `no_log`.

## Correction appliquée

Le rôle `ipa_dns_ntp` sépare désormais l'authentification Kerberos des commandes DNS.

Ordre d'authentification :

1. ticket Kerberos déjà présent ;
2. keytab locale `/etc/krb5.keytab` ;
3. mot de passe `idm_admin_password` depuis Vault.

Les tâches DNS ne masquent plus leur sortie, afin de rendre les erreurs IPA exploitables.

## Exécution recommandée

```bash
kinit admin
ansible-playbook -i inventory/hosts.ini playbooks/25-configure-dns-ntp-records.yml
```

Ou avec Vault :

```bash
ansible-playbook --ask-vault-pass -i inventory/hosts.ini playbooks/25-configure-dns-ntp-records.yml
```

[Retour à l'index](index.md)
