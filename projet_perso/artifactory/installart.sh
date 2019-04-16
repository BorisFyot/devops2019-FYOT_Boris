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

#artifactory
artifactsource=https://bintray.com/jfrog/artifactory-pro/download_file?file_path=org%2Fartifactory%2Fpro%2Fjfrog-artifactory-pro%2F6.9.1%2Fjfrog-artifactory-pro-6.9.1.zip
#Unic name for archive
artifactarchive=artifactory.zip
#Path of the prom file
cheminversarch="./$artifactarchive"
#adresse des sources 
adresse=`pwd`

# si dossier existe déja exit.
if (ls  /usr/local/src/artifactory)
then	
	echo "dossier artifactory existe déja merci de supprimer"
	exit 404
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
	if !(wget $artifactsource -O $artifactarchive )
	then
		echo "Problème lors du téléchargement des sources"
		exit 201
	fi
fi

# sources extraction
if !(unzip $cheminversarch)
then
	echo "Problème lors de l'extraction"
	exit 202
fi

#renommage
mv artifactory-pro-6.9.1 artifactory


#verification si user existe
if !(id artifactory)
then
	useradd artifactory 
fi

chown -R artifactory:artifactory /usr/local/src/artifactory

/usr/local/src/artifactory/bin/installService.sh

systemctl daemon-reload
systemctl enable artifactory.service
systemctl start artifactory.service

