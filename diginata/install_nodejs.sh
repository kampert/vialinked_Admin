############
#
# Installation von nodejs
#
############

curl -sL https://deb.nodesource.com/setup_16.x | sudo -E bash -
sudo apt-get install aptitude
sudo apt install -y nodejs
sudo aptitude install nodejs

sudo apt install -y npm
# sudo aptitude install npm
sudo npm install -g npm@latest
npm version

node --version
