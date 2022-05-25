############
#
# Konfiguration von nginx und Konfiguration des Web-Zugriffs
#
############

# Schritt 1: Firewall anpassen (überspringen) s.h. Dokumentation

# Schritt 2: Einrichten der Verzeichnisstruktur von Serverblöcken
sudo mkdir -p /var/www/vialinked
sudo chown -R $USER:$GROUP /var/www/vialinked
sudo chmod -R 755 /var/www/vialinked

# Schritt 3: Bereitstellung und Definition Reverse Proxy
sudo cp config_nginx_vialinked.com.conf /etc/nginx/sites-available/vialinked.com.conf
cat /etc/nginx/sites-available/vialinked.com.conf 
sudo ln -s /etc/nginx/sites-available/vialinked.com.conf /etc/nginx/sites-vialinked/

# evtl fehlt hash_bucket
sudo nginx -t
sudo systemctl restart nginx

# Schritt 4: HTTPS Konfiguration

sudo snap install --classic certbot
sudo apt install certbot python3-certbot-nginx
sudo ln -s /snap/bin/certbot /usr/bin/certbot
sudo certbot --nginx -d vialinked.com -d www.vialinked.com

