
> Every Spark managed table is a folder inside a db folder

When you use enableHiveSupport() in Spark without specifying an external Hive metastore, Spark creates a default embedded metastore using Derby. Here’s how it works:

Hive Metastore and Metastore Database in Spark
Embedded Derby Metastore:

When you don't configure an external Hive metastore, Spark uses an embedded Derby database by default.
The metadata for your tables is stored in a local Derby database file.
Location of Derby Database:

The Derby database is typically stored in the metastore_db directory within your Spark working directory.
This directory contains the metadata for your Hive tables.
Default Warehouse Directory:

The data files for your managed tables are stored in the default warehouse directory, usually spark-warehouse within your Spark working directory, unless configured otherwise.
These files are stored in Parquet format, with associated .crc files for checksums.

Now let's clear some concepts:

spark-warehouse folder: Its the folder where SparkSQL stores
spark-catalogue
Spark tables - Manged and External
Hive, Derby database
enableHiveSupport()
metastoer(aka metastore_db) and catalogues

=> Metastore (aka metastore_db) is a relational database that is used by Hive, Presto, Spark, etc. to manage the metadata of persistent relational entities (e.g. databases, tables, columns, partitions) for fast access. Additionally, a spark-warehouse is the directory where Spark SQL persists tables. 😀

Spark SQL by default uses an In-Memory catalog/metastore deployed with Apache Derby database. 

spark.sql.warehouse.dir 

Unless configured otherwise, Spark will create an internal Derby database named metastore_db with a derby.log. Looks like you've not changed that.

When not configured by the hive-site.xml, the context automatically creates metastore_db in the current directory and creates a directory configured by spark.sql.warehouse.dir, which defaults to the directory spark-warehouse in the current directory that the Spark application is started

$HIVE_HOME/conf/hive-site.xml
hive.metastore.warehouse.dir

The base Apache Hadoop framework is composed of the following modules:

Hadoop Common — contains libraries and utilities needed by other Hadoop modules;
Hadoop Distributed File System (HDFS) — a distributed file-system that stores data on commodity machines, providing very high aggregate bandwidth across the cluster;
Hadoop YARN — (introduced in 2012) a platform responsible for managing computing resources in clusters and using them for scheduling users’ applications;
Hadoop MapReduce — an implementation of the MapReduce programming model for large-scale data processing.

Serde library
The default external catalog implementation is controlled by spark.sql.catalogImplementation internal property and can be one of the two possible values: hive and in-memory.

Can there be hive without hadoop. Yes, a local spark has hive locally, you wont need a complex hadoop installation.

The Apache Hive ™ data warehouse software facilitates querying and managing large datasets residing in distributed storage. Hive provides a mechanism to project structure onto this data and query the data using a SQL-like language called HiveQL.
Apache Hive is a data warehouse infrastructure built on top of Hadoop for providing data summarization, query, and analysis.

In a simple Spark installation, hive-site.xml might not be directly included  since Spark itself doesn't manage Hive configurations. Here are two possibilities:

Spark with Pre-installed Hive:
If you installed Spark alongside a pre-existing Hive installation, then hive-site.xml might be located in the typical Hive configuration directory:

/etc/hive/conf/hive-site.xml
Spark without Hive:
If Spark is installed independently without Hive, you likely won't find hive-site.xml. In this case, Spark wouldn't rely on Hive configurations by default.

```python
from pyspark.sql import SparkSession

# Create or get a Spark session
spark = SparkSession.builder \
    .appName("MyApp") \
    .getOrCreate()

# Get the current value of spark.sql.warehouse.dir
warehouse_dir = spark.conf.get("spark.sql.warehouse.dir")
print(f"Warehouse Directory: {warehouse_dir}")
```

When working with Hive, one must instantiate SparkSession with Hive support, including connectivity to a persistent Hive metastore, support for Hive serdes, and Hive user-defined functions. Users who do not have an existing Hive deployment can still enable Hive support. When not configured by the hive-site.xml, the context automatically creates metastore_db in the current directory and creates a directory configured by spark.sql.warehouse.dir, which defaults to the directory spark-warehouse in the current directory that the Spark application is started. Note that the hive.metastore.warehouse.dir property in hive-site.xml is deprecated since Spark 2.0.0. Instead, use spark.sql.warehouse.dir to specify the default location of database in warehouse. You may need to grant write privilege to the user who starts the Spark application.