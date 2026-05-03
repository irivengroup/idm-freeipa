# Role `ssh_hardening`

Applies production-grade SSH baseline through a dedicated drop-in file.

## Configuration file

The role does not overwrite the main SSH configuration file.

It manages only:

```text
/etc/ssh/sshd_config.d/99-idm-hardening.conf
```

## Responsibilities

- restrict root login;
- keep GSSAPI/Kerberos support;
- define allowed IPA groups through `AllowGroups`;
- reduce brute-force exposure with `MaxAuthTries`;
- shorten unauthenticated login grace period;
- configure idle session keepalive limits;
- validate `sshd -t` before restart.

## Default posture

- PermitRootLogin: no
- PasswordAuthentication: yes
- GSSAPIAuthentication: yes
- MaxAuthTries: 3
- LoginGraceTime: 30
- ClientAliveInterval: 300
- ClientAliveCountMax: 2
- AllowGroups: RBAC groups only
