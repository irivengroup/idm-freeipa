# Patch management baseline

[Retour à l'index](index.md)

## Objectif

Le rôle `patch_baseline` permet de contrôler les mises à jour système sans exécution destructive par défaut.

Le mode standard est un mode check uniquement.

## Playbook

```bash
ansible-playbook -i inventory/hosts.ini playbooks/94-patch-baseline-check.yml
```

## Fonctionnement

Par défaut :

- vérification des mises à jour disponibles ;
- mode sécurité uniquement ;
- aucun patch automatique ;
- aucun reboot automatique ;
- génération d'un rapport par hôte.

## Application contrôlée

Pour appliquer réellement les mises à jour :

```bash
ansible-playbook -i inventory/hosts.ini playbooks/94-patch-baseline-check.yml \
  -e patch_baseline_apply_updates=true
```

Pour autoriser le reboot automatique :

```bash
ansible-playbook -i inventory/hosts.ini playbooks/94-patch-baseline-check.yml \
  -e patch_baseline_apply_updates=true \
  -e patch_baseline_reboot_allowed=true
```

## Rapports

```text
/var/log/idm-patch-baseline/
```

Exemple :

```bash
cat /var/log/idm-patch-baseline/idmprimarya.report
```

## Bonnes pratiques

Pour les serveurs IDM :

- patcher hors fenêtre critique ;
- valider `ipactl status` après patch ;
- valider réplication ;
- valider Kerberos ;
- exécuter `60-healthcheck.yml`.

## Validation post-patch

```bash
ansible-playbook -i inventory/hosts.ini playbooks/60-healthcheck.yml
```

[Retour à l'index](index.md)
