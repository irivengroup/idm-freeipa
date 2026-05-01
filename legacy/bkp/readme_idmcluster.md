# IDMCluster — Lab Docker FreeIPA / Red Hat IdM sur Rocky Linux 9

## Présentation

IDMCluster est un laboratoire d’entreprise réaliste permettant de simuler une infrastructure **Red Hat Identity Management (IdM) / FreeIPA** multi-sites dans des conditions proches de la production.

Le projet est conçu pour :

- la montée en compétence sur FreeIPA / IdM
- les démonstrations techniques
- les soutenances de projet (Master / Ingénieur / HBA)
- les tests d’architecture IAM
- les validations DNS / Kerberos / LDAP / SSO
- les scénarios de réplication multi-sites
- la préparation à l’intégration Active Directory

L’environnement repose sur **Docker Desktop sous Windows**, avec des conteneurs **Rocky Linux 9** et des serveurs **FreeIPA (version Rocky 9)**.

---

## Objectifs du Lab

Le lab reproduit une architecture entreprise avec :

- 2 sites géographiques distincts
- 1 serveur IdM/FreeIPA par site
- DNS intégré sur chaque serveur IdM
- réplication inter-sites
- clients automatiquement enrôlés
- nœuds à enrôler manuellement par l’opérateur
- reverse proxy Nginx hautement résilient
- SSH activé sur l’ensemble des machines
- configuration centralisée via `.env`
- architecture extensible pour simulation AD Trust

---

## Architecture

```text
Windows Host
│
├── Docker Desktop (WSL2 backend)
│
├── Site A → 192.168.1.128/26
│   ├── idm-primary      → Primary IdM + DNS
│   ├── client-a1  → Auto-enrolled
│   ├── client-a2  → Auto-enrolled
│   └── node-a     → Manual enrollment
│
├── Site B → 192.168.1.192/26
│   ├── idm-replica      → Replica IdM + DNS
│   ├── client-b1  → Auto-enrolled
│   ├── client-b2  → Auto-enrolled
│   └── node-b     → Manual enrollment
│
└── idm-loadbalancer       → Reverse proxy / HA entrypoint
```

---

## Réseaux

### Site A

- Subnet : `192.168.1.128/26`
- Gateway : `192.168.1.129`

### Site B

- Subnet : `192.168.1.192/26`
- Gateway : `192.168.1.193`

---

## Stack Technique

### Serveurs IdM

- Image : `freeipa/freeipa-server:rocky-9`
- DNS intégré
- Kerberos
- LDAP (389-DS)
- Dogtag PKI
- Web UI
- Replica support

### Clients / Nodes

- Image : `rockylinux:9`
- FreeIPA Client
- SSSD
- SSH
- tools réseau

### Reverse Proxy

- Image : `nginx:stable`

### Orchestration

- Docker Compose
- `.env` centralisé

---

## Arborescence du Projet

```text
idmcluster/
│
├── docker-compose.yml
├── .env
├── README.md
│
├── server/
│   ├── Dockerfile
│   └── entrypoint.sh
│
├── client/
│   ├── Dockerfile
│   └── entrypoint.sh
│
├── nginx/
│   └── nginx.conf
│
└── scripts/
    ├── Linux/
    │   ├── 00-check-linux.sh
    │   ├── 01-up.sh
    │   ├── 02-install-replica-b.sh
    │   └── 03-enroll-auto-clients.sh
    │
    └── Windows/
        ├── 00-check-windows.ps1
        ├── 01-up.ps1
        ├── 02-install-replica-b.ps1
        └── 03-enroll-auto-clients.ps1
```

---

## Prérequis

## Windows

- Windows 10/11
- Docker Desktop
- WSL2 activé
- minimum 8 Go RAM (12–16 Go recommandé)
- minimum 4 vCPU (6+ recommandé)

## Linux

- Docker Engine
- Docker Compose
- support systemd/cgroups

---

## Déploiement

# Windows

## 1. Autoriser temporairement les scripts PowerShell

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
Get-ChildItem -Path .\scripts\Windows -Filter *.ps1 | Unblock-File
```

## 2. Vérification de l’environnement

```powershell
.\scripts\Windows\00-check-windows.ps1
```

## 3. Démarrage du lab

```powershell
.\scripts\Windows\01-up.ps1
```

## 4. Suivi de l’installation primaire

```powershell
docker logs -f idm-primary
```

Attendre :

```text
FreeIPA server configured.
```

## 5. Installation de la Replica

```powershell
.\scripts\Windows\02-install-replica-b.ps1
```

## 6. Enrollment automatique des clients

```powershell
.\scripts\Windows\03-enroll-auto-clients.ps1
```

---

# Linux

```bash
chmod +x scripts/Linux/*.sh
./scripts/Linux/00-check-linux.sh
./scripts/Linux/01-up.sh
```

Puis :

```bash
docker logs -f idm-primary
```

Ensuite :

```bash
./scripts/Linux/02-install-replica-b.sh
./scripts/Linux/03-enroll-auto-clients.sh
```

---

## Validation

### Vérifier les services IPA

```bash
docker exec -it idm-primary ipactl status
```

### Authentification admin

```bash
docker exec -it idm-primary kinit admin
```

### Vérifier les zones DNS

```bash
docker exec -it idm-primary ipa dnszone-find
```

### Vérifier la réplication

```bash
docker exec -it idm-primary ipa topologysegment-find domain
```

### Vérifier les clients

```bash
docker exec -it client-a1 id admin
```

---

## Ports Importants

### DNS

- TCP/UDP 53

### Kerberos

- TCP/UDP 88
- TCP/UDP 464

### LDAP / LDAPS

- TCP 389
- TCP 636

### HTTP / HTTPS

- TCP 80
- TCP 443

### NTP

- UDP 123

### SSH

- TCP 22

---

## Cas d’Usage

Ce lab permet de démontrer :

- création utilisateurs / groupes
- politiques HBAC
- sudo centralisé
- gestion SSH centralisée
- DNS intégré
- réplication multi-site
- PKI interne
- certificats
- Kerberos
- SSO
- future intégration AD Trust

---

## Limites

Ce projet est conçu pour un **lab avancé**, pas pour une production réelle.

Pour la production :

- machines virtuelles recommandées
- stockage persistant renforcé
- supervision
- backup/restore
- PRA/PCA
- PKI durcie
- architecture réseau dédiée

---

## Auteur

Projet conçu pour environnement HBA / architecture IdM avancée.

Objectif : reproduire un environnement entreprise réaliste orienté expertise FreeIPA / Red Hat IdM.

