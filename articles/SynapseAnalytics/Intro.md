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

![alt text](images\image-3.png)

Azure Synapse Analytics is a powerful platform for data integration, storage, and analytics. It has several key components:

1. **Synapse Studio**: This is the main graphical interface for Azure Synapse Analytics. It helps you manage and use the platform. Each Synapse Studio instance comes with an Azure Data Lake Storage (ADLS) container. You can add more containers through linked services.

2. **Linked Services**: These allow you to integrate various data sources like Azure Cosmos DB, SQL Server, and Power Platform Dataverse.

3. **Azure Data Lake**: This is the core storage for Synapse Analytics. Every Synapse has one. When you create a synapse workspace. Azure will create a new storage account for you(with hierachical namespeca enabled automatically) or you will be asked to choose an existing account. But, you need one. Also, synapse assignis your id Storage Blob Data Contributor role in the ADLSG2 account.



4. **Azure Data Factory**: This component is used to ingest and process data within Synapse Analytics.

## Pools in Syanpse Analytics

Think of the term "pool" in as a type of server or warehouse. Although this isn't technically accurate, it helps to understand what a pool does:

- A **built-in serverless SQL pool** Works like an on-demand SQL server. Cheaper and built-in. Fine-tuned to query ADLS data using OPENROWSET.
- A **dedicated SQL pool(sqlxxxxxxx)** A full-fledged large SQL server which stores a data warehouse. Earlier called **SQL Data Warehouse.**
- A **Spark pool(sparkxxxxxxx)** This is a Spark server.

![alt text](images\pools.png)

## Ways to Connect to Azure Synapse Analytics

1. **Azure Linked Service**: Connects to various data sources like Cosmos DB, SQL Server, and Power Platform Dataverse.
2. **Power BI Integration**: Allows seamless integration with Power BI for data visualization and reporting.
3. **Microsoft Purview**: Helps with data governance and management.
4. **Azure Machine Learning**: Enables advanced analytics and machine learning capabilities within Synapse.