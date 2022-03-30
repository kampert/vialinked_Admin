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
#     2022_03-21: Andreas Kampert : Script creation
#     2022_03-30: Closed Beta V0.1 ausgerollt und Script aktualisiert 
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
echo 'Alte Server Version wird gesichert nach -> /opt/diginata.'$datum

sudo mv -v /opt/diginata /opt/diginata.$datum
echo '   '

######################################################################
#
# Schritt 2: Kopieren der neuen Version
#
######################################################################
echo '**************************************************'
echo 'Neue Version wird kopiert'
sudo mkdir /opt/diginata
sudo mkdir /opt/diginata/server
sudo cp -r -v ~/git_vialinked/server/*  /opt/diginata/server
sudo cp -v    ~/git_vialinked/routes.js /opt/diginata/routes.js
echo '   '

######################################################################
#
# Schritt 3: Setzen der richtigen Berechtigungen
#
######################################################################
echo '**************************************************'
echo 'Berechtigungen setzen'
# server.js als Executable markieren
cd /opt/diginata/server/src
sudo chmod +x server.js
echo '   '

echo 'Die whitelist muss eventuell geändert werden!'
cd /opt/diginata/server/src/
#sudo nano 'whitelist(demo)'

######################################################################
#
# Schritt 4: Installation
#
######################################################################
echo '**************************************************'
echo 'npm install'
# .env File korrigieren
cd /opt/diginata/server
sudo cp -v ~/git_vialinked_admin/diginata/server_env /opt/diginata/server/.env

sudo rm /opt/diginata/server/README.md
sudo rm /opt/diginata/server/docker-compose.yml

sudo npm install --no-fund
sudo npm audit fix --force 

echo ' Prüfen der mongoose-fuzzy-searching Version - required: 2.0.2'
sudo npm list                    # Check der Version von mongoose-fuzzy-searching
sudo npm uninstall mongoose-fuzzy-searching
sudo npm install mongoose-fuzzy-searching@2.0.2
sudo npm list

echo '   '

sudo chown -R viaservice:via /opt/diginata

######################################################################
#
# Schritt 5: Neustart des nodejs - Servers
#
######################################################################
echo '**************************************************'
echo ' Neustart nodejs  '

sudo sudo systemctl start diginata-service
echo '   '
echo 'Zeige, ob Prozess gestartet ist'
ps -ax | grep node

echo 'Bei Fehlersuche'
echo ' 1. sudo journalctl -u diginata-service -n 20'
echo ' 2. sudo sudo systemctl stop diginata-service'
echo ' 3. nodemon src/server.js'
echo '   '
echo '*** Ende deploy_server.sh ***'




######################################################################
#
# Schritt x: console.log
#
######################################################################
#  const { username, password } = req.body;
#    console.log (new Date(), "- authenticateUser - User:", username)

#    console.log (new Date(), "- registerUser - Username: ", username, "email:", email)
#    // Dismiss register, if email not in whitelist
