# Secrets management

[Retour à l'index](index.md)

## Objectif

Le projet ne doit jamais stocker de secrets en clair dans Git.

Les secrets doivent être placés dans :

```text
inventory/group_vars/all/vault.yml
```

et chiffrés avec Ansible Vault.

## Modèle fourni

```text
inventory/group_vars/all/vault.yml.example
```

Créer le fichier réel :

```bash
cp inventory/group_vars/all/vault.yml.example inventory/group_vars/all/vault.yml
ansible-vault encrypt inventory/group_vars/all/vault.yml
```

Éditer ensuite :

```bash
ansible-vault edit inventory/group_vars/all/vault.yml
```

## Variables sensibles principales

```yaml
idm_admin_principal: admin
idm_admin_password: "..."
idm_dm_password: "..."
ipa_client_admin_password: "{{ idm_admin_password }}"
idm_breakglass_initial_password: "..."
```

## Validation

```bash
ansible-playbook --ask-vault-pass -i inventory/hosts.ini playbooks/88-validate-secrets.yml
```

## Règles

- ne jamais committer `vault.yml` ;
- committer uniquement `vault.yml.example` ;
- utiliser `ansible-vault edit` ;
- ne pas passer les mots de passe dans l'historique shell ;
- éviter les secrets dans les variables de rôle ;
- faire tourner les secrets après incident ou partage non autorisé.

## CI

La CI doit échouer si :

- `inventory/group_vars/all/vault.yml` est présent ;
- un secret évident est détecté en clair ;
- le modèle `vault.yml.example` est absent.

## Bonnes pratiques

- stocker le mot de passe Vault dans un coffre externe ;
- séparer secrets lab / production ;
- limiter l'accès au Vault ;
- journaliser les changements sensibles ;
- prévoir une procédure de rotation.

[Retour à l'index](index.md)
