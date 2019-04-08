#!/bin/bash
#######################################################################################################################
#	V1 28/03/2019 : création du programme.                                                                        #
#	                                                                                                              #
#	                                                                                                              #
#	                                                                                                              #
#	                                                                                                              #
#	                                                                                                              #
#	                                                                                                              #
#######################################################################################################################

# Install mariadb if not yet installed
if !(yum list installed mariadb)
then
    yum --assumeyes install mariadb
fi
# Install mariadb-server if not yet installed
if !(yum list installed mariadb-server)
then
    yum --assumeyes install mariadb-server
fi

# Activate and start MYSQL service
if !(systemctl enable mariadb)
then
    echo "Problème lors de l'activation de mariadb"
    exit 101
fi
if !(systemctl start mariadb)
then
    echo "Problème lors du lancement de mariadb"
    exit 102
fi

# List of all the databases
RESULT=`mysql -u root --password="" -e \ "show databases;"`

# Test if already exists
while (echo "$RESULT"  | fgrep -qw "$dbname")
do
    echo "La base de données $dbname existe"
    echo "Entrez un nouveau nom (exit pour sortir):"
    read dbname
    if [ "$dbname" = "exit" ]
    then
      echo "Sortie demandée par l'utilisateur"
      exit 103
    fi
done

# Creation of the database with the correct name
`mysql -u root --password="" -e \
"CREATE DATABASE $dbname;"`

USERS=`mysql -u root --password="" -e \
"select distinct User FROM mysql.user;" | sed '1d'`
echo $USERS

while (echo "$USERS"  | fgrep -qw "$dbuser")
do
    echo "L'utilisateur $dbuser existe"
    echo "Entrez un nouveau nom (exit pour sortir):"
    read dbuser
    if [ "$dbuser" = "exit" ]
    then
      echo "Sortie demandée par l'utilisateur"
      exit 104
    fi
done
`mysql -u root --password="" -e \
"GRANT ALL PRIVILEGES on $dbname.* to '$dbuser'@'%' identified by '$dbpwd'; FLUSH PRIVILEGES;"`

# Open port 3306 on firewall
if !(firewall-cmd --zone=public --add-port=3306/tcp --permanent)
then
    echo "Problème lors de l'ouverture du port 3306"
    exit 105
fi
# Reload firewall
firewall-cmd --reload
# Save of the var in a temporary file for the host access
echo "$dbname $dbuser $dbpwd fin">/tmp/___wp_auto_install_config

