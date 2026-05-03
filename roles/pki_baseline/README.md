# Role `pki_baseline`

Provides a PKI and certificate baseline for FreeIPA / Red Hat IdM servers.

## Responsibilities

- install PKI-related tooling;
- validate certmonger status;
- inventory relevant CA/certificate material;
- check PEM certificate expiry where applicable;
- provide a systemd timer for periodic PKI checks;
- write logs under `/var/log/idm-pki-baseline/`.

## Scope

This role is intended for IDM servers:

- `idm_primary`
- `idm_replica`
- `idm_servers`
