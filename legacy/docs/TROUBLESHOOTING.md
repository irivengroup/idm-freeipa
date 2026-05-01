# Troubleshooting IDMCluster

## `No valid Negotiate header in server response`

Cause fréquente : modification manuelle de GSSProxy ou exécution partielle de l’install. Solution : reset complet puis relance avec la configuration native.

```powershell
docker compose down -v --remove-orphans
docker compose build --no-cache
docker compose up idmprimarya
```

Ne pas modifier :

```text
/var/lib/ipa
/var/lib/gssproxy
/etc/gssproxy/10-ipa.conf
```

## `Couldn't find an alternative telinit implementation`

Ne pas utiliser `init: true` sur les serveurs FreeIPA.

## `cgroupns_mode not allowed`

Docker Compose récent attend `cgroup: host`, pas `cgroupns_mode: host`.

## `sed: cannot rename /etc/... Device or resource busy`

`/etc/hosts` est géré par Docker. Éviter `sed -i` sur ce fichier.
