2. Créer les sudo rules IPA

Exemple :

linux-admins => sudo ALL

'''bash
ssh iriven@192.168.1.51 '
printf "%s\n" "Str0ngAdminPassw0rd!" | kinit admin
ipa sudorule-add sudo-linux-admins
ipa sudorule-add-user sudo-linux-admins --groups=linux-admins
ipa sudorule-mod sudo-linux-admins --hostcat=all
ipa sudorule-mod sudo-linux-admins --cmdcat=all
ipa sudorule-add-option sudo-linux-admins  --sudooption='!authenticate'
ipa sudorule-show sudo-linux-admins
'







ipa sudorule-mod linux-admins-all --sudooption='!authenticate'




ssh iriven@192.168.1.51 '
printf "%s\n" "Str0ngAdminPassw0rd!" | kinit admin

# 1. créer la règle
ipa sudorule-add linux-admins-all

# 2. associer le groupe utilisateur
ipa sudorule-add-user linux-admins-all --groups=linux-admins

# 3. appliquer à tous les hôtes
ipa sudorule-mod linux-admins-all --hostcat=all

# 4. autoriser toutes les commandes sudo
ipa sudorule-mod linux-admins-all --cmdcat=all

# 5. vérification
ipa sudorule-show linux-admins-all
'







Pourquoi
Faux (ce qui a échoué)
ipa sudorule-add-host --hostcat=all
ipa sudorule-add-allow-command --cmdcat=all

car ces commandes servent à :

ajouter des hôtes spécifiques
ajouter des commandes spécifiques

et non définir la catégorie all.

Si tu veux cibler un hôte précis

Exemple :

linux-admins peut sudo seulement sur idmclient1a

alors :

ipa sudorule-add-host linux-admins-all --hosts=idmclient1a.iriven.lab

et là sudorule-add-host est correct.

Si tu veux autoriser seulement certaines commandes

Exemple :

sudo systemctl + journalctl uniquement

alors :

ipa sudocmd-add /usr/bin/systemctl
ipa sudocmd-add /usr/bin/journalctl

ipa sudorule-add-allow-command linux-admins-all --sudocmds=/usr/bin/systemctl
ipa sudorule-add-allow-command linux-admins-all --sudocmds=/usr/bin/journalctl
En production

On évite souvent :

sudo ALL

et on préfère :

sudo limité + traçable

mais pour un lab FreeIPA/HA, commencer par ALL est le bon choix.

Donc la vraie bonne commande

celle que tu dois retenir :

ipa sudorule-mod --hostcat=all
ipa sudorule-mod --cmdcat=all

pas :

ipa sudorule-add-host
ipa sudorule-add-allow-command











ssh iriven@192.168.1.51 '
printf "%s\n" "Str0ngAdminPassw0rd!" | kinit admin

ipa sudorule-mod linux-admins-all --hostcat=all
ipa sudorule-mod linux-admins-all --cmdcat=all
ipa sudorule-show linux-admins-all
'