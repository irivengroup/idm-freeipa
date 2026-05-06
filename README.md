# IRIVEN IDM Platform  
## Enterprise Identity Management Infrastructure for Linux

Infrastructure-as-Code platform for deploying, operating, validating, and securing a production-grade **Red Hat Identity Management (IdM) / FreeIPA** environment on **Rocky Linux 10**, powered by **Ansible**.

---

## Executive Summary

**IRIVEN IDM Platform** is an enterprise-grade Identity Management infrastructure designed to deliver a robust, maintainable, and automation-first foundation for Linux identity services.

The platform provides a near-production implementation of:

- Red Hat Identity Management (IdM)
- FreeIPA
- Integrated DNS
- Kerberos
- LDAP / LDAPS
- PKI / Certificate Services
- Identity replication
- Linux client enrollment
- SSSD
- Centralized sudo policies
- HBAC enforcement
- Production-grade RBAC model
- HAProxy + Keepalived high availability
- Operational health checks
- Security baselines
- Compliance readiness
- Backup / restore readiness
- Release readiness validation
- AD Trust readiness preparation

The objective is to provide a resilient operational baseline suitable for:

- enterprise lab environments
- technical demonstrations
- architecture validation
- platform engineering
- pre-production design
- advanced IdM operational training

---

## Core Design Principles

The project is built around strict infrastructure engineering principles:

### Idempotence

Every role and playbook is designed to be safely re-executable.

### Operational Resilience

Failure domains are minimized through replication, VIP failover, health checks, and readiness validation.

### Security by Default

SSH hardening, audit baselines, RBAC, HBAC, sudo control, and operational breakglass patterns are included by design.

### Inventory as Source of Truth

Infrastructure behavior is driven by inventory and centralized variables—not ad hoc host configuration.

### Role-Based Responsibility Separation

Each Ansible role has a single responsibility with clean operational boundaries.

### Production-Grade Maintainability

The project is structured to support long-term evolution, operational ownership, and future service expansion.

---

## Target Architecture

```text
Administration Host
│
├── idmadmin
│   Bastion / Ansible Control Node / IPA Client
│
├── Site A — 192.168.1.0/24
│   ├── idmprimarya
│   │   Primary IdM + DNS + CA
│   │
│   ├── idmclient1a
│   │   Application / Linux Client
│   │
│   └── idmclient2a
│       Database / Linux Client
│
├── Site B — 192.168.1.0/24
│   ├── idmreplicab
│   │   Replica IdM + DNS
│   │
│   ├── idmclient1b
│   │   Application / Linux Client
│   │
│   └── idmclient2b
│       Database / Linux Client
│
└── High Availability Layer
    ├── idmloadbalancer1
    │   HAProxy + Keepalived
    │
    └── idmloadbalancer2
        HAProxy + Keepalived
```

Primary access endpoint:

```text
idmloadbalancer.iriven.lab
```

---

## Platform Scope

### Identity Services

- FreeIPA Primary + Replica
- Integrated DNS
- Kerberos
- LDAP / LDAPS
- PKI
- replication management

### Client Integration

- Linux enrollment
- SSSD
- SSH integration
- centralized authentication

### Access Governance

- RBAC matrix
- HBAC rules
- centralized sudo policies
- breakglass administration model
- automation identities per operational team

### High Availability

- HAProxy
- Keepalived
- VIP failover
- backend drain operations
- maintenance mode workflows

### Security Baselines

- SSH hardening
- audit baseline
- log rotation
- monitoring baseline
- release readiness validation

### Platform Validation

- health checks
- backup / restore readiness
- AD Trust readiness
- compliance readiness

---

## Infrastructure Naming Standard

| Role | Hostname | FQDN |
|---|---|---|
| Primary IdM | idmprimarya | idmprimarya.iriven.lab |
| Replica IdM | idmreplicab | idmreplicab.iriven.lab |
| Load Balancer 1 | idmloadbalancer1 | idmloadbalancer1.iriven.lab |
| Load Balancer 2 | idmloadbalancer2 | idmloadbalancer2.iriven.lab |
| Load Balancer VIP | idmloadbalancer | idmloadbalancer.iriven.lab |
| Admin Host | idmadmin | idmadmin.iriven.lab |
| Application Client A | idmclient1a | idmclient1a.iriven.lab |
| Database Client A | idmclient2a | idmclient2a.iriven.lab |
| Application Client B | idmclient1b | idmclient1b.iriven.lab |
| Database Client B | idmclient2b | idmclient2b.iriven.lab |

