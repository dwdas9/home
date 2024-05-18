---
layout: default
title: Fabric Q&A
parent: MicrosoftFabric
nav_order: 5
---

1. Which of the following is a key benefit of using Microsoft Fabric in data projects? 

It allows data professionals to work on data projects independently, without the need for collaboration.

It requires duplication of data across different systems and teams to ensure data availability.

It provides a single, integrated environment for data professionals and the business to collaborate on data projects.

Answer: Fabric's OneLake provides a single, integrated environment for data professionals and the business to collaborate on data projects.

2. What is the default storage format for Fabric's OneLake? 

Delta

JSON

CSV

Answer: The default storage format for OneLake is Delta Parquet, an open-source storage layer that brings reliability to data lakes.

3. Which of the following Fabric workloads is used to move and transform data? 

Data Science

Data Warehousing

Data Factory

Answer: The Data Factory workload combines Power Query with the scale of Azure Data Factory to move and transform data.

1. What is a Microsoft Fabric lakehouse? 

A relational database based on the Microsoft SQL Server database engine.

A hierarchy of folders and files in Azure Data Lake Store Gen2.

An analytical store that combines the file storage flexibility of a data lake with the SQL-based query capabilities of a data warehouse.

Answer: Lakehouses combine data lake and data warehouse features.

2. You want to include data in an external Azure Data Lake Store Gen2 location in your lakehouse, without the requirement to copy the data. What should you do? 

Create a Data pipeline that uses a Copy Data activity to load the external data into a file.

Create a shortcut.

Answer: A shortcut enables you to include external data in the lakehou

Create a Dataflow (Gen2) that extracts the data and loads it into a table.
3. You want to use Apache Spark to interactively explore data in a file in the lakehouse. What should you do? 

Create a notebook.

Switch to the SQL analytics endpoint mode.

Create a Dataflow (Gen2).

Answer: A notebook enables interactive Spark coding.

Sure, here are the reformatted questions:

---

### Question 1: Delta Lake Description

Which of the following descriptions best fits Delta Lake?

A. A Spark API for exporting data from a relational database into CSV files.

B. A relational storage layer for Spark that supports tables based on Parquet files.
   
C. A synchronization solution that replicates data between SQL Server and Spark.

   *Answer. Delta Lake provides a relational storage layer in which you can create tables based on Parquet files in a data lake.*

---

### Question 2: Writing a Spark Dataframe to a Delta Table

You've loaded a Spark dataframe with data that you now want to use in a delta table. What format should you use to write the dataframe to storage?

A. CSV

B. PARQUET

C. DELTA
   
   *Answer. Storing a dataframe in DELTA format creates Parquet files for the data and the transaction log metadata necessary for Delta Lake tables.*

---

### Question 3: Dropping a Managed Table in Delta Format

You have a managed table based on a folder that contains data files in delta format. If you drop the table, what happens?

A. The table metadata and data files are deleted.
   
B. The table definition is removed from the metastore, but the data files remain intact.

C. The table definition remains in the metastore, but the data files are deleted.

*Answer. The life-cycle of the metadata and data for a managed table are the same.*

---

1. What is a data pipeline? 

A special folder in OneLake storage where data can be exported from a lakehouse

A sequence of activities to orchestrate a data ingestion or transformation process

A saved Power Query

Answer: A pipeline consists of activities to ingest and transform data.

2. You want to use a pipeline to copy data to a folder with a specified name for each run. What should you do? 

Create multiple pipelines - one for each folder name

Use a Dataflow (Gen2)

Answer: Using a parameter enables greater flexibility for your pipeline.

Add a parameter to the pipeline and use it to specify the folder name for each run
3. You have previously run a pipeline containing multiple activities. What's the best way to check how long each individual activity took to complete? 

Rerun the pipeline and observe the output, timing each activity.

View the run details in the run history.

View the Refreshed value for your lakehouse's default dataset

Answer: The run history details show the time taken for each activity - optionally as a Gantt chart.