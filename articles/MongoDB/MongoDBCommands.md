---
layout: default
title: MongoDB Commands
parent: MongoDB
nav_order: 2
---
- [MongoDB Command Cheatsheet](#mongodb-command-cheatsheet)
  - [Connecting to MongoDB](#connecting-to-mongodb)
  - [Database Operations](#database-operations)
  - [Collection Operations](#collection-operations)
  - [Document Operations](#document-operations)
  - [Indexing](#indexing)
  - [Aggregation](#aggregation)
  - [Backup and Restore](#backup-and-restore)
  - [User Management](#user-management)
  - [Server Administration](#server-administration)


### MongoDB Command Cheatsheet

#### Connecting to MongoDB
```sh
# Connect to a MongoDB instance
mongo

# Connect to a specific database
mongo <database_name>

# Connect to a remote MongoDB server
mongo <hostname>:<port>/<database_name>
```

#### Database Operations
```sh
# Show all databases
show dbs

# Use a specific database (creates it if it doesn't exist)
use <database_name>

# Get the current database
db

# Drop the current database
db.dropDatabase()
```

#### Collection Operations
```sh
# Show all collections in the current database
show collections

# Create a collection
db.createCollection("<collection_name>")

# Drop a collection
db.<collection_name>.drop()
```

#### Document Operations
```sh
# Insert a document
db.<collection_name>.insertOne({<field1>: <value1>, <field2>: <value2>})

# Insert multiple documents
db.<collection_name>.insertMany([{<field1>: <value1>, <field2>: <value2>}, {<field1>: <value1>, <field2>: <value2>}])

# Find all documents in a collection
db.<collection_name>.find()

# Find documents with a query
db.<collection_name>.find({<field>: <value>})

# Find one document
db.<collection_name>.findOne({<field>: <value>})

# Update a document
db.<collection_name>.updateOne({<query_field>: <query_value>}, {$set: {<field>: <value>}})

# Update multiple documents
db.<collection_name>.updateMany({<query_field>: <query_value>}, {$set: {<field>: <value>}})

# Replace a document
db.<collection_name>.replaceOne({<query_field>: <query_value>}, {<new_document>})

# Delete one document
db.<collection_name>.deleteOne({<field>: <value>})

# Delete multiple documents
db.<collection_name>.deleteMany({<field>: <value>})
```

#### Indexing
```sh
# Create an index on a field
db.<collection_name>.createIndex({<field>: 1})  # 1 for ascending, -1 for descending

# List all indexes on a collection
db.<collection_name>.getIndexes()

# Drop an index
db.<collection_name>.dropIndex("<index_name>")
```

#### Aggregation
```sh
# Aggregation framework
db.<collection_name>.aggregate([
    { $match: { <field>: <value> } },
    { $group: { _id: "$<group_field>", total: { $sum: "$<sum_field>" } } }
])
```

#### Backup and Restore
```sh
# Backup a database
mongodump --db <database_name> --out <backup_directory>

# Restore a database
mongorestore --db <database_name> <backup_directory>/<database_name>
```

#### User Management
```sh
# Create a new user
db.createUser({
  user: "<username>",
  pwd: "<password>",
  roles: [ { role: "<role>", db: "<database>" } ]
})

# Show users
show users

# Drop a user
db.dropUser("<username>")
```

#### Server Administration
```sh
# Server status
db.serverStatus()

# Database statistics
db.stats()

# Collection statistics
db.<collection_name>.stats()

# Current operations
db.currentOp()

# Kill an operation
db.killOp(<operation_id>)
```