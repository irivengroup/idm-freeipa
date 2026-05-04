# HA failover check

[Retour à l'index](index.md)

## Objectif

Le rôle `ha_failover_check` valide la résilience HAProxy + Keepalived autour de la VIP IdM.

La nomenclature du projet utilise `check` pour les validations opérationnelles.

## Playbook

```bash
ansible-playbook -i inventory/hosts.ini playbooks/92-ha-failover-check.yml
```

## Checks non disruptifs

Par défaut, le rôle vérifie :

- résolution DNS de la VIP ;
- statut HAProxy ;
- statut Keepalived ;
- présence locale de la VIP sur un load balancer ;
- accès LDAP via VIP ;
- accès Kerberos via VIP ;
- accès HTTPS via VIP ;
- validation `haproxy -c`.

## Check disruptif optionnel

Le basculement réel Keepalived est désactivé par défaut.

Activation explicite :

```bash
ansible-playbook -i inventory/hosts.ini playbooks/92-ha-failover-check.yml \
  -e ha_failover_check_enable_disruptive_checks=true
```

Ce mode :

1. arrête temporairement Keepalived sur le premier load balancer ;
2. attend le basculement ;
3. vérifie LDAP/HTTPS via la VIP ;
4. redémarre Keepalived.

## Validation manuelle

```bash
getent hosts idmloadbalancer.iriven.lab
ip address show | grep 192.168.1.55
systemctl status haproxy
systemctl status keepalived
haproxy -c -f /etc/haproxy/haproxy.cfg
nc -zv idmloadbalancer.iriven.lab 389
nc -zv idmloadbalancer.iriven.lab 88
nc -zv idmloadbalancer.iriven.lab 443
```

## Critères d'acceptation

- la VIP est résolue ;
- HAProxy est actif ;
- Keepalived est actif ;
- au moins un load balancer possède la VIP ;
- les ports IdM critiques répondent via la VIP ;
- la configuration HAProxy est valide.

[Retour à l'index](index.md)
