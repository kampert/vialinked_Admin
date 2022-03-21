#!/bin/sh
#================================================================
# HEADER
#================================================================
#% SYNOPSIS
#+   deploy_server.sh
#%
#% DESCRIPTION
#%    
#%    Sichert den alten Zustand des Servers und kopiert anschliessend die 
#%    Server Sourcen auf dem Server in die richtigen Verzeichnisse.
#%    Zusätzlich ist ein npm install notwendig. 
#%    
#%    nodejs wird neu geladen und gestartet
#%
#% Voraussetzung: git_clone.sh wurde ausgeführt.
#%
#================================================================
#- IMPLEMENTATION
#-    version        deploy_server.sh 1.0
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
# Schritt 1: Sichern der alten Version
# Die alte Version des Servers wird mit Datum und Zeitstempel gesichert, um 
# ein schnelles Restore möglich zu machen
#
######################################################################
datum=`date +%Y-%m-%d_%H-%M`
echo '   '
echo '**************************************************'
echo 'Alte Server Version wird gesichert nach -> /opt/vialinked.'$datum

# sudo mv -v /opt/vialinked /opt/vialinked.$datum
sudo mv -v /var/www/vhosts/vialinked.com/api-server /var/www/vhosts/vialinked.com/api-server.$datum
echo '   '

######################################################################
#
# Schritt 2: Kopieren der neuen Version
#
######################################################################
echo '**************************************************'
echo 'Neue Version wird kopiert'
sudo mkdir /var/www/vhosts/vialinked.com/api-server
sudo mkdir /var/www/vhosts/vialinked.com/api-server/server
# sudo mkdir /opt/vialinked
sudo cp -r -v ~/git_vialinked/server/*  /var/www/vhosts/vialinked.com/api-server/server
sudo cp -v    ~/git_vialinked/routes.js /var/www/vhosts/vialinked.com/routes.js
sudo cp -v    ~/git_vialinked/routes.js /var/www/vhosts/vialinked.com/api-server/routes.js
echo '   '

######################################################################
#
# Schritt 3: Setzen der richtigen Berechtigungen
#
######################################################################
echo '**************************************************'
echo 'Berechtigungen setzen'
# server.js als Executable markieren
cd /var/www/vhosts/vialinked.com/api-server/server/src
sudo chmod +x server.js
echo '   '

######################################################################
#
# Schritt 4: Installation
#
######################################################################
echo '**************************************************'
echo 'npm install'
# .env File korrigieren
cd /var/www/vhosts/vialinked.com/api-server/server
sudo cp -v ~/git_vialinked_admin/production/server_env /var/www/vhosts/vialinked.com/api-server/server/.env
#
sudo rm /var/www/vhosts/vialinked.com/api-server/server/package-lock.json
sudo rm /var/www/vhosts/vialinked.com/api-server/server/README.md
sudo rm /var/www/vhosts/vialinked.com/api-server/server/docker-compose.yml
#
sudo npm install
echo '   '

######################################################################
#
# Schritt 5: Neustart des nodejs - Servers
#
######################################################################
echo '**************************************************'
echo ' Neustart nodejs  '

sudo sudo systemctl start vialinked-service
echo '   '
echo 'Zeige, ob Prozess gestartet ist'
ps -ax | grep node

echo 'Bei Fehlersuche'
echo ' 1. sudo journalctl -u vialinked-service -n 20'
echo ' 2. sudo sudo systemctl stop vialinked-service'
echo ' 3. nodemon src/server.js'
echo '   '
echo '*** Ende deploy_server.sh ***'
echo '   '