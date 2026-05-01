# IRIVEN IDM Lab — FreeIPA / Red Hat IdM sur Rocky Linux 10

## 1. Présentation

**IRIVEN IDM Lab** est une infrastructure professionnelle de laboratoire et de validation pour **Red Hat Identity Management (IdM) / FreeIPA** déployée sur **Rocky Linux 10** avec automatisation complète via **Ansible**.

Le projet simule une architecture proche production avec :

* FreeIPA Primary
* FreeIPA Replica
* Load Balancers HAProxy
* DNS intégré
* Kerberos
* LDAP / LDAPS
* PKI
* réplication multi-site
* clients enrôlés IPA
* gestion NTP centralisée (serveurs + clients)
* règles sudo
* règles HBAC
* RBAC orienté production
* healthchecks et validations post-déploiement

L’objectif est de fournir un socle robuste, idempotent et maintenable pour l’apprentissage avancé, la démonstration technique et la préparation d’environnements proches production.

→ Documentation complète : [docs/index.md](docs/index.md)

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
| VIP LB          | idmloadbalancer  | idmloadbalancer.iriven.lab  |
| Client A1       | idmclient1a      | idmclient1a.iriven.lab      |
| Client A2       | idmclient2a      | idmclient2a.iriven.lab      |
| Client B1       | idmclient1b      | idmclient1b.iriven.lab      |
| Client B2       | idmclient2b      | idmclient2b.iriven.lab      |
| Admin Host      | idmadmin         | idmadmin.iriven.lab         |

---

## 4. Principes de robustesse intégrés

Cette version intègre les corrections et bonnes pratiques validées pendant les tests :

* playbooks idempotents
* rôles Ansible séparés par responsabilité
* variables centralisées dans `inventory/group_vars/`
* aucune duplication de configuration
* mises à jour contrôlées plutôt que réécriture brutale
* validation systématique post-déploiement
* configuration NTP cohérente serveurs + clients
* HAProxy compatible FreeIPA
* suppression des erreurs de bind socket
* gestion correcte des services systemd
* healthcheck IPA intégré
* règles sudo/HBAC structurées
* séparation RBAC par groupes métiers
* support du failover IPA via LB

---

## 5. Déploiement

Déploiement depuis `idmadmin` :

```bash
cd /opt/idm-lab
ansible-playbook -i inventory/hosts.ini playbooks/site.yml
```

Déploiement par domaine :

```bash
ansible-playbook -i inventory/hosts.ini playbooks/freeipa.yml
ansible-playbook -i inventory/hosts.ini playbooks/loadbalancers.yml
ansible-playbook -i inventory/hosts.ini playbooks/clients.yml
ansible-playbook -i inventory/hosts.ini playbooks/chrony.yml
ansible-playbook -i inventory/hosts.ini playbooks/rbac.yml
```

---

## 6. Validation opérationnelle

Exemples de vérification :

```bash
ipactl status
ipa-healthcheck --output-type human
ipa host-find
ipa dnsrecord-find iriven.lab --name=_ldap._tcp
chronyc sources
systemctl status sssd
```

Validation client :

```bash
id admin
getent passwd admin
klist -k
sssctl domain-status iriven.lab
```

Validation SSH / sudo :

```bash
ssh testadmin@idmadmin.iriven.lab
sudo -l
sudo whoami
```

---

## 7. Structure du projet

```text
idm-lab/
├── inventory/
│   ├── hosts.ini
│   └── group_vars/
├── playbooks/
├── roles/
├── templates/
├── docs/
├── README.md
└── ansible.cfg
```

---

## 8. Commandes utiles

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

## 9. Limites connues

Ce projet reste un **lab avancé orienté production**.

Pour un environnement réel, il faut compléter avec :

* stratégie de backup/restauration
* supervision centralisée
* PRA / PCA
* rotation des secrets
* MFA
* centralisation des logs
* PKI durcie
* audit sudo avancé
* patch management
* segmentation réseau réelle

---

## 10. Finalité pédagogique

Ce projet permet de pratiquer :

* déploiement FreeIPA Primary / Replica
* DNS intégré
* Kerberos
* LDAP / LDAPS
* réplication
* enrollment client
* SSSD
* HAProxy + failover
* chrony / NTP maîtrisé
* sudo rules
* HBAC
* RBAC
* validation de résilience
* architecture IDM proche production

L’ensemble a été conçu avec un focus fort sur la maintenabilité, l’idempotence et les bonnes pratiques d’exploitation.
