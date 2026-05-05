# Ansible callback compatibility

[Retour à l'index](index.md)

## Problème corrigé

Le callback `community.general.yaml` a été supprimé dans `community.general` 12.

## Correction appliquée

```ini
stdout_callback = ansible.builtin.default
result_format = yaml
```

## Validation

```bash
ansible-playbook -i inventory/hosts.ini playbooks/98-release-readiness-check.yml
```

[Retour à l'index](index.md)
