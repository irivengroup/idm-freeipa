# IDMCluster — Lab Docker FreeIPA / RedHat IdM sur Rocky Linux 9

## 1. Présentation

**IDMCluster** est un laboratoire Docker professionnel pour simuler une infrastructure **Red Hat Identity Management (IdM) / FreeIPA** multi-site sur base **Rocky Linux 9**.

Le poste de travail peut être sous **Windows avec Docker Desktop / WSL2**, tandis que les conteneurs applicatifs restent alignés Rocky Linux 9.

Ce lab vise un contexte proche production pour l’apprentissage, la démonstration et la soutenance technique : DNS intégré, Kerberos, LDAP, PKI, réplication, clients enrôlés automatiquement, nodes à enrôler manuellement et reverse proxy Nginx.

---

## 2. Architecture cible

```text
Windows / Linux Host
│
├── Docker Engine / Docker Desktop
│
├── Site A — 192.168.1.128/26
│   ├── idmprimarya       Primary IdM + DNS
│   ├── idmclient1a       Client auto-enrôlé
│   ├── idmclient2a       Client auto-enrôlé
│   └── idmnode1a         Node opérateur, enrollment manuel
│
├── Site B — 192.168.1.192/26
│   ├── idmreplicab       Replica IdM + DNS
│   ├── idmclient1b       Client auto-enrôlé
│   ├── idmclient2b       Client auto-enrôlé
│   └── idmnode1b         Node opérateur, enrollment manuel
│
└── idmloadbalancer       Reverse proxy / point d’entrée HA
```

---

## 3. Nomenclature

| Rôle | Nom conteneur | FQDN |
|---|---|---|
| Primary IdM Site A | `idmprimarya` | `idmprimarya.iriven.lab` |
| Replica IdM Site B | `idmreplicab` | `idmreplicab.iriven.lab` |
| Load Balancer | `idmloadbalancer` | `idmloadbalancer.iriven.lab` |
| Client A1 | `idmclient1a` | `idmclient1a.iriven.lab` |
| Client A2 | `idmclient2a` | `idmclient2a.iriven.lab` |
| Client B1 | `idmclient1b` | `idmclient1b.iriven.lab` |
| Client B2 | `idmclient2b` | `idmclient2b.iriven.lab` |
| Node A | `idmnode1a` | `idmnode1a.iriven.lab` |
| Node B | `idmnode1b` | `idmnode1b.iriven.lab` |

---

## 4. Prérequis

### Windows

- Windows 10/11
- Docker Desktop avec backend WSL2
- Docker context `desktop-linux`
- 8 Go RAM minimum, 12–16 Go recommandés
- 4 vCPU minimum, 6+ recommandés
- 60 Go d’espace disque recommandés

### Linux

- Docker Engine récent
- Docker Compose v2+
- cgroups/systemd fonctionnels

---

## 5. Points de robustesse intégrés

Cette version corrige les problèmes rencontrés pendant les premiers essais :

- suppression de `init: true`, incompatible avec FreeIPA en conteneur systemd
- remplacement de `cgroupns_mode` par `cgroup: host`, compatible Docker Compose actuel
- Dockerfile serveur allégé : aucun `dnf install` inutile sur l’image FreeIPA
- lancement FreeIPA via les variables attendues par l’image upstream (`PASSWORD`, `IPA_SERVER_INSTALL_OPTS`)
- `/usr/sbin/init` reste PID 1, condition indispensable pour systemd
- scripts PowerShell et Bash séparés
- scripts avec arrêt immédiat en cas d’erreur
- noms conteneurs cohérents et orientés rôle/site
- healthchecks pour serveurs et clients
- restart policy `unless-stopped`
- installation replica contrôlée étape par étape
- reverse proxy avec backend primaire et replica de secours

---

## 6. Déploiement Windows

Depuis PowerShell dans le dossier du projet :

```powershell
Set-ExecutionPolicy Bypass -Scope Process -Force
Get-ChildItem -Path .\scripts\Windows -Filter *.ps1 | Unblock-File
.\scripts\Windows\00-check-windows.ps1
.\scripts\Windows\01-up.ps1
```

Suivre l’installation du serveur primaire :

```powershell
docker logs -f idmprimarya
```

Log systemd détaillé :

```powershell
docker exec -it idmprimarya journalctl -u ipa-server-configure-first.service -f
```

Quand le primaire est prêt :

```powershell
.\scripts\Windows\02-install-replica-b.ps1
.\scripts\Windows\03-enroll-auto-clients.ps1
```

---

## 7. Déploiement Linux

