---
layout: default
title: Spark-SQL
parent: Languages
nav_order: 3
---

# Some essential spark-sql commands

| **Command**               | **Description**                                                                              | **Example**                                |
|---------------------------|----------------------------------------------------------------------------------------------|--------------------------------------------|
| `SET -v`                  | Shows all Spark SQL settings.                                                                | `SET -v;`                                  |
| `SHOW DATABASES`          | Lists all databases.                                                                         | `SHOW DATABASES;`                          |
| `CREATE DATABASE`         | Creates a new database.                                                                      | `CREATE DATABASE db_name;`                 |
| `DROP DATABASE`           | Drops an existing database.                                                                  | `DROP DATABASE db_name;`                   |
| `USE`                     | Sets the current database.                                                                   | `USE db_name;`                             |
| `SHOW TABLES`             | Lists all tables in the current database.                                                    | `SHOW TABLES;`                             |
| `DESCRIBE TABLE`          | Provides the schema of a table.                                                              | `DESCRIBE TABLE table_name;`               |
| `DESCRIBE EXTENDED`       | Provides detailed information about a table, including metadata.                             | `DESCRIBE EXTENDED table_name;`            |
| `CREATE TABLE`            | Creates a new table.                                                                         | `CREATE TABLE table_name (col1 INT, ...);` |
| `CREATE EXTERNAL TABLE`   | Creates an external table.                                                                   | `CREATE EXTERNAL TABLE table_name ...;`    |
| `DROP TABLE`              | Drops an existing table.                                                                     | `DROP TABLE table_name;`                   |
| `INSERT INTO`             | Inserts data into a table.                                                                   | `INSERT INTO table_name VALUES (...);`     |
| `SELECT`                  | Queries data from tables.                                                                    | `SELECT * FROM table_name;`                |
| `CREATE VIEW`             | Creates a view based on a query.                                                             | `CREATE VIEW view_name AS SELECT ...;`     |
| `DROP VIEW`               | Drops an existing view.                                                                      | `DROP VIEW view_name;`                     |
| `CACHE TABLE`             | Caches a table in memory.                                                                    | `CACHE TABLE table_name;`                  |
| `UNCACHE TABLE`           | Removes a table from the in-memory cache.                                                    | `UNCACHE TABLE table_name;`                |
| `SHOW COLUMNS`            | Lists all columns of a table.                                                                | `SHOW COLUMNS FROM table_name;`            |
| `ALTER TABLE`             | Changes the structure of an existing table.                                                  | `ALTER TABLE table_name ADD COLUMNS (...);`|
| `TRUNCATE TABLE`          | Removes all rows from a table without deleting the table.                                    | `TRUNCATE TABLE table_name;`               |
| `MSCK REPAIR TABLE`       | Recovers partitions of a table.                                                              | `MSCK REPAIR TABLE table_name;`            |
| `SHOW PARTITIONS`         | Lists all partitions of a table.                                                             | `SHOW PARTITIONS table_name;`              |
| `EXPLAIN`                 | Provides a detailed execution plan for a query.                                              | `EXPLAIN SELECT * FROM table_name;`        |
| `SHOW CREATE TABLE`       | Displays the `CREATE TABLE` statement for an existing table.                                 | `SHOW CREATE TABLE table_name;`            |
| `LOAD DATA`               | Loads data into a table from a file.                                                         | `LOAD DATA INPATH 'path' INTO TABLE ...;`  |
| `SET`                     | Sets a Spark SQL configuration property.                                                     | `SET property_name=value;`                 |
| `SHOW FUNCTIONS`          | Lists all functions available in the Spark SQL environment.                                  | `SHOW FUNCTIONS;`                          |
| `DESCRIBE FUNCTION`       | Provides information about a function.                                                       | `DESCRIBE FUNCTION function_name;`         |
