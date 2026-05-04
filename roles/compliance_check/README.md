# Role `compliance_check`

Non-destructive compliance check baseline for the IRIVEN IDM platform.

## Scope

- SSH hardening
- SELinux runtime mode
- firewalld
- chrony
- rsyslog
- audit baseline files
- journald persistence baseline
- logrotate policy
- backup timer on primary
- PKI timer on IDM servers
- HAProxy status on load balancers
- FreeIPA service status on IDM servers

Reports are written under `/var/log/idm-compliance/`.
