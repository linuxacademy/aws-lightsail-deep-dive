# Connect to MongoDB
mongo admin --username root -p $(cat ./bitnami_application_password)
# Create a 'tasks' database
use tasks
# Create a Database user called tasks, with a password taskstasks and give it dbOwner rights
db.createUser(
    {
        user: "tasks",
        pwd: "tasks",
        roles: [ "dbOwner" ]
    }
)