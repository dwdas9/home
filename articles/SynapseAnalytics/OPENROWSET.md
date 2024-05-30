- [OPENROWSET Cheat Sheet for Azure Synapse Analytics](#openrowset-cheat-sheet-for-azure-synapse-analytics)
  - [What is OPENROWSET?](#what-is-openrowset)
  - [Where is it Used?](#where-is-it-used)
  - [Use in Various Platforms](#use-in-various-platforms)
  - [Syntax](#syntax)
    - [Key Options](#key-options)
    - [Bulk Options for CSV](#bulk-options-for-csv)
  - [Examples](#examples)
  - [Security](#security)
- [Alternatives to OPENROWSET: Usage Scenarios and Recommendations](#alternatives-to-openrowset-usage-scenarios-and-recommendations)
  - [Recommendations](#recommendations)
  - [Detailed Usage Examples](#detailed-usage-examples)

## OPENROWSET Cheat Sheet for Azure Synapse Analytics

### What is OPENROWSET?

`OPENROWSET` is a Transact-SQL function that allows you to access external data sources directly from SQL queries. It enables reading data from various formats such as CSV, Parquet, and Delta Lake, stored in locations like Azure Blob Storage or other file systems.

### Where is it Used?

- **SQL Server**: Primarily for accessing external data via OLE DB providers.
- **Azure SQL Database**: For reading files from Azure Storage.
- **Azure Synapse Analytics**: Serverless SQL pools use `OPENROWSET` to query data directly from storage.
- **Microsoft Fabric**: Supports querying data stored in various file formats.
- **Databricks**: While Databricks primarily uses Spark SQL, it can interoperate with Azure Synapse and external data sources, but `OPENROWSET` itself is not a native Databricks function.

### Use in Various Platforms

- **SQL Server**: Connects to OLE DB data sources.
- **Azure SQL Database**: Connects to Azure Storage for reading files.
- **Azure Synapse Analytics**: Serverless SQL querying.
- **Microsoft Fabric**: Data integration and querying capabilities.
- **Databricks**: Uses Spark SQL; `OPENROWSET` is not used directly but can work with Synapse.

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

#### Bulk Options for CSV
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

### Security
- Requires `ADMINISTER BULK OPERATIONS` permission.
- Proper authentication is necessary to access Azure Storage files (e.g., SAS tokens, Managed Identities, or Azure AD).

## Alternatives to OPENROWSET: Usage Scenarios and Recommendations

| Alternative      | Usage Scenario                                                                                             | Efficiency           | Microsoft Recommendation                             |
|------------------|------------------------------------------------------------------------------------------------------------|----------------------|------------------------------------------------------|
| BULK INSERT      | Loading large volumes of data from a file into a SQL Server table.                                         | High for large files | Use when importing large data volumes directly.      |
| PolyBase         | Querying external data in Hadoop, Azure Blob Storage, and Azure Data Lake.                                 | High                 | Use for big data environments and distributed systems.|
| EXTERNAL TABLE   | Accessing external data sources seamlessly as if they are regular SQL tables.                              | Moderate to High     | Recommended for persistent access to external data.  |
| Linked Servers   | Connecting SQL Server to other data sources, like another SQL Server or an OLE DB data source.             | Varies               | Use for diverse data sources and quick data joins.   |
| Databricks       | Reading data from various sources using Spark SQL (not native to Databricks but works with Synapse).       | High for big data    | Use for Spark SQL integrations and large-scale analytics. |

### Recommendations
- **Efficiency**: PolyBase and BULK INSERT are generally the most efficient for large data volumes.
- **Flexibility**: Linked Servers and EXTERNAL TABLEs provide flexibility for various data sources.
- **Microsoft Recommendation**: PolyBase is recommended for its efficiency and integration capabilities in big data environments.

### Detailed Usage Examples

1. **BULK INSERT**
   ```sql
   BULK INSERT Sales
   FROM 'C:\Data\Sales.csv'
   WITH (FIELDTERMINATOR = ',', ROWTERMINATOR = '\n');
   ```

2. **PolyBase**
   ```sql
   CREATE EXTERNAL TABLE Sales
   (ID int, Name nvarchar(50), Amount float)
   WITH (LOCATION='wasbs://data@storage.blob.core.windows.net/sales', DATA_SOURCE=AzureBlobStorage, FILE_FORMAT=CSVFormat);
   ```

3. **EXTERNAL TABLE**
   ```sql
   CREATE EXTERNAL TABLE Sales
   WITH (DATA_SOURCE = AzureStorage, LOCATION = 'sales.csv', FILE_FORMAT = CSVFormat);
   ```

4. **Linked Servers**
   ```sql
   EXEC sp_addlinkedserver 'RemoteServer', 'SQL Server';
   SELECT * FROM [RemoteServer].[Database].[dbo].[Sales];
   ```

5. **Databricks (Spark SQL)**
   ```sql
   SELECT * FROM delta.`/mnt/delta/sales`;
   ```