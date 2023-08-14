# Wordpress
## Cloner un nouveau projet
Pour cloner le dossier directement avec la branche **template**:
```bash
git clone -o template ssh://git@git.canel.ch:2222/docker/wordpress.git
```
Définir un nouveau dépôt pour le projet:
```bash
git remote add origin ssh://project
```

## Commencer un projet
Pour donner des paramètres à Docker avec Docker Compose spécifique à l'hôte, il
faut utiliser le fichier **override**. Ce fichier n'est pas versionné par GIT et
n'impactera pas le dépôt. Pour créer un fichier **override**, il est possible de
copier le fichier d'exemple: 
```bash
cp docker-compose.override.yml-example docker-compose.override.yml
```
Le secret doivent se trouver dans le fichier **.env**
```bash
cp .env-example .env
```
Ou tout simplement utiliser la commande:
```bash
make config
```

## Versionner le nouveau projet
Le fichier **docker-compose.override.yml** n'est pas versionné par GIT. Il est
plus intéressant de copier les données de ce fichier vers le fichier principal 
**docker-compose.yml** qui est versionné et de garder non versionné le fichier
**override** pour une configuration spécifique à l'hôte.

Pour pousser le nouveau projet sur le dépôt:
```bash
git push -u origin master
```
