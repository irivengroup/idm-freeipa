3. Créer les HBAC rules

Sans ça, l’auth SSH devient vite incohérente.

Exemple :

linux-admins autorisés partout
ssh iriven@192.168.1.51 '
printf "%s\n" "Str0ngAdminPassw0rd!" | kinit admin

ipa hbacrule-add allow-linux-admins
ipa hbacrule-add-user allow-linux-admins --groups=linux-admins
ipa hbacrule-mod allow-linux-admins --hostcat=all
ipa hbacrule-add-service allow-linux-admins --hbacsvcs=sshd
ipa hbacrule-enable allow-linux-admins
'

