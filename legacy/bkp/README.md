# IDMCLUSTER - Docker FreeIPA/RedHat IdM Rocky Linux 9

Objectif: poste hôte Windows ou Linux, mais images applicatives Rocky Linux 9.

## Topologie

- Site A: `192.168.1.128/26`
  - `idm-primary` DNS/CA/Kerberos/LDAP: `192.168.1.130`
  - `client-a1`, `client-a2` auto-enrôlés
  - `node-a` enrôlement opérateur
- Site B: `192.168.1.192/26`
  - `idm-replica` replica DNS: `192.168.1.194`
  - `client-b1`, `client-b2` auto-enrôlés
  - `node-b` enrôlement opérateur
- `idm-loadbalancer`: entrée HA L4/L7 de lab

## Dockerfiles

- `server/Dockerfile`: serveur IdM basé sur `freeipa/freeipa-server:rocky-9`, avec outillage d'administration.
- `client/Dockerfile`: clients/nodes basés sur `rockylinux:9`, avec `freeipa-client`, SSSD et SSH.

Les options critiques d'installation serveur sont injectées dans `docker-compose.yml` via `command:` afin que l'image reste réutilisable et que `.env` reste la source centrale.

## Windows

PowerShell depuis la racine du lab:

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
Get-ChildItem -Path .\scripts\Windows -Filter *.ps1 | Unblock-File
.\scripts\Windows\00-check-windows.ps1
.\scripts\Windows\01-up.ps1
docker logs -f idm-primary
.\scripts\Windows\02-install-replica-b.ps1
.\scripts\Windows\03-enroll-auto-clients.ps1
.\scripts\Windows\06-validate.ps1
```

## Linux

```bash
./scripts/Linux/00-check-linux.sh
./scripts/Linux/01-up.sh
docker logs -f idm-primary
./scripts/Linux/02-install-replica-b.sh
./scripts/Linux/03-enroll-auto-clients.sh
./scripts/Linux/06-validate.sh
```

## Nodes opérateur

Windows:

```powershell
.\scripts\Windows\04-manual-enroll-node-a.ps1
.\scripts\Windows\05-manual-enroll-node-b.ps1
```

Linux:

```bash
./scripts/Linux/04-manual-enroll-node-a.sh
./scripts/Linux/05-manual-enroll-node-b.sh
```

## Commandes utiles

```bash
docker exec idm-primary ipactl status
docker exec idm-primary ipa host-find --sizelimit=0
docker exec idm-primary dig +short SRV _ldap._tcp.iriven.lab @127.0.0.1
docker exec client-a1 getent passwd admin
```

## Remarque production

Ce lab reproduit une logique entreprise multi-site, mais FreeIPA/IdM en production se déploie normalement sur VM ou bare metal, pas en conteneur Docker Desktop.
