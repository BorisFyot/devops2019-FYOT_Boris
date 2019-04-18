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



##Début du programme 

#telechargement
if !(wget -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat-stable/jenkins.repo)
then 
	echo "erreur de récupération du source sur repo"
	exit 101
fi

#import
if !(rpm --import https://jenkins-ci.org/redhat/jenkins-ci.org.key)
then 
	echo "erreur lors de l'import"
	exit 102
fi

#install
if !(yum install jenkins)
then 
	echo "erreur lors de l'installation jenkins"
	exit 103
fi

#configuration du firewall
firewall-cmd --permanent --service=jenkins --add-port=8080/tcp
firewall-cmd --reload

#start service 
if !(sudo systemctl start jenkins)
then
	echo "erreur de démarage du service"
	exit 104
else 
	systemctl enable jenkins
fi

systemctl status jenkins
