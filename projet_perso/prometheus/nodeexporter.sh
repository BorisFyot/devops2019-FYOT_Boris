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

cd /tmp/
# sources download if remote file
if [ 0 -eq $havetowget ]
then
	if !(wget $nodesource -O $nodearchive)
	then
		echo "Problème lors du téléchargement des sources"
		exit 103
	fi
fi
# creation du dossier de stockage
if !(ls /etc/Prometheus/)
then 
	mkdir -p /etc/prometheus/
fi
# sources extraction
if !(tar -xzvf $cheminversnode -C /etc/prometheus/)
then
	echo "Problème lors de l'extraction"
	exit 104
fi
#renommage
mv /etc/prometheus/$nodename/ /etc/prometheus/node_exporter/


# Open port 3306 on firewall
if !(firewall-cmd --zone=public --add-port=9100/tcp --permanent)
then
	echo "Problème lors de l'ouverture du port 9100"
	exit 106
fi
# Reload firewall
firewall-cmd --reload

#copy
if !(cp $adresse/ressource/node_exporter.service /etc/systemd/system/node_exporter.service)
then
        echo $adresse/ressource/node_exporter.service
	echo "probleme copie du fichier config"
	exit 107
fi
#modif des droits	
if !(chmod +777 /etc/systemd/system/node_exporter.service)
then
	echo "probleme modification droit"
	exit 108
fi
#systemctl
systemctl daemon-reload
systemctl start node_exporter.service
systemctl enable node_exporter.service
systemctl status node_exporter.service

