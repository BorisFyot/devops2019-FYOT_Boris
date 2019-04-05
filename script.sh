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
#Script qui automatise l'installation d'un wordpress avec la base de donnée MySQL sur une VM à part. Le script doit se#
#se lancer depuis une machine seule et via ssh. Les utilisateurs du ssh devront être crées avec les droits            #
#######################################################################################################################

##Déclaration des variables.
#DB name
dbname=wordpress
#DB user
dbuser=wpuser
#DB password
dbpwd=wppwd
#Adress by default
dbhost=172.16.10.5
#Source of the wordpress
wpsource=https://wordpress.org/latest.tar.gz
#Unic name for archive
wparchive=wordpress-20190328-AHXJINNPLM005.tar.gz
#Indicator for download source
havetowget=0
#Path of the wordpress file
cheminverswp="./$wparchive"

export dbname dbuser dbpwd dbhost wpsource wparchive havetowget cheminverswp

while getopts ":s:h:n:u:p: arg:" opt; do
	case $opt in
		s)
# Path of wordpress source or file with parameter
			if (echo $OPTARG | grep "^http://\|^https://")
			then
				wpsource=$OPTARG
			else
				havetowget=2
				cheminverswp=$OPTARG
			fi
			;;
# Host IP parameter value
		h)
			dbhost=$OPTARG
			;;
# Database Name
		n)
			dbname=$OPTARG
			;;
# Database user
		u)
			dbuser=$OPTARG
			;;
# Database password
		p)
			dbpwd=$OPTARG
			;;
	esac
done

#Script 1 : Mysql
ssh -t root@$dbhost dbname=$dbname dbuser=$dbuser dbpwd=$dbpwd "$(<./sql.sh)"
#Assign of the exit code in var sortie
sortie=$?

if [ $sortie -eq 0 ]
then
	recup=$(ssh -t root@$dbhost "cat /tmp/___wp_auto_install_config")
	dbname=`echo "$recup" | cut -d' ' -f 1`
	dbuser=`echo "$recup" | cut -d' ' -f 2`
	dbpwd=`echo "$recup" | cut -d' ' -f 3`
#	echo "$dbname $dbuser $dbpwd"
	ssh -t root@$dbhost "rm -f /tmp/___wp_auto_install_config"
else
	exit $sortie
fi

#Script 2 : Wordpresse
./wp.sh
