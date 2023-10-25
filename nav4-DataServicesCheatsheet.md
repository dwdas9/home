---
layout: default
title: Storage, Data Services Cheatsheets
nav_order: 6
---

## Table of Contents

- [Table of Contents](#table-of-contents)
  - [**Azure Storage And Data Services Cheatsheet**](#azure-storage-and-data-services-cheatsheet)
    - [**Storage Services**](#storage-services)
    - [**Data And Analytics Services**](#data-and-analytics-services)

---

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


---

© D Das  
📧 [das.d@hotmail.com](mailto:das.d@hotmail.com) | [ddasdocs@gmail.com](mailto:ddasdocs@gmail.com)