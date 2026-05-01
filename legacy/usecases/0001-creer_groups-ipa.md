1. Créer les groupes IPA

Exemple :

linux-admins
devops
readonly
platform-admins

'''bash

ssh iriven@192.168.1.51 '
printf "%s\n" "Str0ngAdminPassw0rd!" | kinit admin

ipa group-add linux-admins --desc="Linux Administrators"
ipa group-add devops --desc="DevOps Team"
ipa group-add platform-admins --desc="Platform Admins"
ipa group-add security --desc="Security Team"
ipa group-add app-admins --desc="Applications Admin Team"
ipa group-add network-admins --desc="Network Admins"
'''

ipa group-add linux-admins --desc="Linux Administrors"
ipa group-add devops --desc="DevOps Team"



ipa group-del app-admins 

auditors
readonly
app-admins