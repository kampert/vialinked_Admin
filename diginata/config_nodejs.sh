
sudo mkdir -p /opt/diginata/api-server/server

sudo chown -R $USER:$GROUP /opt/diginata
sudo chmod -R 755 /opt/diginata

sudo scp -r root@h2911291.stratoserver.net:"/var/www/vhosts/vialinked.com/*" /opt/diginata
cd /opt/diginata
ls
sudo cp -r /opt/diginata/api-server/server/ /opt/diginata/server/
sudo cp /opt/diginata/api-server/routes.js /opt/diginata/routes.js
# sudo cp /opt/diginata/api-server/routes.js /opt/diginata/server/routes.js
cd /opt/diginata
sudo rm -r /opt/diginata/api-server

sudo chown -R $USER:$USER /opt/diginata
sudo chmod -R 755 /opt/diginata
cd /opt/diginata/api-server/server
cat package.json 

sudo rm package-lock.json
sudo rm -r node_modules
sudo npm install