---

## IP Addressing Plan

| Host | IP | Purpose |
|---|---:|---|
| idmadmin | 192.168.1.50 | Admin / Bastion |
| idmprimarya | 192.168.1.51 | FreeIPA Primary |
| idmreplicab | 192.168.1.52 | FreeIPA Replica |
| idmloadbalancer1 | 192.168.1.53 | HAProxy / Keepalived |
| idmloadbalancer2 | 192.168.1.54 | HAProxy / Keepalived |
| idmloadbalancer | 192.168.1.55 | VIP |
| idmclient1a | 192.168.1.61 | Application Client |
| idmclient2a | 192.168.1.62 | Database Client |
| idmclient1b | 192.168.1.63 | Application Client |
| idmclient2b | 192.168.1.64 | Database Client |

---

## Network Standards

### Domain

```text
iriven.lab
```

### Realm

```text
IRIVEN.LAB
```

### Subnet

```text
192.168.1.0/24
```

### VIP

```text
192.168.1.55
```

---

## Project Structure

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
│
├── playbooks/
├── roles/
├── docs/
└── README.md
```

---

## Deployment

### Full Platform Deployment

```bash
ansible-playbook -i inventory/hosts.ini playbooks/site.yml
```

---

### Domain-Specific Deployment

```bash
ansible-playbook -i inventory/hosts.ini playbooks/10-install-primary.yml
ansible-playbook -i inventory/hosts.ini playbooks/20-install-replica.yml
ansible-playbook -i inventory/hosts.ini playbooks/40-configure-loadbalancers.yml
ansible-playbook -i inventory/hosts.ini playbooks/50-configure-rbac.yml
ansible-playbook -i inventory/hosts.ini playbooks/52-user-lifecycle-baseline.yml
ansible-playbook -i inventory/hosts.ini playbooks/60-healthcheck.yml
```

---

### Production Initialization

```bash
cd /opt/idm-lab

ansible-galaxy collection install -r requirements.yml

cp inventory/group_vars/all/vault.yml.example \
   inventory/group_vars/all/vault.yml

ansible-vault encrypt \
   inventory/group_vars/all/vault.yml

ansible-playbook \
   --ask-vault-pass \
   playbooks/site.yml
```

---

## Operational Validation

### Core Platform Validation

```bash
ansible -i inventory/hosts.ini idm_servers -b \
  -m shell -a 'ipactl status'

ansible -i inventory/hosts.ini idm_servers -b \
  -m shell -a 'ipa-healthcheck --output-type human || true'

ansible -i inventory/hosts.ini idm_all -b \
  -m shell -a 'chronyc sources || true'
```

---

### Identity Validation

```bash
ipa host-find
ipa dnsrecord-find iriven.lab --name=_ldap._tcp
systemctl status sssd
```

---

### Client Validation

```bash
klist -k
sssctl domain-status iriven.lab
id admin
getent passwd admin
```

---

### RBAC Validation

```bash
ipa group-find --sizelimit=0
ipa hostgroup-find --sizelimit=0
ipa sudorule-find --sizelimit=0
ipa hbacrule-find --sizelimit=0
```

---

## Enterprise Robustness Features

This platform includes:

- centralized project variables
- inventory-driven host lifecycle
- role-based architecture
- primary + replica topology validation
- resilient HAProxy configuration
- maintenance mode operations
- backend drain workflows
- release readiness checks
- backup / restore readiness
- monitoring baseline
- audit baseline
- SSH hardening
- AD Trust readiness
- future-ready host groups:
  - app_servers
  - db_servers
  - jump_hosts

---

## Known Production Extensions

For full enterprise production deployment, the following should be added:

- tested backup automation
- documented disaster recovery
- centralized monitoring stack
- centralized logging
- MFA strategy
- secrets rotation
- formal PRA / PCA
- TLS / PKI hardening
- patch lifecycle governance
- formal network segmentation
- SIEM integration
- compliance reporting

---

## Documentation

Full operational documentation:

[docs/index.md](docs/index.md)

---

## Authors

**Alfred TCHONDJO**  
Project Initiator — [IRIVEN Group](https://www.facebook.com/Tchalf)

---

## Copyright

© IRIVEN Group — All Rights Reserved
