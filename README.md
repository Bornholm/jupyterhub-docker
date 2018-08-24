# JupyterHub

Environnement "JupyterHub" dans Docker Compose dédié à la diffusion de cours interactifs.

## Principes

- Le compte "tuteur" a un répertoire `lessons` dans lequel il peut diffuser ses cours.
- Les comptes "étudiant" ont chacun un espaces personnel avec un accès en lecture seul au répertoire `lessons` du compte "tuteur".
- Les étudiants n'ont pas accès aux répertoires des autres étudiants.
- Le compte "tuteur" a accès à l'ensemble des espaces personnels des comptes "étudiant" via le répertoire `./students`.

## Méthodologie proposée

1. Le tuteur diffuse son cours dans le répertoire `lessons`.
2. Chaque étudiant copie ce cours dans son propre espace personnel afin de réaliser les exercices proposés.
3. Le tuteur peut valider/venir en aide à l'étudiant via son accès au répertoire personnel de celui ci.

## Démarrage

```bash

# Définition du compte "tuteur" et de son mot de passe
echo TUTOR_USERNAME="<nom_utilisateur>" > .env
echo TUTOR_PASSWORD="<mot_de_passe>" >> .env

# Construction de l'environnement Compose
docker-compose build

# Démarrage de JupyterHub
docker-compose up

```

Puis ouvrir son navigateur à l'adresse `http://localhost:8000` et se connecter
avec les identifiants présents dans le fichier `.env` renseignés précédemment.

Les données sont sauvegardées dans le répertoire `./data`.

## Créer un nouveau compte étudiant

```bash
docker-compose exec hub create-hub-student "<username>"
```
Un message du type `Student 'student1' created. Its password is '3iHjqPliT6'.` devrait s'afficher.

L'étudiant pourra alors s'authentifier avec ces identifiants.

