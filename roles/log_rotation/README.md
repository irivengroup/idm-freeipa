# Role `log_rotation`

Configures logrotate policies for IRIVEN IDM PLATFORM operational logs.

## Scope

- centralized rsyslog logs under `/var/log/remote/*/*.log`;
- sudo audit log `/var/log/sudo.log`;
- monitoring logs `/var/log/idm-monitoring/*.log`;
- PKI baseline logs `/var/log/idm-pki-baseline/*.log`;
- backup logs `/var/log/ipa-backup/*.log`.
