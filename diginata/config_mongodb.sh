mongo
use production
db.createUser(
  {
    user: "Testuser",
    pwd:  "Testpasswort",
    roles: [ {role: "readWrite", db: "production" }]
  }
)
exit

cd /opt/diginata/server
sudo node seeding/seeder.js

mongo
show databases
use production
show collections
exit
