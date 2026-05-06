# IdM DNS forwarders

[Retour à l'index](index.md)

## Problème

Les clients utilisent les DNS IdM internes comme nameservers.  
Si IdM DNS ne forwarde pas les requêtes externes, les hôtes ne peuvent pas résoudre les dépôts publics.

Erreur typique :

```text
Could not resolve host: mirrors.rockylinux.org
```

## Correction

Le rôle `idm_dns_forwarders` configure les forwarders DNS globaux FreeIPA :

```bash
ipa dnsconfig-mod --forward-policy=first --forwarder=1.1.1.1 --forwarder=8.8.8.8
```

## Variables

```yaml
idm_dns_forwarders:
  - 1.1.1.1
  - 8.8.8.8

idm_dns_forward_policy: first
```

## Playbook

```bash
ansible-playbook --ask-vault-pass -i inventory/hosts.ini playbooks/35-configure-dns-forwarders.yml
```

## Validation

```bash
dig @idmprimarya.iriven.lab mirrors.rockylinux.org
dig @idmreplicab.iriven.lab mirrors.rockylinux.org
getent hosts mirrors.rockylinux.org
```

[Retour à l'index](index.md)
