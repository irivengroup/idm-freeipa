# Linux Identity Management (IDM) Infra

Un outil Ansible permettant de déployer et d’administrer une infrastructure IDM basée sur FreeIPA / RedHat Identity Management (IdM) sous Rocky Linux 10.

## 1. Présentation

**IRIVEN IDM** est une solution professionnelle permettant de déployer, sécuriser, automatiser et exploiter une plateforme **Red Hat Identity Management (IdM) / FreeIPA** sur **Rocky Linux 10**.

Le projet fournit un socle **Enterprise Grade**, piloté par **Ansible**, avec une attention forte portée à l’idempotence, à la résilience, à l’auditabilité et à la maintenabilité.

Il couvre notamment :

- FreeIPA Primary + Replica
- DNS intégré
- Kerberos
- LDAP / LDAPS
- PKI
- réplication IdM
- clients Linux enrôlés
- HAProxy + Keepalived
- VIP d’accès IdM
- Chrony / NTP côté serveurs et clients
- SSSD
- sudo rules
- HBAC rules
- matrice RBAC production-grade
- healthchecks unifiés post-déploiement
- validation HA / failover contrôlé
- baseline de supervision et monitoring
- baseline audit et journalisation
- rotation automatique des logs
- hardening SSH
- baseline PKI
- baseline patch management
- sauvegardes FreeIPA automatisées
- restore readiness checks
- GitHub Actions CI/CD

Documentation complète : [docs/index.md](docs/index.md)

L’objectif est de fournir un environnement robuste, proche production, pour l’apprentissage avancé, la démonstration technique, l’audit d’architecture et la préparation d’infrastructures professionnelles.

---


## 2. Architecture cible

```text
Administration Host
│
├── idmadmin                Bastion / poste Ansible / client IPA
│
├── Site A — 192.168.1.0/24
│   ├── idmprimarya          Primary IdM + DNS + CA
│   ├── idmclient1a          Client IPA
│   └── idmclient2a          Client IPA
│
├── Site B — 192.168.1.0/24
│   ├── idmreplicab          Replica IdM + DNS
│   ├── idmclient1b          Client IPA
│   └── idmclient2b          Client IPA
│
└── HA Layer
    ├── idmloadbalancer1     HAProxy + Keepalived
    └── idmloadbalancer2     HAProxy + Keepalived
```

Point d’entrée principal :

```text
idmloadbalancer.iriven.lab
```

---

## 3. Nomenclature

| Rôle            | Hostname         | FQDN                        |
| --------------- | ---------------- | --------------------------- |
| Primary IdM     | idmprimarya      | idmprimarya.iriven.lab      |
| Replica IdM     | idmreplicab      | idmreplicab.iriven.lab      |
| Load Balancer 1 | idmloadbalancer1 | idmloadbalancer1.iriven.lab |
| Load Balancer 2 | idmloadbalancer2 | idmloadbalancer2.iriven.lab |
| VIP Load Balancer          | idmloadbalancer  | idmloadbalancer.iriven.lab  |
| Client A1       | idmclient1a      | idmclient1a.iriven.lab      |
| Client A2       | idmclient2a      | idmclient2a.iriven.lab      |
| Client B1       | idmclient1b      | idmclient1b.iriven.lab      |
| Client B2       | idmclient2b      | idmclient2b.iriven.lab      |
| Admin Host      | idmadmin         | idmadmin.iriven.lab         |


---

## 4. Structure du projet

```text
idm-lab/
├── ansible.cfg
├── inventory/
│   ├── hosts.ini
│   └── group_vars/
│       └── all/
│           ├── common.yml
│           ├── rbac.yml
│           └── vault.yml.example
├── playbooks/
├── roles/
├── docs/
└── README.md
```

# IP Addressing Plan

| Host | FQDN | IP | Purpose |
|---|---|---:|---|
| idmprimarya | idmprimarya.iriven.lab | 192.168.1.51 | FreeIPA primary |
| idmreplicab | idmreplicab.iriven.lab | 192.168.1.52 | FreeIPA replica |
| idmloadbalancer1 | idmloadbalancer1.iriven.lab | 192.168.1.53 | HAProxy/Keepalived node 1 |
| idmloadbalancer2 | idmloadbalancer2.iriven.lab | 192.168.1.54 | HAProxy/Keepalived node 2 |
| idmloadbalancer | idmloadbalancer.iriven.lab | 192.168.1.55 | VIP |
| idmadmin | idmadmin.iriven.lab | 192.168.1.50 | Admin client |
| idmclient1a | idmclient1a.iriven.lab | 192.168.1.61 | IPA client |
| idmclient2a | idmclient2a.iriven.lab | 192.168.1.62 | IPA client |
| idmclient1b | idmclient1b.iriven.lab | 192.168.1.63 | IPA client |
| idmclient2b | idmclient2b.iriven.lab | 192.168.1.64 | IPA client |

## Network

- Domain: `iriven.lab`
- Realm: `IRIVEN.LAB`
- Lab subnet: `192.168.1.0/24`
- VIP: `192.168.1.55`

## Ports

| Service | Port | Protocol |
|---|---:|---|
| HTTP | 80 | TCP |
| HTTPS | 443 | TCP |
| LDAP | 389 | TCP |
| LDAPS | 636 | TCP |
| Kerberos | 88 | TCP |
| kpasswd | 464 | TCP |
| NTP | 123 | UDP |
| HAProxy stats | 8404 | TCP |

