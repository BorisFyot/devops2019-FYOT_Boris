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
jdklink=https://download.java.net/java/GA/jdk12.0.1/69cfe15208a647278a19ef0990eea691/12/GPL/openjdk-12.0.1_linux-x64_bin.tar.gz
#Path of the prom file
cheminversarchjdk="./$jdkarchive"
#adresse des sources 
adresse=`pwd`



# move JDK in usr/local/src
if !(curl -O $jdklink)
then 
	echo "Problème de telechargement"
	exit 203
else
	if !(tar xvf openjdk-12.0.1_linux-x64_bin.tar.gz)
	then
		echo "Problème lors de l'extraction"
		exit 203	
	fi
fi

mv jdk-12.0.1 /opt/

#copy
if !(cp $adresse/ressource/jdk12.sh /etc/profile.d/jdk12.sh)
then
	echo "probleme copie du jdk.sh"
	exit 206
fi

#modif des droits	
if !(chmod +x /etc/profile.d/jdk12.sh)
then
	echo "probleme modification droit"
	exit 208
else
	source /etc/profile.d/jdk12.sh
fi

rm openjdk-12.0.1_linux-x64_bin.tar.gz