---
layout: default
title: Cheatsheets
nav_order: 6
---

## Table of Contents

- [Table of Contents](#table-of-contents)
    - [**Azure Programming Cheatsheet**](#azure-programming-cheatsheet)
    - [**Azure Storage SDK For Python**](#azure-storage-sdk-for-python)
  - [**Azure Storage And Data Services Cheatsheet**](#azure-storage-and-data-services-cheatsheet)
    - [**Storage Services**](#storage-services)
    - [**Data And Analytics Services**](#data-and-analytics-services)
  - [Commonly used DataFrame operations in Apache Spark](#commonly-used-dataframe-operations-in-apache-spark)
  - [1. Spark SQL Cheat Sheet](#1-spark-sql-cheat-sheet)
  - [2. Spark DataFrame API Cheat Sheet (Python/PySpark)](#2-spark-dataframe-api-cheat-sheet-pythonpyspark)
  - [3. Spark RDD Cheat Sheet](#3-spark-rdd-cheat-sheet)
  - [4. Spark MLlib Cheat Sheet](#4-spark-mllib-cheat-sheet)
  - [5. Spark GraphX Cheat Sheet](#5-spark-graphx-cheat-sheet)
  - [6. Spark Streaming Cheat Sheet](#6-spark-streaming-cheat-sheet)
  - [7. Spark Configuration and Optimization Cheat Sheet](#7-spark-configuration-and-optimization-cheat-sheet)
  - [8. Spark Deployment Cheat Sheet](#8-spark-deployment-cheat-sheet)
  - [Spark Common Operations Cheat Sheet](#spark-common-operations-cheat-sheet)
    - [Dataframe Operations](#dataframe-operations)
    - [Spark SQL Operations](#spark-sql-operations)
    - [Reading and Writing Data](#reading-and-writing-data)
    - [RDD Operations](#rdd-operations)
    - [Configuration and Optimization](#configuration-and-optimization)
    - [Miscellaneous](#miscellaneous)

---
#### **Azure Programming Cheatsheet**

#### **Azure Storage SDK For Python**

| Operation | Function | Code snippet |
|---|---|---|
| Connect to storage account | `BlobServiceClient.from_connection_string()` | `blob_service_client = BlobServiceClient.from_connection_string(YOUR_CONNECTION_STRING)` |
| Create a blob | `BlobClient.upload_blob()` | `blob_client = blob_service_client.get_blob_client(container_name="mycontainer", blob_name="myblob.txt") blob_client.upload_blob("myblob.txt")` |
| Download a blob | `BlobClient.download_blob()` | `with open("myblob.txt", "wb") as f: blob_client.download_blob(f)` |
| List blobs in a container | `ContainerClient.list_blobs()` | `for blob in blob_service_client.get_container_client(container_name="mycontainer").list_blobs(): print(blob.name)` |
| Delete a blob | `BlobClient.delete_blob()` | `blob_client.delete_blob()` |
| Create a container | `ContainerClient.create_container()` | `container_client = blob_service_client.get_container_client(container_name="mycontainer") container_client.create_container()` |
| Delete a container | `ContainerClient.delete_container()` | `container_client.delete_container()` |


### **Azure Storage And Data Services Cheatsheet**


#### **Storage Services**

| Azure Product | AWS Equivalent | GCP Equivalent | Underlying Components |
|---|---|---|---|
| **Azure Blob Storage** | Amazon S3 | Cloud Storage (Standard) | Object Storage |
| **Azure File Storage** | Amazon EFS | Filestore | Managed File Shares |
| **Azure Table Storage** | Amazon DynamoDB | Firestore (Kind of) | NoSQL Store |
| **Azure Queue Storage** | Amazon SQS | Cloud Tasks (somewhat) | Messaging Service |
| **Azure Disk Storage** | Amazon EBS | Persistent Disk | VM Disk |
| **Azure Data Lake Storage Gen1** | S3 + Amazon EMR | Cloud Storage + Dataproc | Big Data Storage |
| **Azure Data Lake Storage Gen2** | S3 with S3 Select & Glacier | Cloud Storage (with Hierarchical Namespace features) | Enhanced Big Data Storage |
| **Azure Cosmos DB** | Amazon DynamoDB Global Tables | Cloud Spanner | Globally Distributed NoSQL |
| **Azure Managed Disks** | Amazon EBS | Persistent Disk | Managed VM Disks |
| **Azure StorSimple** | AWS Storage Gateway | No direct equivalent | Hybrid Cloud Storage |

---

#### **Data And Analytics Services**

| Azure Product | AWS Equivalent | GCP Equivalent | Underlying Components |
|---|---|---|---|
| **Azure SQL Database** | Amazon RDS (SQL Server) | Cloud SQL (SQL Server) | Managed SQL |
| **Azure Synapse Analytics** | Amazon Redshift Spectrum | BigQuery + Dataproc | Analytics Platform |
| **Azure Data Factory** | AWS Glue | Cloud Dataflow | ETL Service |
| **Azure Stream Analytics** | Amazon Kinesis Data Analytics | Dataflow (Streaming mode) | Real-time Analytics |
| **Azure HDInsight** | Amazon EMR | Dataproc | Big Data Service |
| **Azure Databricks** | AWS Databricks | No direct equivalent, but Dataproc for Spark | Big Data Analytics |
| **Azure Data Explorer (ADX)** | Amazon Elasticsearch Service | BigQuery | Fast Data Exploration |
| **Azure Database for PostgreSQL** | Amazon RDS (PostgreSQL) | Cloud SQL (PostgreSQL) | Managed PostgreSQL |
| **Azure Database for MySQL** | Amazon RDS (MySQL) | Cloud SQL (MySQL) | Managed MySQL |
| **Azure Database for MariaDB** | Amazon RDS (MariaDB) | Cloud SQL (MariaDB) | Managed MariaDB |
| **Azure Cache for Redis** | Amazon ElastiCache (Redis) | Cloud Memorystore (Redis) | Managed Redis Cache |
| **Azure Search** | Amazon CloudSearch | Cloud Talent Solution | Search-as-a-Service |
| **Azure Time Series Insights** | Amazon Timestream | Cloud IoT Core + BigQuery | Time Series Analysis |
| **Azure Data Share** | AWS Data Exchange | No direct equivalent | Data Collaboration |
| **Azure Purview** | AWS Glue Data Catalog | Cloud Data Catalog | Data Governance |


### Commonly used DataFrame operations in Apache Spark

### 1. Spark SQL Cheat Sheet

| Operation | Description | Example |
|-----------|-------------|---------|
| `SELECT` | Selects data from a table. | `SELECT * FROM table` |
| `WHERE` | Filters rows based on a condition. | `SELECT * FROM table WHERE column > 100` |
| `GROUP BY` | Groups the result set. | `SELECT column, COUNT(*) FROM table GROUP BY column` |
| `JOIN` | Joins tables. | `SELECT * FROM table1 JOIN table2 ON table1.id = table2.id` |
| `ORDER BY` | Sorts the result set. | `SELECT * FROM table ORDER BY column DESC` |
| `HAVING` | Filters groups based on conditions. | `SELECT column, COUNT(*) FROM table GROUP BY column HAVING COUNT(*) > 1` |
| `WINDOW` | Defines a window for window functions. | `SELECT column, SUM(value) OVER (PARTITION BY column ORDER BY another_column) FROM table` |

### 2. Spark DataFrame API Cheat Sheet (Python/PySpark)

| Operation | Description | Example Usage |
|-----------|-------------|---------------|
| `show()` | Displays the first few rows of the DataFrame. | `df.show()` |
| `printSchema()` | Prints the schema of the DataFrame. | `df.printSchema()` |
| `select()` | Selects a set of columns. | `df.select("column1", "column2")` |
| `filter()` / `where()` | Filters rows using a condition. | `df.filter(df["column"] > 0)` |
| `groupBy()` | Groups the DataFrame using the specified columns. | `df.groupBy("column").count()` |
| `orderBy()` / `sort()` | Sorts the DataFrame. | `df.orderBy(df["column"].desc())` |
| `join()` | Joins with another DataFrame. | `df1.join(df2, df1["id"] == df2["id"])` |
| `union()` | Returns a new DataFrame containing union of rows. | `df1.union(df2)` |
| `distinct()` | Selects distinct rows. | `df.distinct()` |
| `dropDuplicates()` | Drops duplicate rows. | `df.dropDuplicates()` |
| `withColumn()` | Adds a new column or replaces an existing one. | `df.withColumn("new_column", df["column"] + 1)` |
| `drop()` | Drops a column. | `df.drop("column")` |
| `agg()` | Aggregate on the entire DataFrame. | `df.agg({"column": "max"})` |
| `collect()` | Collects the rows into a list. | `df.collect()` |
| `count()` | Counts the number of rows. | `df.count()` |
| `describe()` | Computes basic statistics for numeric columns. | `df.describe().show()` |
| `limit()` | Limits the result count. | `df.limit(10)` |
| `sample()` | Returns a sampled subset of the DataFrame. | `df.sample(False, 0.1)` |
| `persist()` / `cache()` | Persists the DataFrame with an optional storage level. | `df.persist()` |
| `unpersist()` | Unpersists the DataFrame from memory. | `df.unpersist()` |
| `write()` | Used to write the DataFrame to an external storage system. | `df.write.format("parquet").save("/path")` |
| `read()` | Reads data from a storage system into a DataFrame. | `spark.read.format("csv").option("header", "true").load("/path")` |


### 3. Spark RDD Cheat Sheet

| Operation | Description | Example |
|-----------|-------------|---------|
| `map()` | Applies a function to each element. | `rdd.map(lambda x: x * 2)` |
| `filter()` | Filters elements. | `rdd.filter(lambda x: x > 10)` |
| `flatMap()` | Maps each element to 0 or more elements. | `rdd.flatMap(lambda x: (x, x*2))` |
| `reduce()` | Reduces the elements to a single value. | `rdd.reduce(lambda x, y: x + y)` |
| `join()` | Joins two RDDs. | `rdd1.join(rdd2)` |
| `cache()` | Caches the RDD. | `rdd.cache()` |
| `collect()` | Collects all elements. | `rdd.collect()` |

### 4. Spark MLlib Cheat Sheet

| Operation | Description | Example |
|-----------|-------------|---------|
| `VectorAssembler` | Combines multiple columns into a vector column. | `VectorAssembler(inputCols=["col1", "col2"], outputCol="features")` |
| `StringIndexer` | Encodes a string column to a column of indices. | `StringIndexer(inputCol="category", outputCol="categoryIndex")` |
| `RandomForestClassifier` | Trains a random forest classifier. | `RandomForestClassifier(featuresCol="features", labelCol="label")` |
| `RegressionEvaluator` | Evaluates regression models. | `RegressionEvaluator(predictionCol="prediction", labelCol="label", metricName="rmse")` |
| `TrainValidationSplit` | Train-validation for hyperparameter tuning. | `TrainValidationSplit(estimator=rf, evaluator=evaluator, estimatorParamMaps=paramGrid)` |

### 5. Spark GraphX Cheat Sheet

| Operation | Description | Example |
|-----------|-------------|---------|
| `Graph()` | Creates a graph. | `Graph(vertices, edges)` |
| `triplets` | Maps each edge to a triplet. | `graph.triplets.map(lambda triplet: (triplet.srcAttr, triplet.dstAttr))` |
| `subgraph()` | Creates a subgraph. | `graph.subgraph(vpred=(id, attr) => attr > 5)` |
| `pageRank` | Runs the PageRank algorithm. | `graph.pageRank(tol=0.01)` |
| `connectedComponents()` | Finds connected components. | `graph.connectedComponents()` |

### 6. Spark Streaming Cheat Sheet

| Operation | Description | Example |
|-----------|-------------|---------|
| `readStream` | Reads data in streaming mode. | `spark.readStream.format("kafka").option("

subscribe", "topic").load()` |
| `writeStream` | Writes data in streaming mode. | `stream.writeStream.format("console").start()` |
| `window()` | Windows data for aggregations. | `data.groupBy(window(data.timestamp, "1 hour")).count()` |
| `trigger()` | Sets the streaming trigger. | `stream.writeStream.trigger(processingTime='1 minute').start()` |
| `updateStateByKey()` | Maintains state across batches. | `stream.updateStateByKey(updateFunction)` |

### 7. Spark Configuration and Optimization Cheat Sheet

| Configuration | Description | Recommended Setting |
|---------------|-------------|---------------------|
| `spark.executor.memory` | Memory per executor. | Depends on the cluster (e.g., `4g`) |
| `spark.sql.shuffle.partitions` | Number of shuffle partitions. | Depends on data size (e.g., `200`) |
| `spark.default.parallelism` | Default parallelism level. | Depends on the cluster |
| `spark.serializer` | Serializer class. | `org.apache.spark.serializer.KryoSerializer` |
| `spark.executor.cores` | Number of cores per executor. | Depends on the cluster |

### 8. Spark Deployment Cheat Sheet

| Deployment Mode | Description | Key Points |
|-----------------|-------------|------------|
| Standalone | Spark's simple cluster manager. | Suitable for static clusters. |
| YARN | Integrates with Hadoop YARN. | Good for Hadoop ecosystems. |
| Mesos | General cluster manager. | Flexible resource sharing. |
| Kubernetes | Container orchestration system. | Suitable for dynamic environments. |

### Spark Common Operations Cheat Sheet

#### Dataframe Operations

| Operation | Description | Example |
|-----------|-------------|---------|
| `show()` | Displays the DataFrame rows. | `df.show()` |
| `select()` | Selects specific columns. | `df.select("column1", "column2")` |
| `filter()` | Filters rows based on condition. | `df.filter(df["column"] > 100)` |
| `withColumn()` | Adds a new column or updates an existing one. | `df.withColumn("new_column", df["column"] + 1)` |
| `drop()` | Removes a column from the DataFrame. | `df.drop("column")` |
| `groupBy()` | Groups by a column for aggregation. | `df.groupBy("column").count()` |
| `orderBy()` | Sorts the DataFrame. | `df.orderBy(df["column"].desc())` |
| `join()` | Joins with another DataFrame. | `df.join(df2, df["id"] == df2["id"])` |
| `union()` | Unions two DataFrames. | `df1.union(df2)` |
| `distinct()` | Selects distinct rows. | `df.distinct()` |
| `collect()` | Collects rows into an array. | `df.collect()` |
| `count()` | Counts the number of rows. | `df.count()` |

#### Spark SQL Operations

| Operation | Description | Example |
|-----------|-------------|---------|
| `createOrReplaceTempView()` | Creates a temporary view. | `df.createOrReplaceTempView("view")` |
| `sql()` | Executes SQL query. | `spark.sql("SELECT * FROM view")` |

#### Reading and Writing Data

| Operation | Description | Example |
|-----------|-------------|---------|
| `read.format()` | Reads data in a specified format. | `spark.read.format("csv").option("header", "true").load("path")` |
| `write.format()` | Writes data in a specified format. | `df.write.format("parquet").save("path")` |

#### RDD Operations

| Operation | Description | Example |
|-----------|-------------|---------|
| `map()` | Applies a function to each element. | `rdd.map(lambda x: x * 2)` |
| `filter()` | Filters elements based on a condition. | `rdd.filter(lambda x: x > 10)` |
| `flatMap()` | Maps each element to 0 or more elements. | `rdd.flatMap(lambda x: [x, x*2])` |
| `reduce()` | Reduces elements to a single value. | `rdd.reduce(lambda x, y: x + y)` |

#### Configuration and Optimization

| Configuration | Description | Example |
|---------------|-------------|---------|
| `setAppName()` | Sets the name of the application. | `spark.conf.setAppName("MyApp")` |
| `setMaster()` | Sets the master URL. | `spark.conf.setMaster("local[*]")` |
| `getOrCreate()` | Gets or creates a SparkSession. | `SparkSession.builder.getOrCreate()` |

#### Miscellaneous

| Operation | Description | Example |
|-----------|-------------|---------|
| `cache()` | Caches the DataFrame. | `df.cache()` |
| `persist()` | Persists the DataFrame with a storage level. | `df.persist(StorageLevel.MEMORY_AND_DISK)` |
| `broadcast()` | Broadcasts a variable. | `broadcastVar = spark.sparkContext.broadcast([1, 2, 3])` |
| `accumulator()` | Creates an accumulator. | `acc = spark.sparkContext.accumulator(0)` |


---

© D Das  
📧 [das.d@hotmail.com](mailto:das.d@hotmail.com) | [ddasdocs@gmail.com](mailto:ddasdocs@gmail.com)