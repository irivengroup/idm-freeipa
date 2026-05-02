# Monitoring baseline

[Retour à l'index](index.md)

## Objectif

Le rôle `ipa_monitoring_baseline` ajoute une supervision locale minimale, sans infrastructure externe.

Il installe :

- un script de contrôle local ;
- un service systemd ;
- un timer systemd ;
- des logs dans `/var/log/idm-monitoring/`.

## Playbook

```bash
ansible-playbook -i inventory/hosts.ini playbooks/80-configure-monitoring-baseline.yml
```

## Contrôles intégrés

### FreeIPA

- `ipactl status`
- `ipa-healthcheck`
- `ipa-replica-manage list`
- `getcert list`

### HAProxy

- service `haproxy`
- validation `haproxy -c`

### Chrony

- service `chronyd`
- `chronyc tracking`
- `chronyc sources`

### Disque

- warning à 80 %
- critical à 90 %

## Vérification

```bash
systemctl status idm-monitoring-check.timer
systemctl list-timers idm-monitoring-check.timer --no-pager
sudo systemctl start idm-monitoring-check.service
sudo journalctl -u idm-monitoring-check.service --no-pager -n 100
sudo tail -n 100 /var/log/idm-monitoring/idm-monitoring-$(date +%F).log
```

## Extensions recommandées

- rsyslog centralisé
- Prometheus Node Exporter
- HAProxy exporter
- dashboards Grafana
- alerting

[Retour à l'index](index.md)
