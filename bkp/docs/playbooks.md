[← Back to index](index.md)

Breadcrumbs: [Index](index.md) / **Playbooks**

# Playbook Execution Order

Recommended full deployment:

```bash
ansible-playbook --ask-vault-pass playbooks/site.yml
```

Step-by-step execution:

```bash
ansible-playbook --ask-vault-pass playbooks/00-bootstrap-common.yml
ansible-playbook --ask-vault-pass playbooks/05-configure-chrony-servers.yml
ansible-playbook --ask-vault-pass playbooks/10-install-primary.yml
ansible-playbook --ask-vault-pass playbooks/20-install-replica.yml
ansible-playbook --ask-vault-pass playbooks/25-configure-dns-ntp-records.yml
ansible-playbook --ask-vault-pass playbooks/40-configure-loadbalancers.yml
ansible-playbook --ask-vault-pass playbooks/06-configure-chrony-clients.yml
ansible-playbook --ask-vault-pass playbooks/30-enroll-clients.yml
ansible-playbook --ask-vault-pass playbooks/50-configure-rbac.yml
ansible-playbook --ask-vault-pass playbooks/60-healthcheck.yml
ansible-playbook --ask-vault-pass playbooks/90-validate-platform.yml
```

## Why this order matters

1. Baseline hostnames and local resolution reduce bootstrap failures.
2. Chrony server configuration stabilizes Kerberos-sensitive operations.
3. Primary must exist before replica.
4. DNS SRV records support service discovery.
5. Load balancers expose stable service endpoints.
6. Clients are enrolled after the platform is reachable.
7. RBAC/HBAC policies are applied after identity services exist.
8. Healthcheck and validation close the loop.

[← Back to index](index.md)
