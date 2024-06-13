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
  - [Synapse Spark Pool](#synapse-spark-pool)
  - [Pipelines](#pipelines)
  - [Integration Datasets](#integration-datasets)
  - [Integration runtime](#integration-runtime)

![alt text](Background.png)

## <span style="color: BlueViolet">The Core Concepts of Synapse Analytics</span>

Here are the building blocks of Azure Synapse Analytics

### <span style="color: DarkCyan">Synapse Workspace</span>

- It's a shared space where you can do data engineering and data science work.

> **Remember**: A Synapse workspace must be connected to a storage account (ADLS Gen2) and a file system (container inside that ADLS Gen2).
<img src="image.png" alt="Integration runtime registration" style="
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

### <span style="color: DarkCyan">Linked Services</span>

These are just connection strings used by the Synapse workspace to connect to external resources.

<img src="image-1.png" alt="Integration runtime registration" style="
    border: 2px solid gray;
    border-radius: 6px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    margin: 20px;
    padding: 1px;
    width: auto; /* Maintain aspect ratio */
    height: auto; /* Maintain aspect ratio */
    transition: transform 0.2s;
" onmouseover="this.style.transform='scale(2)'" onmouseout="this.style.transform='scale(1)'"/>

### <span style="color: DarkCyan">Synapse SQL Pools</span>

Synapse SQL gives you two SQL products: a dedicated SQL Warehouse (Large SQL Server) and an on-demand SQL query running engine.

<img src="ownstoragesynapse.png" alt="Integration runtime registration" style="
    border: 2px solid gray;
    border-radius: 6px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    margin: 20px;
    padding: 1px;
    width: auto; /* Maintain aspect ratio */
    height: auto; /* Maintain aspect ratio */
    transition: transform 0.2s;
" onmouseover="this.style.transform='scale(2)'" onmouseout="this.style.transform='scale(1)'"/>

**Serverless Pool:** Just an on-demand SQL query running engine.

- Just a query running engine.
- On-demand: Only pay for the queries you run. It stays online, but don’t worry. You don’t pay anything until you run something.
- Doesn’t have its own storage: Doesn’t store anything. It only runs queries in ADLS, etc.
- Cheap: Very cheap. $0 if you don’t run a single SQL query.


<img src="image-2.png" alt="Integration runtime registration" style="
    border: 2px solid gray;
    border-radius: 6px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    margin: 20px;
    padding: 1px;
    width: auto; /* Maintain aspect ratio */
    height: auto; /* Maintain aspect ratio */
    transition: transform 0.2s;
" onmouseover="this.style.transform='scale(2)'" onmouseout="this.style.transform='scale(1)'"/>

**Dedicated Pool (AKA SQL DW):** A full SQL Warehouse (a large SQL server) that you own. This means there is a traditional, old-school SQL database with real, dedicated storage, just like the good old MSSQL Server, not just some abstract storage solution using ADLS (no insults to Serverless Pool ;-). It’s the poor man’s engine).

- **Full-blown SQL Warehouse**: Just a few years ago, it was called SQL Data Warehouse.
- **<span style="color:blue;">Own local storage, not international calls to ADLS</span>**: It has its own storage, just like SQL Server. No, it’s not ADLS; it’s real SQL storage.
- **<span style="color:blue;">Once on, you pay by the hour</span>**: Since it’s dedicated, Microsoft covers the hardware costs for your dedicated SQL server. Whether you use it or not, you pay by the hour, and it’s quite expensive. Run it for a day, and your full trial subscription might be gone.

<img src="image-3.png" alt="Integration runtime registration" style="
    border: 2px solid gray;
    border-radius: 6px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    margin: 20px;
    padding: 1px;
    width: auto; /* Maintain aspect ratio */
    height: auto; /* Maintain aspect ratio */
    transition: transform 0.2s;
" onmouseover="this.style.transform='scale(2)'" onmouseout="this.style.transform='scale(1)'"/>

### <span style="color: DarkCyan">Synapse Spark Pool</span>

<img src="image-4.png" alt="Integration runtime registration" style="
    border: 2px solid gray;
    border-radius: 6px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    margin: 20px;
    padding: 1px;
    width: auto; /* Maintain aspect ratio */
    height: auto; /* Maintain aspect ratio */
    transition: transform 0.2s;
" onmouseover="this.style.transform='scale(2)'" onmouseout="this.style.transform='scale(1)'"/>

- It's just an Apache Spark cluster behind the scenes.
- If you want to run a Spark job or Spark query, you use it.
- You can write your Spark logic in PySpark, SparkSQL, Scala, or even C#.
- There are two ways to run Spark code in Synapse:
  - **Spark Notebooks:** Like Jupyter notebooks.
  - **Spark Job Definitions:** For running batch Spark jobs using jar files.

### <span style="color: DarkCyan">Pipelines</span>

- These are just Azure Data Factory pipelines. They are ETL (Extract, Transform, Load) pipelines.

> An activity is a task you want to perform. A pipeline is a group of activities, like copying data or running a notebook.

- **Data Flows:** A type of activity that lets you create transformations in a no-code manner using graphics. It runs on **Spark behind the scenes**.
- **Triggers:** To execute pipelines on a schedule.

<img src="image-5.png" alt="Integration runtime registration" style="
    border: 2px solid gray;
    border-radius: 6px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    margin: 20px;
    padding: 1px;
    width: auto; /* Maintain aspect ratio */
    height: auto; /* Maintain aspect ratio */
    transition: transform 0.2s;
" onmouseover="this.style.transform='scale(2)'" onmouseout="this.style.transform='scale(1)'"/>

### <span style="color: DarkCyan">Integration Datasets</span>

These are pointers to your data. They are required when you create an activity like a Copy activity.

- Tell me where the data is? In a blob storage.
- What is the format? CSV.
- Tell me the connection string (Linked service) to that file/folder.

<img src="image-6.png" alt="Integration runtime registration" style="
    border: 2px solid gray;
    border-radius: 6px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    margin: 20px;
    padding: 1px;
    width: auto; /* Maintain aspect ratio */
    height: auto; /* Maintain aspect ratio */
    transition: transform 0.2s;
" onmouseover="this.style.transform='scale(2)'" onmouseout="this.style.transform='scale(1)'"/>

### [Integration runtime](IntegrationRuntime.html)

Copying data is one of the main activities in Synapse and ADF. The main tool used for this is **Integration Runtime**. It's like a **bridge** that connects Synapse and ADF with data from on-premises and external sources.

There are **3 types** of Integration Runtime:

1. **Azure Integration Runtime:** This is used to copy data within Azure or between cloud services.
2. **Self-hosted Integration Runtime:** This is the bridge to copy data from your local machine to the Azure cloud. It is a software you install on your local computer.
3. **Azure-SSIS Integration Runtime:** This allows you to lift and shift your SSIS packages to Azure.