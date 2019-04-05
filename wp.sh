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



# Install httpd if not yet installed
if !(yum list installed httpd)
then
    yum --assumeyes install httpd
fi
# Install php if not yet installed
if !(yum list installed php)
then
    yum --assumeyes install php
fi
# Install * if not yet installed
if !(yum list installed php-mysql) 
then
    yum --assumeyes install php-mysql
fi
# Install * if not yet installed
if !(yum list installed php-gd)
then
    yum --assumeyes install php-gd
fi
# active et lance le service de MYSQL
if !(systemctl enable httpd)
then
    echo "Problème lors de l'activation de httpd"
    exit 201
fi
if !(systemctl start httpd)
then
    echo "Problème lors du lancement de httpd"
    exit 202
fi

# sources download if remote file
if [ 0 -eq $havetowget ]
then
	if !(wget $wpsource -O $wparchive)
	then
		echo "Problème lors du téléchargement des sources"
		exit 203
	fi
fi
# sources extraction
if !(tar -xvzf $cheminverswp -C /var/www/html)
then
	echo "Problème lors de l'extraction"
	exit 204
fi

#Modify configuration file with parameter of the install
if !(cat /var/www/html/wordpress/wp-config-sample.php | sed -e "s/.*DB\_NAME.*,[^\)]*/define( 'DB_NAME', '$dbname'/" | sed -e "s/.*DB\_USER.*,[^\)]*/define( 'DB_USER', '$dbuser'/" | sed -e "s/.*DB\_PASSWORD.*,[^\)]*/define( 'DB_PASSWORD', '$dbpwd'/" | sed -e "s/.*DB\_HOST.*,[^\)]*/define( 'DB_HOST', '$dbhost'/" >/var/www/html/wordpress/wp-config.php)
then
	echo "Fichier de parametrage erroné"
	exit 205
fi

#Change Owner
if !(chown -R apache: /var/www/html/wordpress)
then
	echo "Transfert de droit erreur"
	exit 206
fi

#cat /var/www/html/wordpress/wp-config-sample.php >/var/www/html/wordpress/#wp-config.php

#Configuration du network pour le fonctionement de wordpress
if !(setsebool -P httpd_can_network_connect 1)
then
	echo "erreur configuration 207"
	exit 207
fi

#Configuration du network pour le fonctionement de wordpress
if !(setsebool -P httpd_can_network_connect_db 1)
then
	echo "erreur configuration 208"
	exit 208
fi

#Configuration du network pour le fonctionement de wordpress
if !(semanage fcontext -a -t httpd_sys_rw_content_t 'wordpress')
then
	echo "erreur configuration 208"
	exit 208
fi

#modification droit
if !(restorecon -v '/var/www/html/wordpress')
then
	echo "erreur configuration 208"
	exit 209
fi
