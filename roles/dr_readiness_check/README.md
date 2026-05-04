# Role `dr_readiness_check`

Non-destructive Disaster Recovery readiness validation for IRIVEN IDM.

## Scope

- backup presence
- manifest presence
- IPA service health
- restore-critical files
- required commands
- critical secrets
- DNS SRV records
- replication topology
- certmonger inventory

This role does not run `ipa-restore`.
