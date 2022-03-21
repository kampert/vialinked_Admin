#!/bin/sh
#================================================================
# HEADER
#================================================================
#% SYNOPSIS
#+    git_clone.sh
#%
#% DESCRIPTION
#%    Dieses Script klont die Github Verzeichnisse auf den Produktionsserver
#%    Kopiert werden:
#%         Client Sourcen, Server Sourcen und die Administrationswerkzeuge
#%
#================================================================
#- IMPLEMENTATION
#-    version        git_clone 0.0.1
#-    author          Andreas Kampert
#-
#================================================================
#  HISTORY
#     2022_03-01 : Andreas Kampert : Script creation
#
#================================================================
# END_OF_HEADER
#================================================================


######################################################################
# 
# github Authentifizierung benötigt einen Private/Public Key Paar. Der Public Key ist 
# bereits installiert. 
# Jetzt wird der Private Key installiert.
#
######################################################################
cd $home
cd .ssh
chmod -R 600 andreas_rsa_4096
eval `ssh-agent`
ssh-add andreas_rsa_4096


######################################################################
# 
# Klonen der Verzeichnisse.
#
######################################################################
cd $home
                                                              #
sudo rm -r git_vialinked_admin              # Die alten Dateien werden vor dem Klonen gelöscht
sudo rm -r git_vialinked                          #

echo '**************************************************'
echo '   Github Clone für Admin '

git clone git@github.com:kampert/vialinked_admin.git  git_vialinked_admin

echo '   Admin Clone finished'
echo '**************************************************'

echo '**************************************************'
echo '   Github Clone für Client/Server'

git clone git@github.com:FriedhelmKoch/viaLinked.git  git_vialinked

echo '   Client/Server Clone finished'
echo '**************************************************'

######################################################################
# 
# Für eine mögliche Wiederholung wird das git_clone.sh Kommando in das home
# Verzeichnis kopiert
#
######################################################################

cp -rf ~/git_vialinked_admin/git_clone.sh ~/git_clone.sh

