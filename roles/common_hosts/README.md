# Role `common_hosts`

Base configuration role for all IRIVEN lab Linux hosts.

## Responsibilities

- set the system hostname to `inventory_hostname.idm_domain`;
- maintain core IDM host entries in `/etc/hosts`;
- install baseline packages;
- enable and start `firewalld`;
- set SELinux to permissive at runtime;
- persist SELinux permissive mode in `/etc/selinux/config`.
