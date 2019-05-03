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

##Déclaration des variables.
#sudo yum install java-1.8.0-openjdk-devel

#Indicator for download source
havetowget=0

#Unic name for archive
jdkarchive=JDK.tar.gz
#Path of the prom file
cheminversarchjdk="./$jdkarchive"
#adresse des sources 
adresse=`pwd`

if (ls /usr/local/src/jdk/)
then
	echo "Dossier jdk existe déja"
	exit 404
fi


# creation du dossier de stockage
if !(ls /usr/local/src)
then 
	mkdir -p /usr/local/src
fi

cd /usr/local/src

# move JDK in usr/local/src
if !(cp $adresse/ressource/JDK.tar.gz $cheminversarchjdk)
then 
	echo "Problème de copie du source"
	exit 203
else
	if !(tar -xzvf $cheminversarchjdk)
	then
		echo "Problème lors de l'extraction"
		exit 203	
	fi
fi

mv jdk1.8.0_201/ jdk/ 

#copy
if !(cp $adresse/ressource/jdk.sh /etc/profile.d/jdk.sh)
then
	echo "probleme copie du jdk.sh"
	exit 206
fi

#modif des droits	
if !(chmod +x /etc/profile.d/jdk.sh)
then
	echo "probleme modification droit"
	exit 208
else
	source /etc/profile.d/jdk.sh
fi

