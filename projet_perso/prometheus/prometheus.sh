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


useradd --no-create-home --shell /bin/false prometheus

# creation du dossier de stockage
if !(ls /etc/prometheus/)
then 
	mkdir -p /etc/prometheus/
else 
	rm -fr /etc/prometheus/prometheus/
fi
# creation du dossier de stockage
if !(ls /var/lib/prometheus)
then 
	mkdir -p /var/lib/prometheus/
fi

cd /tmp/
# sources download if remote file
if [ 0 -eq $havetowget ]
then
	if !(wget $promsource -O $promarchive)
	then
		echo "Problème lors du téléchargement des sources"
		exit 202
	fi
fi

# sources extraction
if !(tar -xzvf $cheminversprom -C /etc/prometheus/)
then
	echo "Problème lors de l'extraction"
	exit 203
fi
#renommage
mv -f /etc/prometheus/$promname/ /etc/prometheus/prometheus/

# Open port 9090 on firewall
if !(firewall-cmd --zone=public --add-port=9090/tcp --permanent)
then
	echo "Problème lors de l'ouverture du port 9090"
	exit 204
fi
# Reload firewall
firewall-cmd --reload

#copy
#if !(cp ~/projet/prometheus/ressource/prometheus.service /etc/systemd/system/prometheus.service)
#then
#	echo "probleme copie du fichier config"
#	exit 205
#fi
#copy
if !(cp ~/projet/prometheus/ressource/prometheus.yml /etc/prometheus/prometheus/prometheus.yml)
then
	echo "probleme copie du fichier yml"
	exit 206
fi
#modif des droits	
if !(chmod +777 /etc/systemd/system/prometheus.service)
then
	echo "probleme modification droit"
	exit 207
fi

chown -R prometheus:prometheus /etc/prometheus
chown -R prometheus:prometheus /var/lib/prometheus

#systemctl

#systemctl start prometheus.service
#systemctl daemon-reload
#systemctl enable prometheus.service
#systemctl status prometheus.service

