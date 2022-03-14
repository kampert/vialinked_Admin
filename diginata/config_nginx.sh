############
#
# Konfiguration von nginx und Konfiguration des Web-Zugriffs
#
############

# Schritt 1: Firewall anpassen (überspringen) s.h. Dokumentation

# Schritt 2: Einrichten der Verzeichnisstruktur von Serverblöcken
sudo mkdir -p /var/www/diginata
sudo chown -R $USER:$GROUP /var/www/diginata
sudo chmod -R 755 /var/www/diginata

# Transpilieren des Clients
cd ~/git_vialinked/client
rm .env
cp ~/git_vialinked_admin/diginata/nginx_env .env

# Schritt 3: Bereitstellung und Definition Reverse Proxy
sudo cp config_nginx_diginata.com.conf /etc/nginx/sites-available/diginata.com.conf
cat /etc/nginx/sites-available/diginata.com.conf 
sudo ln -s /etc/nginx/sites-available/diginata.com.conf /etc/nginx/sites-enabled/

# evtl fehlt hash_bucket
sudo nginx -t
sudo systemctl restart nginx

# Schritt 4: HTTPS Konfiguration

sudo snap install --classic certbot
sudo apt install certbot python3-certbot-nginx
sudo ln -s /snap/bin/certbot /usr/bin/certbot
sudo certbot --nginx -d diginata.com -d www.diginata.com

