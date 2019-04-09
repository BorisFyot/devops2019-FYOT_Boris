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


#Indicator for download source
havetowget=0

#Prometheus
mavensource=http://mirrors.standaloneinstaller.com/apache/maven/maven-3/3.6.0/binaries/apache-maven-3.6.0-bin.tar.gz
#Unic name for archive
mavenarchive=maven.gz
#Path of the prom file
cheminversarch="./$mavenarchive"
#adresse des sources 
adresse=/root/tpgit/projet_sys/projet_perso/maven

# Install java if not yet installed
if !(yum list installed java-1.8.0-openjdk-devel)
then
    yum --assumeyes install java-1.8.0-openjdk-devel
fi

# creation du dossier de stockage
if !(ls /usr/local/src)
then 
	mkdir -p /usr/local/src
fi

cd /usr/local/src

# sources download if remote file
if [ 0 -eq $havetowget ]
then
	if !(wget $mavensource -O $mavenarchive)
	then
		echo "Problème lors du téléchargement des sources"
		exit 202
	fi
fi

# sources extraction
if !(tar -xzvf $cheminversarch)
then
	echo "Problème lors de l'extraction"
	exit 203
fi

#renommage
mv apache-maven-3.6.0/ apache-maven/ 

#copy
if !(cp $adresse/ressource/maven.sh /etc/profile.d/maven.sh)
then
	echo "probleme copie du maven.sh"
	exit 204
fi

#modif des droits	
if !(chmod +x /etc/profile.d/maven.sh)
then
	echo "probleme modification droit"
	exit 205
else
	source /etc/profile.d/maven.sh
fi



