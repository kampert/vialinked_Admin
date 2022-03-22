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
#     2022_03-22 : Transpilieren im Script, da von Friedhelm geliefertes httpsdocs fehlerhaft ist
#
#================================================================
# END_OF_HEADER
#================================================================


######################################################################
#
# Schritt 1: Transpile client
# Dieser Schritt sollte entfallen, da Friedhelm jetzt in der Entwicklungsumgebung transpiliert  
# und das Verzeichnis httpdocs zur Verfügung stellt
#
######################################################################
cd ~/git_vialinked/client
rm .env
cp -v ~/git_vialinked_admin/production/nginx_env .env
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
echo 'Alte Client Version wird gesichert nach -> /var/www/vialinked.'$datum

sudo mv -v /var/www/vialinked /var/www/vialinked.$datum
echo '   '

######################################################################
#
# Schritt 3: Kopieren der neuen Version
#
######################################################################
echo '**************************************************'
echo 'Neue Version wird kopiert'
sudo mkdir /var/www/vialinked
sudo cp -r -v ~/git_vialinked/client/www/* /var/www/vialinked
#sudo cp -r -v ~/git_vialinked/client/httpdocs/* /var/www/vialinked
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


