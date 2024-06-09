---
layout: default
title: Intro To Synapse
parent: SynapseAnalytics
nav_order: 1
---

- [What is it?](#what-is-it)
- [Main software compoenents of Synapse analytics](#main-software-compoenents-of-synapse-analytics)
- [Pools in Syanpse Analytics](#pools-in-syanpse-analytics)
- [Ways to Connect to Azure Synapse Analytics](#ways-to-connect-to-azure-synapse-analytics)
- [Summary](#summary)
  - [Data Types and Definitions](#data-types-and-definitions)
  - [Data Operations](#data-operations)
  - [Data Pipelines](#data-pipelines)
  - [Data Lake](#data-lake)
  - [Data Warehouse](#data-warehouse)
  - [Languages Used](#languages-used)
  - [Apache Spark](#apache-spark)
- [Data lakes vs. data lakehouses vs. data warehouses](#data-lakes-vs-data-lakehouses-vs-data-warehouses)

## What is it?

- Unified analytics platform
- Serverless and dedicated options
- Enterprise data warehouse
- Data lake exploration
- Code-free hybrid data integration
- Deeply integrated Apache Spark and SQL engines
- Cloud-native HTAP
- Choice of language (T-SQL, Python, Scala, SparkSQL, & .NET)
- Integrated AI and BI

## Main software compoenents of Synapse analytics

![alt text](image-3.png)

Azure Synapse Analytics is a powerful platform for data integration, storage, and analytics. It has several key components:

1. **Synapse Studio**: This is the main graphical interface for Azure Synapse Analytics. It helps you manage and use the platform. Each Synapse Studio instance comes with an Azure Data Lake Storage (ADLS) container. You can add more containers through linked services.

2. **Linked Services**: These allow you to integrate various data sources like Azure Cosmos DB, SQL Server, and Power Platform Dataverse.

3. **Azure Data Lake**: This is the core storage for Synapse Analytics. Every Synapse has one. When you create a synapse workspace. Azure will create a new storage account for you(with hierachical namespeca enabled automatically) or you will be asked to choose an existing account. But, you need one. Also, synapse assignis your id Storage Blob Data Contributor role in the ADLSG2 account.

![alt text](image-4.png)

4. **Azure Data Factory**: This component is used to ingest and process data within Synapse Analytics.

## Pools in Syanpse Analytics

Think of the term "pool" in as a type of server or warehouse. Although this isn't technically accurate, it helps to understand what a pool does:

- A **built-in serverless SQL pool** Works like an on-demand SQL server. Cheaper and built-in. Fine-tuned to query ADLS data using OPENROWSET.
- A **dedicated SQL pool(sqlxxxxxxx)** A full-fledged large SQL server which stores a data warehouse. Earlier called **SQL Data Warehouse.**
- A **Spark pool(sparkxxxxxxx)** This is a Spark server.

![alt text](pools.png)

## Ways to Connect to Azure Synapse Analytics

1. **Azure Linked Service**: Connects to various data sources like Cosmos DB, SQL Server, and Power Platform Dataverse.
2. **Power BI Integration**: Allows seamless integration with Power BI for data visualization and reporting.
3. **Microsoft Purview**: Helps with data governance and management.
4. **Azure Machine Learning**: Enables advanced analytics and machine learning capabilities within Synapse.

## Summary
### Data Types and Definitions

**Structured Data:** 
- Data in table format with rows and columns. 
- Sources: SQL Server, .csv files, Excel.

**Semi-structured Data:** 
- Data with some structure but not like a table, e.g., JSON files.
- Needs adjustments to become structured.

**Unstructured Data:** 
- Data without a specific format, like PDF files.

**Operational Data:** 
- Fresh data from operations, stored in SQL DB (e.g., Amazon daily sales).

**Analytical Data:** 
- Cleaned data for reports, usually in a warehouse.
- Data engineers convert operational data to analytical data.

### Data Operations

**Data Integration:** 
- Connecting different data sources.
- The first step to link different data sources.

**Data Transformation:** 
- Cleaning and organizing data to make it ready for use.
- Involves cleaning, sorting, and aligning data.

**Data Consolidation:** 
- Combining data from multiple sources into one place to avoid silos.

### Data Pipelines

- Workflows to ingest, transform, and export data.

### Data Lake

**Definition:**
- A storage place where any data stays in its natural format as files or blobs.
- Data begins its journey here.
- Very cheap to store data.
- Acts as a collection point of data.

**Popular Brands:**
- Azure Data Lake Storage G2
- Databricks DataLake
- Snowflake
- Amazon S3/Lakeformation
- Google Biglake
- Dermio Lakehouse
- Starbrust Data Lakehouse
- Cloudera Data Platform
- Teradata Vantage Cloud
- Oracle Cloud Infra
- Vertica Unified Analytics Platform

### Data Warehouse

**Definition:**
- Structured data storage with disciplined, large capacity.
- Comparable to the sun compared to the earth (SQL server).

**Popular Brands:**
- Azure Synapse
- Snowflake
- Google BigQuery
- Amazon Redshift
- IBM Db2 Warehouse
- Firebolt

### Languages Used

**SQL:**
- The main language for data tasks.
- Widely used for all data-related work.

**Python:**
- A popular language with many libraries for data work.
- Very useful for data operations.

**Other Languages:**
- Scala, R, .NET, and more.
- Used for various data tasks.

### Apache Spark

- Open-source big data engine.
- Handles batch and real-time processing.
- Started at UC Berkeley in 2009.
- Enhances Hadoop for interactive queries and streaming.
- Supports Java, Scala, Python, and R.
- Includes libraries for machine learning, stream, and graph processing.
- Core handles task distribution, scheduling, and I/O.
- Uses RDD for easy data handling.
- Efficiently processes data across server clusters.


**Main Tools for Azure Data Engineering:**
- Azure Synapse Analytics
- Azure Data Lake Storage Gen2
- Azure Stream Analytics
- Azure Data Factory
- Azure Databricks

**Things to Remember:**
- Data in a relational database is ALWAYS structured.
- In a data lake, data is stored as files.

**Quiz:**
Which Azure service provides capabilities for running data pipelines AND managing analytical data in a data lake or relational data warehouse?

**Answer**: Azure Synapse Analytics.

## Data lakes vs. data lakehouses vs. data warehouses

| Feature             | Data Lake                                                   | Data Lakehouse                                               | Data Warehouse                                              |
|---------------------|-------------------------------------------------------------|--------------------------------------------------------------|-------------------------------------------------------------|
| **Types of data**   | All types: Structured data, semi-structured data, unstructured (raw) data | All types: Structured data, semi-structured data, unstructured (raw) data | Structured data only                                        |
| **Cost**            | $                                                           | $                                                            | $$$                                                         |
| **Format**          | Open format                                                 | Open format                                                  | Closed, proprietary format                                  |
| **Scalability**     | Scales to hold any amount of data at low cost, regardless of type | Scales to hold any amount of data at low cost, regardless of type | Scaling up becomes exponentially more expensive due to vendor costs |
| **Intended users**  | Limited: Data scientists                                    | Unified: Data analysts, data scientists, machine learning engineers | Limited: Data analysts                                      |
| **Reliability**     | Low quality, data swamp                                     | High quality, reliable data                                  | High quality, reliable data                                 |
| **Ease of use**     | Difficult: Exploring large amounts of raw data can be difficult without tools to organize and catalog the data | Simple: Provides simplicity and structure of a data warehouse with the broader use cases of a data lake | Simple: Structure of a data warehouse enables users to quickly and easily access data for reporting and analytics |
| **Performance**     | Poor                                                        | High                                                         | High                                                        |