# Role `ssh_hardening`

Applies production-grade SSH baseline.

## Responsibilities

- enforce controlled SSH access;
- restrict root login;
- keep GSSAPI/Kerberos support;
- define allowed IPA groups through `AllowGroups`;
- keep sshd managed and validated.

## Default posture

- PermitRootLogin: no
- PasswordAuthentication: yes (phase 1)
- GSSAPIAuthentication: yes
- AllowGroups: RBAC groups only
