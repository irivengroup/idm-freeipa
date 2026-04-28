# Lab Docker FreeIPA / Red Hat IdM sur Rocky Linux 9

## Contenu

- 1 serveur FreeIPA / IdM avec DNS intégré
- 2 clients Rocky Linux 9
- SSH accessible sur tous les conteneurs
- Configuration centralisée via le fichier `.env`

## Lancement

```bash
docker compose up -d --build
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

## Vérification

```bash
docker ps
docker logs -f ipa-server
```

## Suppression complète

```bash
docker compose down -v
```

## Remarque

Ce lab est destiné aux tests et à l’apprentissage.
Ce n’est pas une architecture de production.
