# IDM Lab Documentation Index

Breadcrumbs: **Index**

This documentation describes the IRIVEN IDM lab architecture, addressing plan, deployment model, Ansible roles, operating procedures, validation checks, and resilience practices.

<details open>
<summary><strong>1. Architecture and design</strong></summary>

- [Architecture overview](architecture.md)
- [IP addressing plan](addressing.md)
- [DNS and naming model](dns.md)
- [High availability design](ha.md)

</details>

<details open>
<summary><strong>2. Deployment and configuration</strong></summary>

- [Inventory and variables](inventory.md)
- [Ansible roles](roles.md)
- [Playbook execution order](playbooks.md)
- [Chrony/NTP configuration](chrony.md)
- [FreeIPA primary and replica](freeipa.md)
- [Load balancers](loadbalancers.md)

</details>

<details open>
<summary><strong>3. Security and access control</strong></summary>

- [RBAC, groups, sudo, and HBAC](rbac.md)
- [Secret management with Ansible Vault](vault.md)
- [Hardening guidelines](hardening.md)

</details>

<details open>
<summary><strong>4. Operations</strong></summary>

- [Validation and health checks](validation.md)
- [Backup and restore](backup.md)
- [Troubleshooting guide](troubleshooting.md)
- [Runbook](runbook.md)

</details>

- [GitHub Actions](github-actions.md)

- [Monitoring baseline](monitoring.md)

- [CI / Linting](ci-linting.md)

- [Client enrollment and DNS management](client-enrollment.md)

- [Common hosts baseline](common-hosts.md)

- [SSH hardening](ssh-hardening.md)
