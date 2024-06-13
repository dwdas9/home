# Synapse Lake Database, Lakehouse, and Delta Lake

## Synapse Lake Database & Synapse Lakehouse

### What is Lake Database?

A Synapse Lake Database is a container for registered tables, whose  data stays in ADLS as **.parquet files**. Here both the database and the tables are kind of psudo. Only the .parquet files are real and they stay  away from the both.

**How to Create a Lake Database:**
1. **Create a Lake Database**:
   - In Synapse Studio, go to the **Data Tab** -> click + -> **Lake Database**.
   
2. **Register the Parquets as Tables in the Lake Database**:
   ```sql
   CREATE EXTERNAL TABLE [UberLakeDatabase].[BMWUS0BB]
   (
       PassengerNo INT,
       PassengerName DATE
   )
   WITH
   (
       LOCATION = 'lakedatabase/cars/BMWUS0BB.parquet',
       DATA_SOURCE = [YourDataSource],
       FILE_FORMAT = [ParquetFormat]
   );
   ```

**Lake Database is like Uber(ordinary):**

- **Lake Database** is like Uber. Doesn't own any car. Just like Lake Database stores no data inside it.
- **Registered Tables** are like the Taxis. They've no relation with passengers. They just carry them.
- **.parquet Files** are the passengers. Each passenger is an entry in the Lake Database table.
- **Spark/Synapse Pools** are the drivers.
- **CETAS Activity** is like a new Driver registering his taxi with UBER.

![alt text](uber66.png)

### Lakehouse what is it?

A Synapse Lakehouse is simply a Lake Database with tables that are of type Delta. The underlying files are still .parquet, but they are stored in Delta format, providing additional features like ACID transactions.

**Analogy:**
- **Lakehouse** is like Uber Premium.
- **Delta Tables** offer premium services like ACID transactions, similar to the premium experience in Uber Premium.
- **Creation Process**: The same as creating a Lake Database, but the .parquet files are saved in Delta format.

**How to Create a Lakehouse:**

1. **Creating Delta Lake Files**:
   - Use Spark to write data in Delta format:
     ```python
     df.write.format("delta").mode("overwrite").save("ADLS Container")
     ```

2. **Registering Delta Lake Files**:
   - Use CETAS to register Delta Lake files in the Lake Database:
     ```sql
     CREATE EXTERNAL TABLE [UberLakeDatabase].[AudiGK0VC]
     (
         Name INT,
         MarriageDate DATE
     )
     WITH
     (
         LOCATION = 'lakedatabase/cars/AudiGK0VC.parquet',
         DATA_SOURCE = [YourDataSource],
         FILE_FORMAT = [DeltaFormat]
     );
     ```


### Summary:
A Lake Database is essentially:
- **Uber**: Synapse Studio -> **Data Tab**" -> **+** -> **Lake Database**
- **The cars**: Plus registered CETAS tables pointing to Parquets in ADLS.
- **Passengers:** The .parquet files.
- **The Driver**: Spark servers(SQL pool) / Loveless SQL server(Synapse pool). Remember, these are like taxis, they have no connection with the passenger

### Synapse Lakehouse

#### What is it?
A Synapse Lakehouse is similar to a Lake Database, but it uses Delta Lake tables instead of regular Parquet files.

#### Key Components:


#### Summary:
A Lakehouse is:
- A Lake Database with files stored in Delta format.
- Delta tables registered with CETAS in the Lake Database.


### Synapse Dedicated SQL Pool (Formerly SQL Warehouse)

#### What is it?
A Synapse Dedicated SQL Pool is a traditional data warehouse with real SQL tables that can handle large-scale, high-performance queries.

#### Key Components:
1. **Creating a Dedicated SQL Pool**:
   - In Synapse Studio, create a dedicated SQL pool for high-capacity data storage.

2. **Creating Real Tables**:
   - Load data from Lake Database tables into dedicated SQL pool tables.
   - Example:
     ```sql
     CREATE TABLE [DedicatedSales]
     WITH
     (
         DISTRIBUTION = HASH(TransactionID),
         CLUSTERED COLUMNSTORE INDEX
     )
     AS SELECT * FROM [SalesLakeDatabase].[SalesDelta];
     ```

#### Summary:
A Dedicated SQL Pool is used for:
- Creating real SQL tables from pseudo Lake Database tables for high-performance querying.

---

### Overall Summary

- **Lake Database**: Synapse -> "Data Tab" -> "+" -> "Lake Database" + CETAS tables pointing to Parquet files in ADLS.
- **Delta Lake Tables**: Parquet files saved as Delta format.
- **Lakehouse**: Delta Lake tables registered in a Lake Database.
- **Warehouse**: Real SQL tables in a Synapse Dedicated SQL Pool created from Lake Database tables for high-performance queries.

This simplified explanation should help you get a clear understanding of these concepts without getting into too many details.