# RBAC authentication troubleshooting

[Retour à l'index](index.md)

## Exécution recommandée

```bash
kinit admin
ansible-playbook -i inventory/hosts.ini playbooks/50-configure-rbac.yml
```

Ou avec Vault :

```bash
ansible-playbook --ask-vault-pass -i inventory/hosts.ini playbooks/50-configure-rbac.yml
```

Le rôle `ipa_rbac` essaie maintenant :

1. ticket Kerberos existant ;
2. keytab locale ;
3. mot de passe `idm_admin_password`.

[Retour à l'index](index.md)
