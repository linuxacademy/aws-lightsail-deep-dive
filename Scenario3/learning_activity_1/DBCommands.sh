# Connect to the DB

mongo admin --username root -p $(cat ./bitnami_application_password)   

# Create a Tasks DB

use Tasks

# Create user, and set permissions

db.createUser(
    {
        user: "tasks",
        pwd: "tasks",
        roles: [ "dbOwner" ]
    }
)