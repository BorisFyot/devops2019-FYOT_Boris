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
echo "creation de fichier"
if !(ls ~/vagrant-centos-7)
then	
	mkdir ~/vagrant-centos-7
fi

cd ~/vagrant-centos-7
echo "vagrant init"
vagrant init centos/7
echo "vagrant up"
vagrant up