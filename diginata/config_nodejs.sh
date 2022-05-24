
sudo mkdir -p /opt/diginata/server

sudo chown -R $USER:$GROUP /opt/diginata
sudo chmod -R 755 /opt/diginata

cd /opt/diginata
ls
cd /opt/diginata/server
sudo npm init --yes

sudo cp -r -v ~/git_vialinked/server/*  /opt/diginata/server
sudo cp -v    ~/git_vialinked/routes.js /opt/diginata/routes.js

cd /opt/diginata/server/src
sudo chmod +x server.js





sudo chown -R viaservice:via /opt/diginata
sudo chmod -R 755 /opt/diginata

cd /opt/diginata/server
cat package.json 

sudo rm package-lock.json
sudo rm -r node_modules
sudo npm install

