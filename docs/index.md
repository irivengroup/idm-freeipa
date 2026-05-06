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

- [Audit baseline](audit-baseline.md)

- [Baseline integration](baseline-integration.md)

- [PKI baseline](pki-baseline.md)

- [Log forwarding](log-forwarding.md)

- [Log rotation](log-rotation.md)

- [Secrets management](secrets-management.md)

- [Restore runbook](restore-runbook.md)

- [Platform healthcheck](healthcheck.md)

- [HA failover check](ha-failover-check.md)

- [Patch management baseline](patch-management.md)

- [Disaster Recovery readiness check](disaster-recovery-check.md)

- [Compliance check](compliance-check.md)

- [OpenSCAP readiness check](oscap-readiness-check.md)

- [Release readiness check](release-readiness-check.md)

- [Inventory and host groups](inventory-groups.md)

- [RBAC reporting](rbac-reporting.md)

- [Replica topology check](replica-topology-check.md)

- [Load balancer backend drain](lb-backend-drain.md)

- [Ansible callback compatibility](ansible-callback-compatibility.md)

- [HAProxy runtime directory fix](haproxy-runtime-fix.md)

- [Maintenance mode](maintenance-mode.md)

- [User lifecycle baseline](user-lifecycle-baseline.md)

- [AD Trust readiness check](ad-trust-readiness-check.md)


- [RBAC authentication troubleshooting](rbac-authentication-troubleshooting.md)

- [Idempotence and Kerberos authentication standard](idempotence-and-kerberos-auth-standard.md)

- [IPA DNS/NTP forwarders](ipa-dns-ntp-forwarders.md)
