# Common hosts repository DNS precheck

[Retour à l'index](index.md)

## Problème

L’installation des paquets de base peut échouer si le host ne résout pas encore :

```text
mirrors.rockylinux.org
```

Erreur typique :

```text
Could not resolve host: mirrors.rockylinux.org
```

## Correction

Le rôle `common_hosts` vérifie désormais la résolution DNS du dépôt Rocky Linux avant la task `Install base packages`.

Si la résolution échoue, l’installation des paquets est sautée avec un message clair afin d’éviter un arrêt brutal du playbook.

## Action opérateur

Corriger DNS ou accès dépôt puis relancer :

```bash
ansible-playbook -i inventory/hosts.ini playbooks/00-bootstrap-common.yml
```

[Retour à l'index](index.md)
