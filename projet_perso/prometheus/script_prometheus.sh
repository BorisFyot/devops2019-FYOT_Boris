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
#Script qui automatise l'installation d'un wordpress avec la base de donnée MySQL sur une VM à part. Le script doit se#
#se lancer depuis une machine seule et via ssh. Les utilisateurs du ssh devront être crées avec les droits            #
#######################################################################################################################

##Déclaration des variables.

#Source of the node
nodesource=https://github.com/prometheus/node_exporter/releases/download/v0.17.0/node_exporter-0.17.0.linux-amd64.tar.gz
#Nom du node 
nodename=node_exporter-0.17.0.linux-amd64
#Unic name for archive
nodearchive=node_exporter.gz
#Indicator for download source
havetowget=0
#Path of the node file
cheminversnode="./$nodearchive"

#Prometheus
promsource=https://github.com/prometheus/prometheus/releases/download/v2.8.1/prometheus-2.8.1.linux-amd64.tar.gz
#Nom du node 
promname=prometheus-2.8.1.linux-amd64
#Unic name for archive
promarchive=prometheus.gz
#Path of the prom file
cheminversprom="./$promarchive"
#adresse des sources 
adresse=`pwd`

########################################################################################################################

export nodesource nodearchive havetowget cheminversnode nodename promsource promname promarchive cheminversprom adresse

#while getopts ":s:h:n:u:p: arg:" opt; do
#	case $opt in
#		s)
# Path of wordpress source or file with parameter
#			if (echo $OPTARG | grep "^http://\|^https://")
#			then
#				wpsource=$OPTARG
#			else
#				havetowget=2
#				cheminverswp=$OPTARG
#			fi
#			;;
# Host IP parameter value
#		h)
#			dbhost=$OPTARG
#			;;
# Database Name
#		n)
#			dbname=$OPTARG
#			;;
# Database user
#		u)
#			dbuser=$OPTARG
#			;;
# Database password
#		p)
#			dbpwd=$OPTARG
#			;;
#	esac
#done

# Script 1 : Node_exporter
./nodeexporter.sh
# Script 2 : Prometheus
./prometheus.sh
