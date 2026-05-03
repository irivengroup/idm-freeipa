# CI / Linting

[Retour à l'index](index.md)

## Objectif

La CI valide automatiquement :

- la syntaxe YAML ;
- la structure du dépôt ;
- l'inventaire Ansible ;
- la syntaxe des playbooks ;
- une base de lint Ansible adaptée au lab FreeIPA.

## Règles adaptées

Certaines règles `ansible-lint` sont désactivées pour éviter les faux positifs liés aux commandes FreeIPA CLI.

Exemples :

- `ipa`
- `ipactl`
- `ipa-backup`
- `ipa-healthcheck`
- `ipa-replica-manage`

Les contrôles bloquants restent centrés sur :

- dépôt bien structuré ;
- YAML valide ;
- inventaire lisible ;
- playbooks syntaxiquement valides ;
- absence de fichier Vault en clair.

## Exécution locale

```bash
yamllint .
ansible-lint
ansible-inventory -i inventory/hosts.ini --list
for playbook in playbooks/*.yml; do
  ansible-playbook -i inventory/hosts.ini --syntax-check "$playbook"
done
```

[Retour à l'index](index.md)
