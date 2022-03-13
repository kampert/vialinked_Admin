############
#
# Aufbau des Clients
#
# Voraussetzung: git_clone.sh wurde durchgeführt.
#
############

# Schritt 1: Transpile client
cd ~/git_vialinked/client
rm .env
mv ~/git_vialinked_admin/production/nginx_env .env
sudo npm install
sudo npm run build-dev

# Schritt 2: Sichern der alten Version
datum=`date +%Y-%m-%d_%H-%M`
echo $datum
sudo mv /var/www/vialinked /var/www/vialinked.$datum

# Schritt 3: Kopieren der neuen Version
ls /var/www
sudo mv ~/git_vialinked/client/www /var/www/vialinked

# Schritt 4: Kontrolle und Neustart
ls /var/www
sudo nginx -t
sudo systemctl restart nginx

