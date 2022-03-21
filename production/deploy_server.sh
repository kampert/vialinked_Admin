sudo cp -r /home/viaadmin/git_vialinked/server/* /var/www/vhosts/vialinked.com/api-server/server
sudo cp /home/viaadmin/git_vialinked/routes.js /var/www/vhosts/vialinked.com/routes.js
sudo cp /home/viaadmin/git_vialinked/routes.js /var/www/vhosts/vialinked.com/api-server/routes.js
# server.js als Executable markieren
cd /var/www/vhosts/vialinked.com/api-server/server/src
sudo chmod +x server.js
# .env File korrigieren
cd /var/www/vhosts/vialinked.com/api-server/server
sudo cp /home/viaadmin/git_vialinked_admin/production/server_env /var/www/vhosts/vialinked.com/api-server/server/.env
#
sudo npm install
