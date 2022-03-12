############
#
# Installation von MongoDB
#
############

##### Schritt 1: Import des öffentlichen GPG Schlüssels für die Community Edition
wget -qO - https://www.mongodb.org/static/pgp/server-4.4.asc | sudo apt-key add -
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb-org-4.4.list
sudo apt update
sudo apt install -y mongodb-org

##### Schritt 2: Anlegen der List Datei
echo "deb [ arch=amd64,arm64 ] https://repo.mongodb.org/apt/ubuntu bionic/mongodb-org/4.4 multiverse" | sudo tee /etc/apt/sources.list.d/mongodb.list

##### Schritt 3: Eigentliche Installation
sudo apt update
sudo apt install -y mongodb-org

##### Schritt 4: Start des MongoDB Service

# Start des Service
sudo systemctl start mongod.service
# Automatischer Start nach dem Boot Vorgang
sudo systemctl enable mongod
# Zeige Status
sudo systemctl status mongod

echo ' *****  MongoDB Installiert ***** '
