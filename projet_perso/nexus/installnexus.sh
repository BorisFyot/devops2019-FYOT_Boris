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
nexussource=https://download.sonatype.com/nexus/3/latest-unix.tar.gz
#Unic name for archive
nexusarchive=nexus.gz
#Path of the prom file
cheminversarch="./$nexusarchive"
#adresse des sources 
adresse=`pwd`

# creation du dossier de stockage
if !(ls /usr/local/src)
then 
	mkdir -p /usr/local/src
fi

cd /usr/local/src

# sources download if remote file
if [ 0 -eq $havetowget ]
then
	if !(wget $nexussource -O $nexusarchive)
	then
		echo "Problème lors du téléchargement des sources"
		exit 201
	fi
fi

# sources extraction
if !(tar -xzvf $cheminversarch)
then
	echo "Problème lors de l'extraction"
	exit 202
fi

#renommage
mv nexus-3.15.2-01 nexus

#copy
if !(cp $adresse/ressource/nexus.service /etc/systemd/system/nexus.service)
then
	echo "probleme copie du fichier config"
	exit 203
fi

#modif des droits	
if !(chmod +777 /etc/systemd/system/nexus.service)
then
	echo "probleme modification droit"
	exit 204
fi
#modif des droits
if !(chmod +777 /usr/local/src/nexus)
then
	echo "probleme modification droit"
	exit 205
fi
#verification si user existe
if !(id nexus)
then
	useradd nexus 
fi

chown -R nexus:nexus /usr/local/src/nexus
chown -R nexus:nexus /usr/local/src/sonatype-work

systemctl daemon-reload
systemctl enable nexus.service
systemctl start nexus.service

