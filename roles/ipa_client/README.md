# Role `ipa_client`

This role enrolls Linux hosts as FreeIPA clients and manages DNS prerequisites.

## Responsibilities

- configure `/etc/hosts` with IPA primary and replica entries;
- configure DNS servers through NetworkManager;
- create or update the FreeIPA host object;
- create or correct the IPA DNS A record;
- remove stale A records for the same host;
- run `ipa-client-install` only when needed;
- validate keytab, SSSD and DNS resolution.

## Source of truth

Host IPs are taken from `inventory/hosts.ini` through `ansible_host`.
