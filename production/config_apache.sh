
############
#
# Konfiguration von apapche und Konfiguration des Web-Zugriffs
#
############

######################################################################
#
# Schritt 1: Firewall anpassen (überspringen) s.h. Dokumentation
#
######################################################################
echo '   '
echo '**************************************************'
echo '  '

######################################################################
#
# Schritt 2: Einrichten der Verzeichnisstruktur von Serverblöcken
#
######################################################################
echo '   '
echo '**************************************************'
echo 'Einrichten der Verzeichnisstruktur von Serverblöcken'
sudo mkdir -p /var/www/diginata
sudo chown -R $USER:$GROUP /var/www/diginata
sudo chmod -R 755 /var/www/diginata
echo '   '

######################################################################
#
# Schritt 3: Definition der virtuellen Hosts 
#
######################################################################
echo '   '
echo '**************************************************'
echo 'Definition der virtuellen Hosts '
sudo cp -v  ~/git_vialinked_admin/diginata/config_apache_diginata.com-1.conf /etc/apache2/sites-available/config_apache_diginata.com.conf
sudo cat /etc/apache2/sites-available/config_apache_diginata.com.conf 
sudo a2ensite diginata.com.conf
sudo systemctl reload apache2
sudo apache2ctl configtest
sudo systemctl restart apache2
echo '   '

######################################################################
#
# Schritt 4: HTTPS Konfiguration
#
######################################################################
echo '   '
echo '**************************************************'
echo 'HTTPS Konfiguration '
sudo apt install certbot python3-certbot-apache
sudo certbot --apache
sudo apachectl -t -D DUMP_VHOSTS
echo '   '

######################################################################
#
# Schritt 5: Reverse Proxy Konfiguration
#
######################################################################
echo '   '
echo '**************************************************'
echo 'Reverse Proxy Konfiguration '
sudo a2enmod proxy
sudo a2enmod proxy_http
sudo cp -v  ~/git_vialinked_admin/diginata/config_apache_diginata.com-2.conf /etc/apache2/sites-available/config_apache_diginata.com.conf
sudo cp -v  ~/git_vialinked_admin/diginata/config_apache_diginata.com-le-ssl.conf /etc/apache2/sites-available/config_apache_diginata.com-le-ssl.conf
sudo systemctl reload apache2
sudo apache2ctl configtest
sudo systemctl restart apache2
echo '   '


