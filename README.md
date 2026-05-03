# IRIVEN IDM Lab — FreeIPA / Red Hat IdM sur Rocky Linux 10

## 1. Présentation

**IRIVEN IDM Lab** est une infrastructure de laboratoire professionnelle pour déployer, automatiser et valider une plateforme **Red Hat Identity Management (IdM) / FreeIPA** sur **Rocky Linux 10**.

Le projet fournit un socle proche production, piloté par **Ansible**, avec une attention particulière portée à l’idempotence, à la résilience et à la maintenabilité.

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
- healthchecks et validations post-déploiement

Documentation complète : [docs/index.md](docs/index.md)

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

| Rôle | Hostname | FQDN |
|---|---|---|
| Primary IdM | idmprimarya | idmprimarya.iriven.lab |
| Replica IdM | idmreplicab | idmreplicab.iriven.lab |
| Load Balancer 1 | idmloadbalancer1 | idmloadbalancer1.iriven.lab |
| Load Balancer 2 | idmloadbalancer2 | idmloadbalancer2.iriven.lab |
| VIP Load Balancer | idmloadbalancer | idmloadbalancer.iriven.lab |
| Client A1 | idmclient1a | idmclient1a.iriven.lab |
| Client A2 | idmclient2a | idmclient2a.iriven.lab |
| Client B1 | idmclient1b | idmclient1b.iriven.lab |
| Client B2 | idmclient2b | idmclient2b.iriven.lab |
| Admin Host | idmadmin | idmadmin.iriven.lab |

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

---

## 5. Déploiement

Déploiement complet :

```bash
ansible-playbook -i inventory/hosts.ini playbooks/site.yml
```

Déploiement ciblé :

```bash
ansible-playbook -i inventory/hosts.ini playbooks/10-install-primary.yml
ansible-playbook -i inventory/hosts.ini playbooks/20-install-replica.yml
ansible-playbook -i inventory/hosts.ini playbooks/40-configure-loadbalancers.yml
ansible-playbook -i inventory/hosts.ini playbooks/50-configure-rbac.yml
```

---

## 6. Validation rapide

```bash
ansible -i inventory/hosts.ini idm_servers -b -m shell -a 'ipactl status'
ansible -i inventory/hosts.ini idm_servers -b -m shell -a 'ipa-healthcheck --output-type human || true'
ansible -i inventory/hosts.ini idm_all -b -m shell -a 'chronyc sources || true'
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

---

## 7. Points de robustesse intégrés

Cette version intègre :

- variables projet centralisées dans `inventory/group_vars/all/common.yml`
- matrice RBAC dans `inventory/group_vars/all/rbac.yml`
- inventory utilisé comme source de vérité des hosts
- groupe `[idm_servers:children]` pour primary + replica
- rôles Ansible par responsabilité
- playbooks courts appelant les rôles
- configuration NTP serveur/client
- configuration HAProxy résiliente
- RBAC/HBAC/sudo idempotents
- hostgroups IPA construits depuis l’inventaire
- playbooks compatibles avec ajouts futurs `app_servers`, `db_servers`, `jump_hosts`

---

## 8. Limites connues

Ce projet reste un lab avancé. Pour une production réelle, compléter avec :

- sauvegardes automatisées et testées
- restauration documentée
- supervision centralisée
- centralisation des logs
- rotation des secrets
- MFA
- PRA / PCA
- durcissement TLS/PKI
- procédures de patching
- segmentation réseau formelle

---

## 9. Finalité pédagogique

Ce lab permet de pratiquer une architecture IdM complète :

- FreeIPA Primary / Replica
- DNS intégré
- Kerberos
- LDAP / LDAPS
- SSSD
- HAProxy
- Chrony
- sudo IPA
- HBAC
- RBAC production-grade
- validation de résilience
- exploitation automatisée avec Ansible
