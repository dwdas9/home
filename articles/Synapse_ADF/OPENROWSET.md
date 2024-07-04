---
layout: default
title: OPENROWSET
parent: SynapseAnalytics
nav_order: 12
---

- [OPENROWSET - The Powerful Transact-SQL for Data Engineering.](#openrowset---the-powerful-transact-sql-for-data-engineering)
  - [What is OPENROWSET?](#what-is-openrowset)
  - [Practical scenarios where OPENROWSET is preferred](#practical-scenarios-where-openrowset-is-preferred)
  - [Syntax](#syntax)
    - [Key Options](#key-options)
    - [Options for CSV](#options-for-csv)
  - [Examples](#examples)
- [What other options we have?](#what-other-options-we-have)

## OPENROWSET - The Powerful Transact-SQL for Data Engineering.

### What is OPENROWSET?

`OPENROWSET` is a Transact-SQL function. Using this, you can create a select statement from external data sources (CSV, Parquet, JSON, Delta, ADLS, Blob) as if it were a local database. You don't need to create a table or linked service to run this. Hence, it's fast and requires fewer lines of code.

It is used in SQL Server, Azure SQL DB, Synapse Analytics, Fabric, and Databricks.

<p style="color: #006600; font-family: 'Trebuchet MS', Helvetica, sans-serif; background-color: #e6ffe6; padding: 15px; border-left: 5px solid #00cc66;">
For `OPENROWSET` to work, you need to ensure that the Synapse workspace or the query has the appropriate authentication to access the external data source.
</p>

### Practical scenarios where OPENROWSET is preferred

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


### Syntax
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

#### Key Options
- **BULK**: Specifies the path to the file(s).
- **FORMAT**: Specifies the file format (`CSV`, `PARQUET`, or `DELTA`).
- **DATA_SOURCE**: (Optional) Specifies the external data source.
- **WITH**: Defines the schema of the columns to be read.

#### Options for CSV
- **FIELDTERMINATOR**: Character used to separate fields (default is `,`).
- **ROWTERMINATOR**: Character used to separate rows (default is `\n`).
- **FIRSTROW**: Specifies the first row to read (default is 1).
- **HEADER_ROW**: Indicates if the CSV file contains a header row (`TRUE` or `FALSE`).

### Examples

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
