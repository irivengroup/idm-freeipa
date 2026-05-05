# Maintenance mode

[Retour à l'index](index.md)

## Activation

```bash
ansible-playbook -i inventory/hosts.ini playbooks/44-maintenance-mode.yml \
  -e maintenance_mode_target_host=idmprimarya \
  -e maintenance_mode_action=enable
```

## Désactivation

```bash
ansible-playbook -i inventory/hosts.ini playbooks/44-maintenance-mode.yml \
  -e maintenance_mode_target_host=idmprimarya \
  -e maintenance_mode_action=disable
```

[Retour à l'index](index.md)
