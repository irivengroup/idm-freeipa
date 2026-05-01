# AD simulé

Ce dossier est volontairement séparé. Pour une intégration AD réaliste, ajouter un DC Samba AD ou Windows Server sur un troisième subnet, puis activer côté IdM:

- `ipa-adtrust-install --add-sids`
- forward zone DNS vers le domaine AD
- trust bidirectionnel via `ipa trust-add`

Dans Docker pur, le trust AD/Kerberos fonctionne mieux sur VM que dans des conteneurs.
