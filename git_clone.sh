#####
##### Clone Github, transpile the client sources and move Files to the right directories
#####

echo '   Clone Github'
cd $home

rm -r git_vialinked_admin
rm -r git_vialinked

git clone git@github.com:kampert/vialinked_admin.git  git_vialinked_admin
git clone git@github.com:FriedhelmKoch/viaLinked.git  git_vialinke