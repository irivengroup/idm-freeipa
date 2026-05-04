# Replica promotion and topology check

[Retour à l'index](index.md)

## Objectif

Vérifier la santé de la topologie FreeIPA avant maintenance, bascule opérationnelle ou promotion fonctionnelle d’un replica.

## Playbook

```bash
ansible-playbook -i inventory/hosts.ini playbooks/56-replica-topology-check.yml
```

## Checks

- Kerberos keytab ;
- `ipactl status` ;
- inventaire des serveurs IPA ;
- topologie `domain` ;
- topologie `ca` ;
- DNS SRV ;
- certmonger ;
- `ipa-replica-manage list -v` si disponible.

## Rapport

```text
/var/log/idm-replica-topology/<hostname>-replica-topology.report
```

## Mode strict

```bash
ansible-playbook -i inventory/hosts.ini playbooks/56-replica-topology-check.yml \
  -e replica_topology_check_fail_on_warnings=true
```

[Retour à l'index](index.md)