---

## 5. Déploiement

Déploiement depuis `idmadmin` :

Déploiement complet :

```bash
ansible-playbook -i inventory/hosts.ini playbooks/site.yml
```

Déploiement ciblé (par domaine ):

```bash
ansible-playbook -i inventory/hosts.ini playbooks/10-install-primary.yml
ansible-playbook -i inventory/hosts.ini playbooks/20-install-replica.yml
ansible-playbook -i inventory/hosts.ini playbooks/40-configure-loadbalancers.yml
ansible-playbook -i inventory/hosts.ini playbooks/50-configure-rbac.yml
```

### Prise en main Rapide (production)

```bash
cd /opt/idm-lab
ansible-galaxy collection install -r requirements.yml
cp inventory/group_vars/all/vault.yml.example inventory/group_vars/all/vault.yml
ansible-vault encrypt inventory/group_vars/all/vault.yml
ansible-playbook --ask-vault-pass playbooks/site.yml
```

---

## 6. Validation rapide (opérationnelle)

```bash
ansible -i inventory/hosts.ini idm_servers -b -m shell -a 'ipactl status'
ansible -i inventory/hosts.ini idm_servers -b -m shell -a 'ipa-healthcheck --output-type human || true'
ansible -i inventory/hosts.ini idm_all -b -m shell -a 'chronyc sources || true'
```

Autres Exemples de vérification :

```bash
ipa host-find
ipa dnsrecord-find iriven.lab --name=_ldap._tcp
systemctl status sssd
```

Validation client :

```bash
klist -k
sssctl domain-status iriven.lab
id admin
getent passwd admin
```

Validation RBAC :

```bash
ipa group-find --sizelimit=0
ipa hostgroup-find --sizelimit=0
ipa sudorule-find --sizelimit=0
ipa hbacrule-find --sizelimit=0
```

Validation SSH / sudo :

```bash
ssh testadmin@idmadmin.iriven.lab
sudo -l
sudo whoami
```

---

## 7. Points de robustesse intégrés

Cette version intègre :

- variables projet centralisées dans `inventory/group_vars/all/common.yml`
- matrice RBAC dans `inventory/group_vars/all/rbac.yml`
- inventory utilisé comme source de vérité des hosts
- groupe `[idm_servers:children]` pour primary + replica
- rôles Ansible organisés par responsabilité
- playbooks courts appelant les rôles métier
- configuration NTP serveur/client
- configuration HAProxy + Keepalived résiliente
- RBAC / HBAC / sudo idempotents
- hostgroups IPA construits depuis l’inventaire
- DNS client cohérent via NetworkManager
- hardening SSH via `/etc/ssh/sshd_config.d/`
- baseline audit Linux
- rotation automatique des logs
- baseline monitoring et healthcheck unifié (`60-healthcheck.yml`)
- baseline PKI avec contrôles périodiques
- sauvegardes FreeIPA automatisées + rétention + manifestes
- restore readiness check
- patch management contrôlé (mode check par défaut)
- validation HA failover avec checks non disruptifs
- GitHub Actions pour lint, validation et documentation
- playbooks compatibles avec les futurs `app_servers`, `db_servers`, `jump_hosts`

---


## 8. Limites connues

Le projet fournit un socle fortement industrialisé, mais pour une production réelle à grande échelle, il reste recommandé de compléter avec :

- supervision centralisée complète (Prometheus, Grafana, SIEM…)
- centralisation avancée des logs
- rotation et coffre-fort de secrets (Vault, HSM…)
- MFA et politiques d’accès renforcées
- PRA / PCA formalisés et testés régulièrement
- durcissement TLS/PKI avancé
- procédures de patching avec validation métier
- segmentation réseau formelle et micro-segmentation
- gouvernance IAM complète
- intégration CMDB / ITSM
- capacity planning et tests de charge
- stratégie multi-sites de reprise complète

---


## 9. Finalité pédagogique

Ce lab permet de pratiquer une architecture IdM complète avec un niveau proche production :

- déploiement FreeIPA Primary / Replica
- DNS intégré
- Kerberos
- LDAP / LDAPS
- PKI
- réplication
- enrollment client
- SSSD
- HAProxy + Keepalived + failover
- chrony / NTP maîtrisé
- sudo IPA
- HBAC
- RBAC production-grade
- healthchecks unifiés
- patch management contrôlé
- sauvegarde / restore readiness
- audit et journalisation
- hardening SSH
- validation de résilience
- exploitation automatisée avec Ansible
- logique CI/CD et validation continue

L’ensemble a été conçu avec un focus fort sur la maintenabilité, l’idempotence, la traçabilité et les bonnes pratiques d’exploitation d’une plateforme IAM moderne.

---


## 10. Commandes utiles

Exécution ciblée :

```bash
ansible -i inventory/hosts.ini idm_servers -m ping
```

Validation HAProxy :

```bash
systemctl status haproxy
haproxy -c -f /etc/haproxy/haproxy.cfg
```

Validation chrony :

```bash
chronyc tracking
chronyc sources
```

---

## Authors

* **Alfred TCHONDJO** - *Project Initiator* - [Iriven Group](https://www.facebook.com/Tchalf)
