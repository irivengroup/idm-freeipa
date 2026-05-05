# AD Trust readiness check

[Retour à l'index](index.md)

## Objectif

Préparer l’infrastructure FreeIPA / Red Hat IdM à une future relation de confiance Active Directory.

Ce check est non destructif : il ne crée pas de trust.

## Playbook

```bash
ansible-playbook -i inventory/hosts.ini playbooks/99-ad-trust-readiness-check.yml
```

Avec domaine AD :

```bash
ansible-playbook -i inventory/hosts.ini playbooks/99-ad-trust-readiness-check.yml \
  -e ad_trust_readiness_ad_domain=ad.example.com \
  -e 'ad_trust_readiness_ad_dns_servers=["192.168.10.10","192.168.10.11"]'
```

## Checks

- paquets AD Trust ;
- commandes `ipa-adtrust-install`, `net`, `wbinfo` ;
- Kerberos keytab ;
- `ipa trustconfig-show` ;
- configuration IPA ;
- synchronisation Chrony ;
- DNS SRV AD ;
- ports TCP AD critiques si des DNS/DC sont fournis.

## Rapport

```text
/var/log/idm-ad-trust-readiness/<hostname>-ad-trust-readiness.report
```

[Retour à l'index](index.md)
