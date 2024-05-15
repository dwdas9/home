---
layout: default
title: Fabric Q&A
parent: MicrosoftFabric
nav_order: 3
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