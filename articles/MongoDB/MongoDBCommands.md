---
layout: default
title: MongoDB Commands
parent: MongoDB
nav_order: 2
---
# MongoDB Command Cheatsheet

## Using the MongoDB Shell

To use this. First install mongo shell. Then open command prompt and connecct to the mongodb.

## Connecting to MongoDB

| Description                              | Command                                      |
|------------------------------------------|----------------------------------------------|
| **Connect to a MongoDB instance**        | `mongosh`                                      |
| **Connect to a specific database**       | `mongo <database_name>`                      |
| **Connect to a remote MongoDB server**   | `mongo <hostname>:<port>/<database_name>`    |

## Database Operations

| Description                              | Command                                      |
|------------------------------------------|----------------------------------------------|
| **Show all databases**                   | `show dbs`                                   |
| **Use a specific database**              | `use <database_name>`                        |
| **Get the current database**             | `db`                                         |
| **Drop the current database**            | `db.dropDatabase()`                          |

## Collection Operations

| Description                              | Command                                      |
|------------------------------------------|----------------------------------------------|
| **Show all collections in the current database** | `show collections`                        |
| **Create a collection**                  | `db.createCollection("<collection_name>")`   |
| **Drop a collection**                    | `db.<collection_name>.drop()`                |

## Document Operations

| Description                              | Command                                      |
|------------------------------------------|----------------------------------------------|
| **Insert a document**                    | `db.<collection_name>.insertOne({<field1>: <value1>, <field2>: <value2>})` |
| **Insert multiple documents**            | `db.<collection_name>.insertMany([{<field1>: <value1>, <field2>: <value2>}, {<field1>: <value1>, <field2>: <value2>}])` |
| **Find all documents in a collection**   | `db.<collection_name>.find()`                |
| **Find documents with a query**          | `db.<collection_name>.find({<field>: <value>})` |
| **Find one document**                    | `db.<collection_name>.findOne({<field>: <value>})` |
| **Find the first document in a collection** | `db.<collection_name>.findOne()`             |
| **Find a document by ID**                | `db.<collection_name>.findOne({_id: ObjectId("<id>")})` |
| **Update a document**                    | `db.<collection_name>.updateOne({<query_field>: <query_value>}, {$set: {<field>: <value>}})` |
| **Update multiple documents**            | `db.<collection_name>.updateMany({<query_field>: <query_value>}, {$set: {<field>: <value>}})` |
| **Replace a document**                   | `db.<collection_name>.replaceOne({<query_field>: <query_value>}, {<new_document>})` |
| **Delete one document**                  | `db.<collection_name>.deleteOne({<field>: <value>})` |
| **Delete multiple documents**            | `db.<collection_name>.deleteMany({<field>: <value>})` |
| **Count documents in a collection**      | `db.<collection_name>.count()`               |

## Querying MongoDB Collections

| Description                              | Command                                      |
|------------------------------------------|----------------------------------------------|
| **Find a limited number of results**     | `db.<collection_name>.find().limit(<number>)` |
| **Find documents by a field**            | `db.<collection_name>.find({"<field>": "<value>"}).count()` |
| **Query documents by numeric ranges**    | `db.<collection_name>.find({<field>: {$gt: <number>}})`  |
|                                          | `db.<collection_name>.find({<field>: <number>})`        |
|                                          | `db.<collection_name>.find({<field>: {$ne: <number>}})` |
| **Sort results by a field**              | `db.<collection_name>.find().sort({<field>: 1})` (ascending) |
|                                          | `db.<collection_name>.find().sort({<field>: -1})` (descending) |

## Indexing

| Description                              | Command                                      |
|------------------------------------------|----------------------------------------------|
| **Create an index on a field**           | `db.<collection_name>.createIndex({<field>: 1})`  |
| **Create a unique index**                | `db.<collection_name>.createIndex({<field>: 1}, {unique: true})` |
| **List all indexes on a collection**     | `db.<collection_name>.getIndexes()`          |
| **Drop an index**                        | `db.<collection_name>.dropIndex("<index_name>")` |

## Aggregation

| Description                              | Command                                      |
|------------------------------------------|----------------------------------------------|
| **Aggregation framework**                | `db.<collection_name>.aggregate([ { $match: { <field>: <value> } }, { $group: { _id: "$<group_field>", total: { $sum: "$<sum_field>" } } } ])` |

## Backup and Restore

| Description                              | Command                                      |
|------------------------------------------|----------------------------------------------|
| **Backup a database**                    | `mongodump --db <database_name> --out <backup_directory>` |
| **Restore a database**                   | `mongorestore --db <database_name> <backup_directory>/<database_name>` |

## User Management

| Description                              | Command                                      |
|------------------------------------------|----------------------------------------------|
| **Create a new user**                    | `db.createUser({ user: "<username>", pwd: "<password>", roles: [ { role: "<role>", db: "<database>" } ] })` |
| **Show users**                           | `show users`                                 |
| **Drop a user**                          | `db.dropUser("<username>")`                  |

## Server Administration

| Description                              | Command                                      |
|------------------------------------------|----------------------------------------------|
| **Server status**                        | `db.serverStatus()`                          |
| **Database statistics**                  | `db.stats()`                                 |
| **Collection statistics**                | `db.<collection_name>.stats()`               |
| **Current operations**                   | `db.currentOp()`                             |
| **Kill an operation**                    | `db.killOp(<operation_id>)`                  |
