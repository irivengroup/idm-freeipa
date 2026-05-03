# GitHub Actions

[Retour à l'index](index.md)

## Objectif

Le projet inclut des workflows GitHub Actions pour valider automatiquement la qualité du dépôt sans contacter l'infrastructure du lab.

Les workflows effectuent uniquement des contrôles statiques :

- validation YAML ;
- lint Ansible ;
- vérification de syntaxe des playbooks ;
- validation de l'inventaire ;
- contrôle de structure projet ;
- contrôle documentaire ;
- garde-fous basiques contre les secrets en clair.

## Workflows inclus

### `.github/workflows/ci.yml`

Contrôle principal du projet Ansible :

- installation de `ansible`, `ansible-lint`, `yamllint` ;
- validation de la structure ;
- lint YAML ;
- lint Ansible ;
- validation de l'inventaire ;
- `ansible-playbook --syntax-check` sur tous les playbooks.

### `.github/workflows/docs.yml`

Contrôle documentaire :

- présence des fichiers critiques ;
- présence des liens retour vers `docs/index.md` ;
- présence du lien documentation dans `README.md`.

### `.github/workflows/security.yml`

Contrôles de sécurité simples :

- refuse la présence de `inventory/group_vars/all/vault.yml` ;
- signale les secrets potentiels en clair ;
- autorise `vault.yml.example`.

## Exécution locale équivalente

```bash
yamllint .
ansible-lint
ansible-inventory -i inventory/hosts.ini --list
for playbook in playbooks/*.yml; do
  ansible-playbook -i inventory/hosts.ini --syntax-check "$playbook"
done
```

[Retour à l'index](index.md)
