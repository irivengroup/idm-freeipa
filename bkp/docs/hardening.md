[← Back to index](index.md)

Breadcrumbs: [Index](index.md) / **Hardening**

# Hardening Guidelines

## Account usage

- Do not use `admin` as a daily account.
- Keep `admin` as breakglass or controlled platform administration.
- Use named accounts and group-based delegation.

## SSH

- Restrict SSH access with HBAC.
- Prefer SSH keys once bootstrap is complete.
- Keep password authentication only if business policy requires it.

## Sudo

- Avoid global `!authenticate` in production.
- Prefer command-specific sudo rules.
- Log sudo activity centrally.

## Time

- Keep all IPA servers and clients synchronized.
- Monitor Chrony drift.

## Certificates

- Monitor CA and host certificate expiration.
- Run `ipa-healthcheck` regularly.

[← Back to index](index.md)
