---
layout: default
title: Core Concepts
parent: SynapseAnalytics
nav_order: 1
---
- [The Core Concepts of Synapse Analytics](#the-core-concepts-of-synapse-analytics)
  - [Synapse Workspace](#synapse-workspace)
  - [Linked Services](#linked-services)
  - [Synapse SQL Pools](#synapse-sql-pools)
    - [Serverless SQL Pool](#serverless-sql-pool)
    - [Dedicated Pool (AKA SQL DW)](#dedicated-pool-aka-sql-dw)
  - [Synapse Spark Pool](#synapse-spark-pool)
  - [Pipelines](#pipelines)
  - [Integration Datasets](#integration-datasets)
  - [Integration runtime](#integration-runtime)

![alt text](images/ownstoragesynapse.png)

# <span style="color: BlueViolet">The Core Concepts of Synapse Analytics</span>

Here are the building blocks of Azure Synapse Analytics

## <span style="color: DarkCyan">Synapse Workspace</span>

- It is like the IDE for Synapse.

> **Remember**: A Synapse workspace must be connected to a storage account (ADLS Gen2) and a file system (container inside that ADLS Gen2). At the time of creating a workspace you are asked to choose or create a new ADLS account and a container inside it

<img src="images\image-4.png" style="
    border: 2px solid gray;
    border-radius: 6px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    margin: 20px;
    padding: 1px;
    width: auto; /* Maintain aspect ratio */
    height: auto; /* Maintain aspect ratio */
    transition: transform 0.2s;
" onmouseover="this.style.transform='scale(2)'" onmouseout="this.style.transform='scale(1)'"/>

You can see the connected ADLS storage from Data tab/Linked area.

<img src="images/image2112.png"  style="
    border: 2px solid gray;
    border-radius: 6px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    margin: 20px;
    padding: 1px;
    width: auto; /* Maintain aspect ratio */
    height: auto; /* Maintain aspect ratio */
    transition: transform 0.2s;
" onmouseover="this.style.transform='scale(2)'" onmouseout="this.style.transform='scale(1)'"/>

- Your workspace can perform analytics using SQL or Apache Spark. The term 'Pool' is used for this. It's just the name for the application. For traditional users, 'Pool' might sound like a new technology, but it's simply the runtime infrastructure.

## <span style="color: DarkCyan">Linked Services</span>

These are just connection strings used by the Synapse workspace to connect to external resources.
<img src="images/image-12244.png"  style="
    border: 2px solid gray;
    border-radius: 6px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    margin: 20px;
    padding: 1px;
    width: auto; /* Maintain aspect ratio */
    height: auto; /* Maintain aspect ratio */
    transition: transform 0.2s;
" onmouseover="this.style.transform='scale(2)'" onmouseout="this.style.transform='scale(1)'"/>

## <span style="color: DarkCyan">Synapse SQL Pools</span>

Synapse SQL gives you two SQL products: a dedicated SQL Warehouse (Large SQL Server) and an on-demand SQL query running engine.

<img src="images/ownstoragesynapse.png"  style="
    border: 2px solid gray;
    border-radius: 6px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    margin: 20px;
    padding: 1px;
    width: auto; /* Maintain aspect ratio */
    height: auto; /* Maintain aspect ratio */
    transition: transform 0.2s;
" onmouseover="this.style.transform='scale(2)'" onmouseout="this.style.transform='scale(1)'"/>

### <span style="color: DodgerBlue">Serverless SQL Pool</span>

Just an SQL query running engine.

- Just a query running engine.
- On-demand: Only pay for the queries you run. It stays online, but don’t worry. You don’t pay anything until you run something.
- Doesn’t have its own storage: Doesn’t store anything. It only runs queries in ADLS, etc.
- Cheap: Very cheap. $0 if you don’t run a single SQL query.


<img src="images/image-23244.png"  style="
    border: 2px solid gray;
    border-radius: 6px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    margin: 20px;
    padding: 1px;
    width: auto; /* Maintain aspect ratio */
    height: auto; /* Maintain aspect ratio */
    transition: transform 0.2s;
" onmouseover="this.style.transform='scale(2)'" onmouseout="this.style.transform='scale(1)'"/>

### <span style="color: DodgerBlue">Dedicated Pool (AKA SQL DW)</span>

A full SQL Warehouse (a large SQL server) that you own. This means there is a traditional, old-school SQL database with real, dedicated storage, just like the good old MSSQL Server, not just some abstract storage solution using ADLS (no insults to Serverless Pool ;-). It’s the poor man’s engine).

- **Full-blown SQL Warehouse**: Just a few years ago, it was called SQL Data Warehouse.
- **<span style="color:blue;">Own local storage, not international calls to ADLS</span>**: It has its own storage, just like SQL Server. No, it’s not ADLS; it’s real SQL storage.
- **<span style="color:blue;">Once on, you pay by the hour</span>**: Since it’s dedicated, Microsoft covers the hardware costs for your dedicated SQL server. Whether you use it or not, you pay by the hour, and it’s quite expensive. Run it for a day, and your full trial subscription might be gone.

<img src="images/UOOOUO.png"  style="
    border: 2px solid gray;
    border-radius: 6px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    margin: 20px;
    padding: 1px;
    width: auto; /* Maintain aspect ratio */
    height: auto; /* Maintain aspect ratio */
    transition: transform 0.2s;
" onmouseover="this.style.transform='scale(2)'" onmouseout="this.style.transform='scale(1)'"/>

## <span style="color: FireBrick">Synapse Spark Pool</span>

Synapse gives you a ready-to-use Apache Spark environment called a Serverless Spark Pool. It's like the Serverless SQL Pool, meaning you only pay when you use it. In the background, it's a Spark cluster, but it's called a Pool. In Databricks, you create a Spark cluster for a Spark environment. In Synapse, you create a Spark Pool. The end result is the same.

**Points to Remember:**
- It's just an Apache Spark cluster behind the scenes.
- Use it to run Spark jobs or Spark queries.
- You can write Spark logic in PySpark, SparkSQL, Scala, or even C#.
- There are two ways to run Spark code in Synapse:
  - **Spark Notebooks:** Like Jupyter notebooks.
  - **Spark Job Definitions:** For running batch Spark jobs using jar files.

<img src="images/custom-image-2024-06-14-01-42-31.png"  style="
    border: 2px solid gray;
    border-radius: 6px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    margin: 20px;
    padding: 1px;
    width: auto; /* Maintain aspect ratio */
    height: auto; /* Maintain aspect ratio */
    transition: transform 0.2s;
" onmouseover="this.style.transform='scale(2)'" onmouseout="this.style.transform='scale(1)'"/>

## <span style="color: DarkCyan">Pipelines</span>

Pipelines in Synapse are the same as Azure Data Factory Pipelines. They are 100% identical.

An activity is a task you want to perform. A pipeline is a group of activities, like copying data or running a notebook.

**Points to Remember:**
- Syapse Pipelines is actually ADF.
- Pipelines are collections of activities (tasks like copying data, running a notebook, etc.).
- **Data Flows:** A type of activity that lets you create transformations without code using graphics. It runs on **Spark behind the scenes**.
- **Triggers:** To execute pipelines on a schedule.

<img src="images/image-5333.png"  style="
    border: 2px solid gray;
    border-radius: 6px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    margin: 20px;
    padding: 1px;
    width: auto; /* Maintain aspect ratio */
    height: auto; /* Maintain aspect ratio */
    transition: transform 0.2s;
" onmouseover="this.style.transform='scale(2)'" onmouseout="this.style.transform='scale(1)'"/>

## <span style="color: DarkCyan">Integration Datasets</span>

These are pointers to your data. They are required when you create an activity like a Copy activity.

![alt text](linkedservice.png)

- Tell me where the data is? In a blob storage.
- What is the format? CSV.
- Tell me the connection string (Linked service) to that file/folder.

You create it from the Data section in Synapse.

<img src="images/image-633343.png"  style="
    border: 2px solid gray;
    border-radius: 6px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    margin: 20px;
    padding: 1px;
    width: auto; /* Maintain aspect ratio */
    height: auto; /* Maintain aspect ratio */
    transition: transform 0.2s;
" onmouseover="this.style.transform='scale(2)'" onmouseout="this.style.transform='scale(1)'"/>

## [Integration runtime](IntegrationRuntime.html)

Copying data is one of the main activities in Synapse and ADF. The main tool used for this is **Integration Runtime**. It's like a **bridge** that connects Synapse and ADF with data from on-premises and external sources.

There are **3 types** of Integration Runtime:

1. **Azure Integration Runtime:** This is used to copy data within Azure or between cloud services.
2. **Self-hosted Integration Runtime:** This is the bridge to copy data from your local machine to the Azure cloud. It is a software you install on your local computer.
3. **Azure-SSIS Integration Runtime:** This allows you to lift and shift your SSIS packages to Azure.

