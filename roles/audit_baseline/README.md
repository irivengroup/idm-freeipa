# Role `audit_baseline`

Configures a lightweight audit baseline for the IRIVEN IDM lab.

## Responsibilities

- persistent journald logs;
- sudo command and I/O logging;
- rsyslog baseline;
- optional remote syslog forwarding;
- auditd watches for sensitive identity and SSH configuration files.

## Remote forwarding

Remote forwarding is disabled by default.

Enable with:

```yaml
audit_baseline_rsyslog_forwarding_enabled: true
audit_baseline_rsyslog_remote_host: logs.iriven.lab
audit_baseline_rsyslog_remote_port: 514
audit_baseline_rsyslog_remote_protocol: tcp
```