```bash
chmod +x scripts/Linux/*.sh
./scripts/Linux/00-check-linux.sh
./scripts/Linux/01-up.sh
```

Suivre l’installation :

```bash
docker logs -f idmprimarya
docker exec -it idmprimarya journalctl -u ipa-server-configure-first.service -f
```

Puis :

```bash
./scripts/Linux/02-install-replica-b.sh
./scripts/Linux/03-enroll-auto-clients.sh
```

---

## 8. Validation opérationnelle

```bash
docker exec -it idmprimarya ipactl status
docker exec -it idmprimarya kinit admin
docker exec -it idmprimarya ipa dnszone-find
docker exec -it idmprimarya ipa host-find
docker exec -it idmclient1a id admin
```

Vérification DNS :

```bash
docker exec -it idmprimarya dig @127.0.0.1 idmprimarya.iriven.lab +short
docker exec -it idmclient1a dig idmprimarya.iriven.lab +short
```

Vérification réplication :

```bash
docker exec -it idmprimarya ipa topologysegment-find domain
docker exec -it idmreplicab ipactl status
```

---

## 9. Enrollment manuel des nodes

Les nodes `idmnode1a` et `idmnode1b` restent volontairement en mode manuel.

Exemple pour `idmnode1a` :

```bash
docker exec -it idmnode1a bash
ipa-client-install \
  --unattended \
  --domain iriven.lab \
  --realm IRIVEN.LAB \
  --server idmprimarya.iriven.lab \
  --principal admin \
  --password 'Str0ngAdminPassw0rd!' \
  --mkhomedir \
  --no-ntp
```

---

## 10. Ports exposés

| Service | Port conteneur | Primary exposé | Replica exposé |
|---|---:|---:|---:|
| DNS | 53 TCP/UDP | 1053 | 2053 |
| HTTP | 80 TCP | 1080 | 2080 |
| HTTPS | 443 TCP | 1443 | 2443 |
| LDAP | 389 TCP | 1389 | 2389 |
| LDAPS | 636 TCP | 1636 | 2636 |
| Kerberos | 88 TCP/UDP | 1088 | 2088 |
| kpasswd | 464 TCP/UDP | 1464 | 2464 |
| NTP | 123 UDP | 1123 | 2123 |

Load balancer :

| Service | Port hôte |
|---|---:|
| HTTP | 8080 |
| HTTPS | 8443 |
| LDAP | 8389 |
| LDAPS | 8636 |

---

## 11. Commandes utiles

Statut global :

```powershell
.\scripts\Windows\04-status.ps1
```

ou :

```bash
./scripts/Linux/04-status.sh
```

Arrêt :

```bash
docker compose stop
```

Reset complet avec suppression des volumes :

```powershell
.\scripts\Windows\99-reset.ps1
```

ou :

```bash
./scripts/Linux/99-reset.sh
```

```bash
docker exec idmprimarya ipactl status
docker exec idmprimarya ipa host-find --sizelimit=0
docker exec idmprimarya dig +short SRV _ldap._tcp.iriven.lab @127.0.0.1
docker exec idmclient1a getent passwd admin
```

---

## 12. Limites connues

Ce projet reste un **lab Docker avancé**. Pour une production réelle, privilégier des VM ou serveurs dédiés avec :

- sauvegarde/restauration IdM
- supervision
- NTP maîtrisé
- segmentation réseau réelle
- durcissement TLS/PKI
- PRA/PCA
- DNS d’entreprise redondant
- procédures de patching

---

## 13. Troubleshooting rapide

### Le conteneur FreeIPA ne produit aucun log

Vérifier :

```bash
docker exec -it idmprimarya ps -ef
docker exec -it idmprimarya systemctl status ipa-server-configure-first.service --no-pager
docker exec -it idmprimarya journalctl -u ipa-server-configure-first.service -n 120 --no-pager
```

### Compose refuse `cgroupns_mode`

Utiliser :

```yaml
cgroup: host
```

### Ne jamais utiliser `init: true` pour les serveurs FreeIPA

FreeIPA doit garder systemd comme PID 1.

### Le build serveur échoue sur `dnf install`

Le Dockerfile serveur ne doit pas lancer `dnf install`. L’image `freeipa/freeipa-server:rocky-9` contient déjà les composants requis.

---

## 14. Finalité pédagogique

Ce lab permet de pratiquer :

- installation IdM primaire
- réplication multi-site
- DNS intégré
- Kerberos
- LDAP/LDAPS
- SSSD
- HBAC
- sudo rules
- enrollment client
- architecture HA applicative
- préparation à un scénario AD Trust

