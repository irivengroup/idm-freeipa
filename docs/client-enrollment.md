# Client enrollment and DNS management

[Retour à l'index](index.md)

## Objectif

Le rôle `ipa_client` rend l'enrôlement client FreeIPA idempotent.

Il gère :

- `/etc/hosts` pour les serveurs IPA ;
- la configuration DNS via NetworkManager ;
- l'objet host FreeIPA ;
- le DNS record A ;
- la suppression des A records obsolètes ;
- `ipa-client-install` uniquement si nécessaire ;
- les validations post-enrôlement.

## Cas corrigés

### Host IPA présent mais record DNS absent

Symptôme :

```text
ssh: Could not resolve hostname idmclient1b.iriven.lab
```

### Record DNS avec mauvaise IP

Symptôme :

```text
ssh: connect to host idmclient1b.iriven.lab port 22: Connection timed out
```

Le rôle compare le DNS record A avec `ansible_host` dans `inventory/hosts.ini`.

## Vérification

```bash
dig idmclient1b.iriven.lab +short
ipa dnsrecord-show iriven.lab idmclient1b
ssh iriven@idmclient1b.iriven.lab
```

[Retour à l'index](index.md)
