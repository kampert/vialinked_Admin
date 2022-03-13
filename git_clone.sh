#######################################
#
# Github Clone für Admin und Client/Server
#
#######################################

echo '**************************************************'
echo '   Github Clone für Admin und Client/Server'
echo ' '
echo '**************************************************'

cd $home

sudo rm -r git_vialinked_admin
sudo rm -r git_vialinked

echo '**************************************************'
echo '   Github Clone für Admin '
git clone git@github.com:kampert/vialinked_admin.git  git_vialinked_admin
echo '   Admin Clone finished'
echo '**************************************************'

echo '**************************************************'
echo '   Github Clone für Client/Server'
git clone git@github.com:FriedhelmKoch/viaLinked.git  git_vialinked
echo '   Client/Server Clone finished'
echo '**************************************************'

