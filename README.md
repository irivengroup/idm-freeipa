# Lab Docker FreeIPA / Red Hat IdM sur Rocky Linux 9

Redhat Identity Management Lab (Environment)

## Objectif

Ce lab crée un environnement de test avec :

- 1 serveur FreeIPA / Red Hat IdM avec DNS intégré
- 2 clients Rocky Linux 9 enrôlés dans le domaine
- SSH accessible sur le serveur et les deux clients
- Configuration centralisée via `.env`

## Arborescence

```text
idm-lab/
├── .env
├── docker-compose.yml
├── README.md
├── server/
│   ├── Dockerfile
│   └── entrypoint.sh
└── client/
    ├── Dockerfile
    └── entrypoint.sh
```

## Lancement

```bash
docker compose up -d --build
```

ou 

```bash
docker compose down -v --remove-orphans
docker compose build --no-cache
docker compose up -d
```

## Vérification et Suivi des logs

```bash
docker ps
docker logs -f ipa-server
docker logs -f ipa-client1
docker logs -f ipa-client2
```

## Accès SSH

```bash
ssh root@localhost -p 2220
ssh root@localhost -p 2221
ssh root@localhost -p 2222
```

Mot de passe root par défaut :

```text
rootpass
```

## Interface Web FreeIPA

```text
https://localhost:8443
```

Identifiants :

```text
Utilisateur : admin
Mot de passe : Passw0rd123!
```


## Interface Web FreeIPA

```text
https://localhost:8443/ipa/ui/

```

Compte administrateur :

```text
admin / Passw0rd123!
```

## Tests utiles

Sur le serveur :

```bash
docker exec -it ipa-server bash
kinit admin
ipa user-find
ipa host-find
ipa dnszone-find
```

Créer un utilisateur :

```bash
ipa user-add formation --first=Formation --last=IdM --password
```

Tester depuis un client :

```bash
docker exec -it ipa-client1 bash
id formation
kinit formation
klist
```

## Nettoyage total (Suppression complète)

```bash
docker compose down -v --remove-orphans
```

## Notes

- Le port DNS du conteneur est exposé sur `5353` côté hôte afin d’éviter les conflits avec un DNS local déjà actif.
- Ce lab est destiné aux tests et à l’apprentissage. Il ne doit pas être utilisé comme architecture de production.
