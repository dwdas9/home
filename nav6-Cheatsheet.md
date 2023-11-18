---
layout: default
title: Cheatsheets
nav_order: 6
---

## Table of Contents

- [Table of Contents](#table-of-contents)
    - [**Azure Storage SDK For Python**](#azure-storage-sdk-for-python)
  - [**Azure Storage And Data Services Cheatsheet**](#azure-storage-and-data-services-cheatsheet)
    - [**Storage Services**](#storage-services)
    - [**Data And Analytics Services**](#data-and-analytics-services)
      - [Spark GraphX Cheat Sheet](#spark-graphx-cheat-sheet)
      - [Spark Streaming Cheat Sheet](#spark-streaming-cheat-sheet)
      - [Spark Configuration and Optimization Cheat Sheet](#spark-configuration-and-optimization-cheat-sheet)
      - [Spark Deployment Cheat Sheet](#spark-deployment-cheat-sheet)
      - [Spark Common Operations Cheat Sheet](#spark-common-operations-cheat-sheet)
        - [Dataframe Operations](#dataframe-operations)
        - [Spark SQL Operations](#spark-sql-operations)
        - [Reading and Writing Data](#reading-and-writing-data)
        - [RDD Operations](#rdd-operations)
        - [Configuration and Optimization](#configuration-and-optimization)
        - [Miscellaneous](#miscellaneous)
    - [Docker cheatsheet](#docker-cheatsheet)
- [| Display a live stream of container(s) stats | `docker stats [container-name-or-id]`                                                                                      |](#-display-a-live-stream-of-containers-stats--docker-stats-container-name-or-id--------------------------------------------------------------------------------------)

---

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


##### Spark GraphX Cheat Sheet
| Operation | Description | Example |
|---|---|---|
| `Graph()` | Creates a graph. | `Graph(vertices, edges)` |
| `triplets` | Maps edges to triplets. | `graph.triplets.map(triplet => (triplet.srcAttr, triplet.dstAttr))` |
| `subgraph()` | Creates a subgraph. | `graph.subgraph(vpred = (id, attr) => attr > 5)` |
| `pageRank` | Runs PageRank algorithm. | `graph.pageRank(tol = 0.01)` |
| `connectedComponents()` | Finds connected components. | `graph.connectedComponents()` |

##### Spark Streaming Cheat Sheet
| Operation | Description | Example |
|---|---|---|
| `readStream` | Reads data in streaming mode. | `spark.readStream.format("kafka").option("subscribe", "topic").load()` |
| `writeStream` | Writes data in streaming mode. | `stream.writeStream.format("console").start()` |
| `window()` | Windows data for aggregations. | `data.groupBy(window(data.timestamp, "1 hour")).count()` |
| `trigger()` | Sets streaming trigger. | `stream.writeStream.trigger(processingTime='1 minute').start()` |
| `updateStateByKey()` | Maintains state across batches. | `stream.updateStateByKey(updateFunction)` |

##### Spark Configuration and Optimization Cheat Sheet
| Configuration | Description | Recommended Setting |
|---|---|---|
| `spark.executor.memory` | Memory per executor. | e.g., `4g` |
| `spark.sql.shuffle.partitions` | Number of shuffle partitions. | e.g., `200` |
| `spark.default.parallelism` | Default parallelism level. | Depends on cluster |
| `spark.serializer` | Serializer class. | `org.apache.spark.serializer.KryoSerializer` |
| `spark.executor.cores` | Number of cores per executor. | Depends on cluster |

##### Spark Deployment Cheat Sheet
| Deployment Mode | Description | Key Points |
|---|---|---|
| Standalone | Simple cluster manager. | Suitable for static clusters. |
| YARN | Integrates with Hadoop YARN. | Good for Hadoop ecosystems. |
| Mesos | General cluster manager. | Flexible resource sharing. |
| Kubernetes | Container orchestration system. | Suitable for dynamic environments. |

##### Spark Common Operations Cheat Sheet

###### Dataframe Operations
| Operation | Description | Example |
|---|---|---|
| `show()` | Displays rows. | `df.show()` |
| `select()` | Selects columns. | `df.select("col1", "col2")` |
| `filter()` | Filters rows. | `df.filter(df["column"] > 100)` |
| `withColumn()` | Adds/updates a column. | `df.withColumn("new_col", df["column"] + 1)` |
| `drop()` | Removes a column. | `df.drop("column")` |
| `groupBy()` | Groups for aggregation. | `df.groupBy("column").count()` |
| `orderBy()` | Sorts the DataFrame. | `df.orderBy(df["column"].desc())` |
| `join()` | Joins DataFrames. | `df.join(df2, df["id"] == df2["id"])` |
| `union()` | Unions DataFrames. | `df1.union(df2)` |
| `distinct()` | Selects distinct rows. | `df.distinct()` |
| `collect()` | Collects rows. | `df.collect()` |
| `count()` | Counts rows. | `df.count()` |

###### Spark SQL Operations
| Operation | Description | Example |
|---|---|---|
| `createOrReplaceTempView()` | Creates a temp view. | `df.createOr

ReplaceTempView("view")` |
| `sql()` | Executes SQL query. | `spark.sql("SELECT * FROM view")` |

###### Reading and Writing Data
| Operation | Description | Example |
|---|---|---|
| `read.format()` | Reads data in format. | `spark.read.format("csv").option("header", "true").load("path")` |
| `write.format()` | Writes data in format. | `df.write.format("parquet").save("path")` |

###### RDD Operations
| Operation | Description | Example |
|---|---|---|
| `map()` | Applies function. | `rdd.map(lambda x: x * 2)` |
| `filter()` | Filters elements. | `rdd.filter(lambda x: x > 10)` |
| `flatMap()` | Maps to 0 or more elements. | `rdd.flatMap(lambda x: [x, x*2])` |
| `reduce()` | Reduces to single value. | `rdd.reduce(lambda x, y: x + y)` |

###### Configuration and Optimization
| Configuration | Description | Example |
|---|---|---|
| `setAppName()` | Sets application name. | `spark.conf.setAppName("MyApp")` |
| `setMaster()` | Sets master URL. | `spark.conf.setMaster("local[*]")` |
| `getOrCreate()` | Gets or creates SparkSession. | `SparkSession.builder.getOrCreate()` |

###### Miscellaneous
| Operation | Description | Example |
|---|---|---|
| `cache()` | Caches DataFrame. | `df.cache()` |
| `persist()` | Persists with storage level. | `df.persist(StorageLevel.MEMORY_AND_DISK)` |
| `broadcast()` | Broadcasts a variable. | `broadcastVar = spark.sparkContext.broadcast([1, 2, 3])` |
| `accumulator()` | Creates an accumulator. | `acc = spark.sparkContext.accumulator(0)` |


#### Docker cheatsheet

| Task Description                         | Docker Command                                                                                                              |
|------------------------------------------|-----------------------------------------------------------------------------------------------------------------------------|
| **General Commands**                     |                                                                                                                             |
| List all containers (running & stopped)  | `docker ps -a`                                                                                                              |
| Start a container                        | `docker start [container-name-or-id]`                                                                                       |
| Stop a container                         | `docker stop [container-name-or-id]`                                                                                        |
| Remove a container                       | `docker rm [container-name-or-id]`                                                                                          |
| Pull an image                            | `docker pull [image-name]`                                                                                                  |
| Run a container from an image            | `docker run [options] [image-name]`                                                                                         |
| Display Docker version and info          | `docker version` or `docker info`                                                                                           |
| **Network-Specific Commands**            |                                                                                                                             |
| List all networks                        | `docker network ls`                                                                                                         |
| Inspect a network                        | `docker network inspect [network-name]`                                                                                     |
| Create a network                         | `docker network create [network-name]`                                                                                      |
| Remove a network                         | `docker network rm [network-name]`                                                                                          |
| **Attaching/Detaching Networks**         |                                                                                                                             |
| Attach a running container to a network  | `docker network connect [network-name] [container-name-or-id]`                                                               |
| Detach a container from a network        | `docker network disconnect [network-name] [container-name-or-id]`                                                            |
| **Inter-Container Communication**        |                                                                                                                             |
| Ping between two containers              | Use `docker exec [container-name] ping [target-container-ip-or-name]`                                                       |
| **Inspecting Containers and Networks**   |                                                                                                                             |
| Inspect a container                      | `docker inspect [container-name-or-id]`                                                                                     |
| Inspect a container's network settings   | `docker inspect -f '{{.NetworkSettings.Networks}}' [container-name-or-id]`                                                   |
| Inspect a specific network               | `docker network inspect [network-name]`                                                                                     |
| **Container Logs and Monitoring**        |                                                                                                                             |
| View logs of a container                 | `docker logs [container-name-or-id]`                                                                                        |
| Monitor real-time events of Docker       | `docker events`                                                                                                             |
| Display a live stream of container(s) stats | `docker stats [container-name-or-id]`                                                                                      |
---

© D Das  
📧 [das.d@hotmail.com](mailto:das.d@hotmail.com) | [ddasdocs@gmail.com](mailto:ddasdocs@gmail.com)