#!/bin/sh
#================================================================
# HEADER
#================================================================
#% SYNOPSIS
#+   adduser.sh
#%
#% DESCRIPTION
#%    
#%    Anhand diese Scripts können alle relevanten Linux Benutzer angelegt werden
#%    
#%    Manuelle Eingaben für die Passwörter sind allerdings notwendig. Daher ist es 
#%    sinnvoller, die Kommandos manuell auszuführen
#%
#% Voraussetzung: git_clone.sh wurde ausgeführt.
#%
#================================================================
#- IMPLEMENTATION
#-    version        adduser.sh 1.0
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
sudo addgroup via

sudo deluser --remove-home viauser
sudo deluser --remove-home viaservice

sudo adduser --ingroup via viaadmin --shell /bin/bash --gecos GECOS
sudo adduser --ingroup via viauser --shell /bin/bash --gecos GECOS
sudo adduser --ingroup via viaservice --shell /usr/sbin/nologin --no-create-home --gecos GECOS

cat /etc/passwd | grep via

sudo usermod -aG sudo viaadmin

id viaadmin
id viauser
id viaservice

echo ' '
echo 'sudo Rechte ohne Password an viaadmin vergeben'
echo ' '
echo 'dazu folgende Zeile am Ende der Datei einfügen'
echo ' viaadmin ALL=(ALL) NOPASSWD: ALL '
echo ' '
sudo visudo