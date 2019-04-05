Projet 1 : Wordpress
Script qui automatise l'installation d'un wordpress avec la base de données MySQL sur une VM à part. Le script doit se lancer depuis une machine seule et via ssh. Les utilisateurs du ssh devront être crées avec les droits.

Guide d’installation : 
Placé les documents suivant dans un même dossier.
-	script.sh
-	sql.sh
-	wp.sh
Lancement :
Le lancement du script est paramétrable et se lance à partir du script.sh.
Par défauts les valeurs sont les suivantes :
-	-n : dbname=wordpress
-	-u : dbuser=wpuser 
-	-p : dbpwd=wppwd
-	-h : dbhost=172.16.10.5
-	-s : wpsource=https://wordpress.org/latest.tar.gz

Pour le lancement sans paramètre : PATH/script.sh 
Pour le lancement avec paramètre : PATH/script.sh -h 192.168.10.2
