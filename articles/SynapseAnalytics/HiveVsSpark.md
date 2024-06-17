![](images/custom-image-2024-06-17-15-31-39.png)

## Apache Hive and Spark: An Overview

### What is Apache Hive?

**Apache Hive** is a database  like MSSQL Server. Its actually a data warehouse. It stores data in Hadoop File system(HDFS) as tables.Hive's query language is called **HiveQL**, similar to SQL. he **Hive metastore** stores information about Hive tables. Developed by Facebook, Hive later became an Apache project.

### What is Hadoop?

Haddop has three parts: HDFS - The file system. Mapreduce - The processing engine.Yarn - Resource manager

### What is Spark?

Its mainly a processing engine more like Mapreduce v2. It has no internal storage sytem like HDFS, but uses external file system lie ADLS, HDFS, S3 etc. Its processing engine is called Spark Core. It has standalone resource manager by default to manage its clusters.


### Is spark replacing Hive, hadoop and the old-timers?

Products like Azure Synapse, Microsft Fabric gives you ADLS, OneLake for storage. And Spark for processing. And creation fo warehouse is also so simple, just load the raw data form csvs into spark dataframe and save them as delta lake tables.

Now, try to get a similar setup using Hive and Hadoop. The steps will be:

Go through the complex installation setup of hive, which will include ccratinga hive metastore integrating with Hive metastore db, installing HDFS and manging it. And, the steps aren't simple enough, they include very low level humoungus settings and setup files.

Also, if you use 

### Never heard of Hive. We use only Spark and Synapse Analytics.


Alright you never heard of Hive and you only create Internal spark tables. Internal tables(or spark internal tables) is a very new and very much used technology in Azure Synapse.

Suppose 



- **Hive on Spark** integrates Hive with Spark, using Spark's in-memory processing to boost performance.
- It uses **HiveQL**, suitable for batch processing and ETL tasks.
- Hive on Spark leverages the **Hive metastore** for managing table metadata.

### Example: Hive on Spark

```python
spark = SparkSession \
    .builder \
    .appName("Python Spark SQL Hive integration example") \
    .config("spark.sql.warehouse.dir", warehouse_location) \
    .enableHiveSupport() \
    .getOrCreate()
```
