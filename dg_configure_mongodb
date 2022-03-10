
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

cd /opt/diginata/api-server/server
sudo nano .env
