# IPA DNS/NTP forwarders

[Retour à l'index](index.md)

## Objectif

Les fonctionnalités de l’ancien rôle `idm_dns_forwarders` sont maintenant intégrées dans le rôle existant `ipa_dns_ntp`.

Le rôle configure les forwarders DNS globaux FreeIPA sur `idm_primary` afin que les clients utilisant les DNS IdM puissent résoudre les noms externes.

## Variables

```yaml
idm_dns_forwarders:
  - 1.1.1.1
  - 8.8.8.8

idm_dns_forward_policy: first
```

Variables internes du rôle :

```yaml
ipa_dns_ntp_manage_dns_forwarders: true
ipa_dns_ntp_dns_forwarders: "{{ idm_dns_forwarders | default(['1.1.1.1', '8.8.8.8']) }}"
ipa_dns_ntp_dns_forward_policy: "{{ idm_dns_forward_policy | default('first') }}"
```

## Validation

```bash
dig @idmprimarya.iriven.lab mirrors.rockylinux.org
dig @idmreplicab.iriven.lab mirrors.rockylinux.org
getent hosts mirrors.rockylinux.org
```

[Retour à l'index](index.md)
