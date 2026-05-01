[← Back to index](index.md)

Breadcrumbs: [Index](index.md) / **Runbook**

# Operational Runbook

## Daily checks

```bash
ansible-playbook --ask-vault-pass playbooks/90-validate-platform.yml
```

## Weekly checks

```bash
ansible-playbook --ask-vault-pass playbooks/60-healthcheck.yml
ipa-replica-manage list
ipa topologysegment-find domain
ipa topologysegment-find ca
```

## Password reset

```bash
ipa passwd <user>
ipa user-unlock <user>
```

## Add Linux admin

```bash
ipa group-add-member linux-admins --users=<user>
```

## Remove Linux admin

```bash
ipa group-remove-member linux-admins --users=<user>
```

## Load balancer failover test

```bash
systemctl stop keepalived
ip addr show
curl http://192.168.1.55:8404/stats
systemctl start keepalived
```

[← Back to index](index.md)
