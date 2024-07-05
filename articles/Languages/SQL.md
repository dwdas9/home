---
layout: default
title: Spark-SQL
parent: Languages
nav_order: 3
---
- [Essential SparkSQL commands](#essential-sparksql-commands)
- [OPENROWSET - The Powerful Transact-SQL for Data Engineering.](#openrowset---the-powerful-transact-sql-for-data-engineering)
  - [What is OPENROWSET?](#what-is-openrowset)
  - [Practical scenarios where OPENROWSET is preferred](#practical-scenarios-where-openrowset-is-preferred)
  - [Syntax](#syntax)
    - [Key Options](#key-options)
    - [Options for CSV](#options-for-csv)
  - [Examples](#examples)
  - [What other options we have?](#what-other-options-we-have)
- [APPROX\_COUNT\_DISTINCT when COUNT(DISTINCT ColName) runs forever](#approx_count_distinct-when-countdistinct-colname-runs-forever)
  - [How to run it?](#how-to-run-it)
  - [Some Fun facts about this T-SQL function](#some-fun-facts-about-this-t-sql-function)


# Essential SparkSQL commands

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

# OPENROWSET - The Powerful Transact-SQL for Data Engineering.

## What is OPENROWSET?

`OPENROWSET` is a Transact-SQL function. Using this, you can create a select statement from external data sources (CSV, Parquet, JSON, Delta, ADLS, Blob) as if it were a local database. You don't need to create a table or linked service to run this. Hence, it's fast and requires fewer lines of code.

It is used in SQL Server, Azure SQL DB, Synapse Analytics, Fabric, and Databricks.

<p style="color: #006600; font-family: 'Trebuchet MS', Helvetica, sans-serif; background-color: #e6ffe6; padding: 15px; border-left: 5px solid #00cc66;">
For `OPENROWSET` to work, you need to ensure that the Synapse workspace or the query has the appropriate authentication to access the external data source.
</p>

## Practical scenarios where OPENROWSET is preferred

1. **Ad-Hoc Data Retrieval:**
   - **Scenario:** A business analyst needs to quickly retrieve data from an Excel file for an ad-hoc report.
   - **Reason:** OPENROWSET allows for on-the-fly access to the Excel file without the need to import it into SQL Server first, providing immediate data retrieval for analysis.

2. **Cross-Database Queries:**
   - **Scenario:** A developer needs to run a query that joins tables from different SQL Server instances.
   - **Reason:** OPENROWSET can be used to run distributed queries across different servers, avoiding the need to set up linked servers which can be more complex and require additional configuration and permissions.

3. **Accessing External Data Sources:**
   - **Scenario:** A company needs to integrate data from a remote Oracle database for a one-time data migration task.
   - **Reason:** OPENROWSET provides a quick way to query data from the Oracle database using an OLE DB provider, bypassing the need for more permanent and complex solutions like linked servers or SSIS packages.

4. **Temporary Data Access:**
   - **Scenario:** During a data validation process, a data engineer needs to access data from a CSV file provided by a client.
   - **Reason:** OPENROWSET allows the engineer to read the CSV file directly into a SQL query, facilitating temporary data access without the overhead of creating permanent database tables or ETL processes.

5. **Data Import for Development and Testing:**
   - **Scenario:** Developers need to import data from various formats (e.g., Excel, CSV) into a development environment for testing purposes.
   - **Reason:** OPENROWSET can be used to import data directly into the development environment without the need for pre-configured data import processes, speeding up the testing and development cycles.


## Syntax
```sql
-- General Syntax
OPENROWSET(
    BULK 'file_path',
    FORMAT = 'file_format',
    [DATA_SOURCE = 'data_source_name'],
    [WITH ( column_name column_type [ 'column_ordinal' | 'json_path' ] )]
) AS alias_name

-- Example for CSV
SELECT * 
FROM OPENROWSET(
    BULK 'https://storageaccount.blob.core.windows.net/container/file.csv',
    FORMAT = 'CSV',
    FIRSTROW = 2,
    FIELDTERMINATOR = ',',
    ROWTERMINATOR = '\n'
) AS [result]

-- Example for Parquet
SELECT * 
FROM OPENROWSET(
    BULK 'https://storageaccount.blob.core.windows.net/container/file.parquet',
    FORMAT = 'PARQUET'
) AS [result]

-- Example for Delta Lake
SELECT * 
FROM OPENROWSET(
    BULK 'https://storageaccount.blob.core.windows.net/container/file.delta',
    FORMAT = 'DELTA'
) AS [result]
```

### Key Options
- **BULK**: Specifies the path to the file(s).
- **FORMAT**: Specifies the file format (`CSV`, `PARQUET`, or `DELTA`).
- **DATA_SOURCE**: (Optional) Specifies the external data source.
- **WITH**: Defines the schema of the columns to be read.

### Options for CSV
- **FIELDTERMINATOR**: Character used to separate fields (default is `,`).
- **ROWTERMINATOR**: Character used to separate rows (default is `\n`).
- **FIRSTROW**: Specifies the first row to read (default is 1).
- **HEADER_ROW**: Indicates if the CSV file contains a header row (`TRUE` or `FALSE`).

## Examples

1. **Reading a CSV file without specifying a schema:**
    ```sql
    SELECT * 
    FROM OPENROWSET(
        BULK 'https://storageaccount.blob.core.windows.net/container/data.csv',
        FORMAT = 'CSV'
    ) AS [data]
    ```

2. **Reading specific columns from a CSV file:**
    ```sql
    SELECT * 
    FROM OPENROWSET(
        BULK 'https://storageaccount.blob.core.windows.net/container/data.csv',
        FORMAT = 'CSV',
        FIELDTERMINATOR = ',',
        ROWTERMINATOR = '\n',
        FIRSTROW = 2
    )
    WITH (
        col1 VARCHAR(50),
        col2 INT,
        col3 DATE
    ) AS [data]
    ```

3. **Reading a Parquet file:**
    ```sql
    SELECT * 
    FROM OPENROWSET(
        BULK 'https://storageaccount.blob.core.windows.net/container/data.parquet',
        FORMAT = 'PARQUET'
    ) AS [data]
    ```

4. **Reading a Delta Lake file:**
    ```sql
    SELECT * 
    FROM OPENROWSET(
        BULK 'https://storageaccount.blob.core.windows.net/container/data.delta',
        FORMAT = 'DELTA'
    ) AS [data]
    ```
## What other options we have?

| Alternative      | Usage Scenario                                                                                             | Efficiency           | Microsoft Recommendation                             |
|------------------|------------------------------------------------------------------------------------------------------------|----------------------|------------------------------------------------------|
| BULK INSERT      | Loading large volumes of data from a file into a SQL Server table.                                         | High for large files | Use when importing large data volumes directly.      |
| PolyBase         | Querying external data in Hadoop, Azure Blob Storage, and Azure Data Lake.                                 | High                 | Use for big data environments and distributed systems.|
| EXTERNAL TABLE   | Accessing external data sources seamlessly as if they are regular SQL tables.                              | Moderate to High     | Recommended for persistent access to external data.  |
| Linked Servers   | Connecting SQL Server to other data sources, like another SQL Server or an OLE DB data source.             | Varies               | Use for diverse data sources and quick data joins.   |
| Databricks       | Reading data from various sources using Spark SQL (not native to Databricks but works with Synapse).       | High for big data    | Use for Spark SQL integrations and large-scale analytics. |

# <span style="color: BlueViolet">APPROX_COUNT_DISTINCT</span> when <span style="color: CornflowerBlue">COUNT(DISTINCT ColName)</span> runs forever

Imagine your table has 1 trillion rows. You want to count distinct customer names. Do you think `COUNT(DISTINCT CustomerName)` will show you results in your lifetime?

No, for such scenarios, use `APPROX_COUNT_DISTINCT(ColName)`. It will give you around 97% accuracy.

## <span style="color: DarkCyan">How to run it?</span>

Pretty simple and straightforward.

**Normal Count**
```sql
SELECT COUNT(DISTINCT CustomerName) FROM Customers;
```

**Approximate Count**

```sql 
SELECT APPROX_COUNT_DISTINCT(CustomerName) FROM Customers; 
```
## <span style="color: Gray">Some Fun facts about this T-SQL function</span>

In MS SQL Server `APPROX_COUNT_DISTINCT` it first came in **SQL Server 2019**. It is **available in Synapse SQL**. These other brands support this function:

1. **Google BigQuery**
2. **Amazon Redshift**: It offers the `APPROXIMATE COUNT(DISTINCT column)` function, which serves a similar purpose.
3. **PostgreSQL**: The `approx_count_distinct` extension is available through the `HLL (HyperLogLog)` extension, which allows for approximate distinct counting.
4. **Apache Spark**: The `approx_count_distinct` function is available in Spark SQL, which uses HyperLogLog for approximate counting.
