## Procédure d'installation

### Si le répertoire `/bin` n'est pas dans le Path

Pour vérifier si le répertoire `/bin` a été ajouté au Path, tapez la commande suivante dans l'invite de commande  
`where mysql`  
Si l'instruction vous affiche le chemin du répertoire du binaire `mysql`, cela veut dire que le répertoire est bien référencé par la variable `Path` sinon vous devez suivre les instructions ci-dessous.

Vous devez ajouter votre répertoire `/bin` dans le Path.

Pour accèder rapidement aux variables d'environnement, appuyez sur  
La touche Windows + La touche Pause  
Puis cliquez sur `Configuration des paramètres avancés`  
Dans l'onglet `Avancé`, cliquez sur `Variables d'environnements`  
Une nouvelle fenêtre s'affiche.

Dans cette fenêtre (dans la partie `Variables Systèmes`), éditez la variable `Path` puis ajoutez le nouveau répertoire à votre liste  
`C:\Program Files (x86)\mysql-8.0.35-winx64\bin`  
Puis cliquez sur `OK`. Pour enregistrer vos modifications.

### En cas de répertoire `/Data` absent

Dans le répertoire principal de MySQL  
`C:\Program Files (x86)\mysql-8.0.35-winx64`  
Créez un fichier `my.ini` (ce fichier contiendra la configuration de MySQL).  
Voici un exemple du contenu du fichier `my.ini`

```ini
[mysqld]
basedir="C:\\Program Files (x86)\\mysql-8.0.35-winx64"
datadir="C:\\Program Files (x86)\\mysql-8.0.35-winx64\\data"

```

### Ouvrez en mode administrateur une nouvelle invite de commande et tapez les commandes suivantes

Pour créer le répertoire `/Data`  
`mysqld --initialize-insecure`

Pour installer le service MySQL  
`mysqld --install`

Pour démarrer le service MySQL  
`net start mysql`

Première connexion à MySQL sans mot de passe  
`mysql -u root --skip-password`

Dans l'invite de commande `mysql`, tapez les 2 commandes suivantes pour créer un utilisateur `root` avec un mot de passe (pass123)

```SQL
ALTER USER 'root'@'localhost' IDENTIFIED BY 'pass123';
FLUSH PRIVILEGES;
```

Pour quitter `mysql`  
`\q`

### L'installation est maintenant complète

Pour vous connecter à l'aide de `mysql` tapez la commande  
`mysql -u root -p`  
Puis tapez votre mot de passe

Pour vous connecter à l'aide de `Workbench`  
Cliquez sur la connextion proposé  
`root@localhost:3306`  
Puis saisissez votre mot de passe
