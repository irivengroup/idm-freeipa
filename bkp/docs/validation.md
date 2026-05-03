[← Back to index](index.md)

Breadcrumbs: [Index](index.md) / **Validation**

# Validation and Health Checks

## Full validation playbook

```bash
ansible-playbook --ask-vault-pass playbooks/90-validate-platform.yml
```

## Manual checks

```bash
ipactl status
ipa-healthcheck --output-type human
chronyc sources
timedatectl
sssctl domain-status iriven.lab
curl http://192.168.1.55:8404/stats
```

## Authentication test

```bash
kdestroy
kinit admin
ipa user-find admin
```

## SSH and sudo test

```bash
ssh testadmin@idmadmin.iriven.lab
sudo -l
sudo whoami
```

[← Back to index](index.md)
