# Log forwarding

[Retour à l'index](index.md)

Architecture:
all hosts -> idmadmin:/var/log/remote/<hostname>/

Playbook:
ansible-playbook -i inventory/hosts.ini playbooks/86-configure-log-forwarding.yml

[Retour à l'index](index.md)
