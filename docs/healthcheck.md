# Platform healthcheck

[Retour à l'index](index.md)

## Objectif

Le rôle existant `ipa_healthcheck` centralise les validations opérationnelles de la plateforme.

Il intègre désormais les health checks non destructifs précédemment envisagés dans `platform_smoke_tests`.

## Playbook

```bash
ansible-playbook -i inventory/hosts.ini playbooks/60-healthcheck.yml
```

## Couverture

### Tous les hôtes

- résolution DNS primary / replica / VIP ;
- keytab Kerberos ;
- SSSD ;
- lookup identité `admin` ;
- Chrony ;
- validation `sshd -t`.

### Serveurs IDM

- installation du paquet `ipa-healthcheck` ;
- correction permission connue `CS.cfg` sur primary ;
- `ipactl status` ;
- `ipa-healthcheck --output-type human` ;
- timer PKI baseline.

### Load balancers

- statut HAProxy ;
- validation `haproxy -c`.

### Primary

- timer backup.

## Lecture des résultats

Le rôle affiche un résumé par hôte avec les codes retour des contrôles.

`0` indique un succès.  
Une valeur non nulle signale un point à analyser.

## Règle projet

Il ne doit pas exister de rôle séparé `platform_smoke_tests`.

Les validations globales doivent être consolidées dans :

```text
roles/ipa_healthcheck
playbooks/60-healthcheck.yml
```

[Retour à l'index](index.md)
