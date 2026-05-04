# Role `ha_failover_check`

Validates HAProxy and Keepalived availability for the IRIVEN IDM VIP.

## Scope

- VIP DNS resolution
- HAProxy service status
- Keepalived service status
- VIP ownership visibility
- LDAP/Kerberos/HTTPS reachability through the VIP
- optional controlled Keepalived failover check

Disruptive checks are disabled by default.
