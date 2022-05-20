############
#
# Konfiguration von apapche und Konfiguration des Web-Zugriffs
#
############

# Schritt 1: Firewall anpassen (überspringen) s.h. Dokumentation

# Schritt 2: Einrichten der Verzeichnisstruktur von Serverblöcken
sudo mkdir -p /var/www/diginata
sudo chown -R $USER:$GROUP /var/www/diginata
sudo chmod -R 755 /var/www/diginata

# Schritt 3: Transpilieren des Clients
cd ~/git_vialinked/client
rm .env
rm package-lock.json
rm -r httpdocs
rm README.md
rm robots.txt
cp -v ~/git_vialinked_admin/diginata/apache_env .env
# Transpilieren verlangt die Installation von npm
bash ~/git_vialinked_admin/diginata/install_nodejs.sh
sudo npm install
sudo npm install --force
sudo npm run build-dev

# Schritt 4: Bereitstellung und Definition Reverse Proxy
sudo cp -v ~/git_vialinked_admin/diginata/config_apache_diginata.com.conf /etc/apache2/sites-available/diginata.com.conf
cat /etc/apache2/sites-available/diginata.com.conf 
sudo a2ensite diginata.com.conf
sudo systemctl reload apache2
sudo apache2ctl configtest
sudo systemctl restart apache2

# Schritt 5: HTTPS Konfiguration
sudo apt install certbot python3-certbot-apache
sudo certbot --apache
sudo apachectl -t -D DUMP_VHOSTS

