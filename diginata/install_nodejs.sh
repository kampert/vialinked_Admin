############
#
# Installation von nodejs
#
############

curl -sL https://deb.nodesource.com/setup_12.x | sudo -E bash -
sudo apt install -y nodejs

sudo apt install -y npm
sudo npm install -g npm@latest
npm version

node --version
