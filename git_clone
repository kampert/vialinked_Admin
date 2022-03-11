#####
##### Clone Github, transpile the client sources and move Files to the right directories
#####

echo '   Clone Github'
cd $home

rm -r git_vialinked_admin
rm -r git_vialinked

git clone git@github.com:kampert/vialinked_admin.git  git_vialinked_admin
git clone git@github.com:FriedhelmKoch/viaLinked.git  git_vialinked

echo '   Transpile client'
cd git_vialinked/client
rm .env
mv '.env(server)' .env
sudo npm install
sudo npm run build-dev
ls 

echo 'copy'
ls /var/www
sudo mv /var/www/vialinked.1 /var/www/vialinked.2
sudo mv /var/www/vialinked   /var/www/vialinked.1
sudo mv ~/git_vialinked/client/www /var/www/vialinked

sudo nginx -t
sudo systemctl restart nginx
