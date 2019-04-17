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
#Debut
#valorisation du user avec le premier argument.


adr_ip=$1
count=$#

#Si IP vide redemander
echo " BIENVENUE, dans l'outil de clé SSH. "
echo "-------------------------------------"
echo ""

while [ ! "$adr_ip" ]
do	
	read -p "Saisir IP  a envoyer la clé ?" adr_ip
        count=1
done

user=`users  | cut -d' ' -f 1`

ssh-keygen

ssh-copy-id -i ~/.ssh/id_rsa.pub "$user@$adr_ip"

