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

#Source
source="https://www.virtualbox.org/download/oracle_vbox.asc"
sourcerepo="https://download.virtualbox.org/virtualbox/rpm/el/virtualbox.repo"
adresse=`pwd`

echo "(wget -q $source -O- | rpm --import -)"
if !(wget $source)
then 
	echo "erreur download"
	exit 1
fi

if !(rpm --import oracle_vbox.asc)
then
	echo "erreur rpm"
	exit 3
fi

if !(ls /etc/yum.repo.d/)
then
	mkdir  /etc/yum.repo.d/
fi

cd  /etc/yum.repos.d/

if !(wget $sourcerepo)
then
	echo "erreur download 2"
	exit 2
fi 

#yum install

echo "perl"
yum -y install gcc make perl
echo "kernel"
yum -y install kernel-devel-3.10.0-957.10.1.el7x86_64
echo "gcc"
yum -y install gcc dkms make qt libgomp patch 
echo "kernel-headers"
yum -y install kernel-headers kernel-devel binutils glibc-headers glibc-devel font-forge
echo "virtualbox"
yum -y install VirtualBox-6.0
echo "rm"
rm oracle_vbox.asc

/sbin/rcvboxdrv setup
