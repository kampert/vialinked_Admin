#!/bin/sh
#================================================================
# HEADER
#================================================================
#% SYNOPSIS
#+   deploy_client.sh
#%
#% DESCRIPTION
#%    
#%    Sichert den alten Zustand des Clients und kopiert anschliessend die 
#%    Client Sourcen auf dem Server in die richtigen Verzeichnisse.
#%    Auf github liegen bereits transpilierte Sourcen, daher ist eine Transpilierung nicht 
#%    nötig.
#%    nginx wird neu gestartet
#%
#% Voraussetzung: git_clone.sh wurde ausgeführt.
#%
#================================================================
#- IMPLEMENTATION
#-    version        deploy_client.sh 1.0
#-    author          Andreas Kampert
#-
#================================================================
#  HISTORY
#     2022_03-21 : Andreas Kampert : Script creation
#
#================================================================
# END_OF_HEADER
#================================================================


######################################################################
#
# Schritt 1: Transpile client
# Dieser Schritt sollte entfallen, da Friedhelm jetzt in der Entwicklungsumgebung transpiliert  
# und das Verzeichnis httpdocs zur Verfügung stellt
# Da Friedhelm aber für diginata kein passendes .env File hat, wird hier transpiliert
#
######################################################################
cd ~/git_vialinked/client
rm .env
cp ~/git_vialinked_admin/diginata/nginx_env .env
sudo npm install webpack@5.70.0 --force       # Workaround wg Development Issue
sudo npm audit fix --force                                # Workaround wg Development Issue
sudo npm install
sudo npm run build-dev


######################################################################
#
# Schritt 2: Sichern der alten Version
# Die alte Version des Clients wird mit Datum und Zeitstempel gesichert, um 
# ein schnelles Restore möglich zu machen
#
######################################################################
datum=`date +%Y-%m-%d_%H-%M`
echo '   '
echo '**************************************************'
echo 'Alte Client Version wird gesichert nach -> /var/www/diginata.'$datum

sudo mv -v /var/www/diginata /var/www/diginata.$datum
echo '   '

######################################################################
#
# Schritt 3: Kopieren der neuen Version
#
######################################################################
echo '**************************************************'
echo 'Neue Version wird kopiert'
sudo mkdir /var/www/diginata
sudo cp -r -v ~/git_vialinked/client/www/* /var/www/diginata
echo '   '

######################################################################
#
# Schritt 4: Neustart des nginx - Server
#
######################################################################
echo '**************************************************'
echo ' Neustart nginx  '
sudo nginx -t                                  # Kontrolle der nginx - Konfiguration
sudo systemctl restart nginx
echo '   '
echo '*** Ende deploy_client.sh ***'
echo '   '



