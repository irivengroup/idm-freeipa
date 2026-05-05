# Load balancer backend drain

[Retour à l'index](index.md)

## Objectif

Sortir ou réintégrer proprement un serveur FreeIPA d’un backend HAProxy avant ou après maintenance.

## Playbook

```bash
ansible-playbook -i inventory/hosts.ini playbooks/43-lb-backend-drain.yml \
  -e lb_backend_drain_backend_name=freeipa_backend \
  -e lb_backend_drain_server_name=idmprimarya \
  -e lb_backend_drain_state=drain
```

## États supportés

- `drain`
- `maint`
- `ready`

## Réintégration

```bash
ansible-playbook -i inventory/hosts.ini playbooks/43-lb-backend-drain.yml \
  -e lb_backend_drain_server_name=idmprimarya \
  -e lb_backend_drain_state=ready
```

## Validation manuelle

```bash
echo "show servers state" | sudo socat - /run/haproxy/admin.sock
```

[Retour à l'index](index.md)
