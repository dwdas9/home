---
layout: default
title: Fabric Q&A
parent: MicrosoftFabric
nav_order: 5
---

- 📌 **Which of the following is a key benefit of using Microsoft Fabric in data projects?**
  - A. It allows data professionals to work on data projects independently, without the need for collaboration.
  - B. It requires duplication of data across different systems and teams to ensure data availability.
  - C. It provides a single, integrated environment for data professionals and the business to collaborate on data projects.
  - **Answer:** C. Fabric's OneLake provides a single, integrated environment for data professionals and the business to collaborate on data projects.

- 📌 **What is the default storage format for Fabric's OneLake?**
  - A. Delta
  - B. JSON
  - C. CSV
  - **Answer:** A. The default storage format for OneLake is Delta Parquet, an open-source storage layer that brings reliability to data lakes.

- 📌 **Which of the following Fabric workloads is used to move and transform data?**
  - A. Data Science
  - B. Data Warehousing
  - C. Data Factory
  - **Answer:** C. The Data Factory workload combines Power Query with the scale of Azure Data Factory to move and transform data.

- 📌 **What is a Microsoft Fabric lakehouse?**
  - A. A relational database based on the Microsoft SQL Server database engine.
  - B. A hierarchy of folders and files in Azure Data Lake Store Gen2.
  - C. An analytical store that combines the file storage flexibility of a data lake with the SQL-based query capabilities of a data warehouse.
  - **Answer:** C. Lakehouses combine data lake and data warehouse features.

- 📌 **You want to include data in an external Azure Data Lake Store Gen2 location in your lakehouse, without the requirement to copy the data. What should you do?**
  - A. Create a Data pipeline that uses a Copy Data activity to load the external data into a file.
  - B. Create a shortcut.
  - C. Create a Dataflow (Gen2) that extracts the data and loads it into a table.
  - **Answer:** B. A shortcut enables you to include external data in the lakehouse without copying the data.

- 📌 **You want to use Apache Spark to interactively explore data in a file in the lakehouse. What should you do?**
  - A. Create a notebook.
  - B. Switch to the SQL analytics endpoint mode.
  - C. Create a Dataflow (Gen2).
  - **Answer:** A. A notebook enables interactive Spark coding.

- 📌**Which of the following descriptions best fits Delta Lake?**

  - A. A Spark API for exporting data from a relational database into CSV files.
  - B. A relational storage layer for Spark that supports tables based on Parquet files.
  - C. A synchronization solution that replicates data between SQL Server and Spark.

  **Answer:** B. Delta Lake provides a relational storage layer in which you can create tables based on Parquet files in a data lake.


- 📌 **You have a managed table based on a folder that contains data files in delta format. If you drop the table, what happens?**

  - A. The table metadata and data files are deleted.
  - B. The table definition is removed from the metastore, but the data files remain intact.
  - C. The table definition remains in the metastore, but the data files are deleted.

  **Answer:** A. The life-cycle of the metadata and data for a managed table are the same.

- 📌 **What is a data pipeline?**
  - A. A special folder in OneLake storage where data can be exported from a lakehouse
  - B. A sequence of activities to orchestrate a data ingestion or transformation process
  - C. A saved Power Query
  - **Answer:** B. A pipeline consists of activities to ingest and transform data.

- 📌 **You want to use a pipeline to copy data to a folder with a specified name for each run. What should you do?**
  - A. Create multiple pipelines - one for each folder name
  - B. Use a Dataflow (Gen2)
  - C. Add a parameter to the pipeline and use it to specify the folder name for each run
  - **Answer:** C. Using a parameter enables greater flexibility for your pipeline.

- 📌 **You have previously run a pipeline containing multiple activities. What's the best way to check how long each individual activity took to complete?**
  - A. Rerun the pipeline and observe the output, timing each activity.
  - B. View the run details in the run history.
  - C. View the Refreshed value for your lakehouse's default dataset
  - **Answer:** B. The run history details show the time taken for each activity - optionally as a Gantt chart.

- 📌 **What is a Dataflow Gen2?**
  - A. A hybrid database that supports ACID transactions.
  - B. A way to export data to Power BI Desktop.
  - C. A way to import and transform data with Power Query Online.
  - **Answer:** C. Dataflow Gen2 allows you to get and transform data, then optionally ingest to a lakehouse.

- 📌 **Which workload experience lets you create a Dataflow Gen2?**
  - A. Real-time analytics.
  - B. Data warehouse.
  - C. Data Factory.
  - **Answer:** C. Data Factory and Power BI workloads allow Dataflow Gen2 creation.

- 📌 **You need to connect to and transform data to be loaded into a Fabric lakehouse. You aren't comfortable using Spark notebooks, so decide to use Dataflows Gen2. How would you complete this task?**
  - A. Connect to Data Factory workload > Create a Dataflow Gen2 to transform data > add your lakehouse as the data destination.
  - B. Connect to Real-time Analytics workload > Create Pipeline to copy data > Transform data with an Eventstream.
  - C. Connect to Data Factory workload > Create Pipeline to copy data and load to lakehouse > Transform directly in the lakehouse.
  - **Answer:** A. Connect to Data Factory workload > Create a Dataflow Gen2 to transform data > add your lakehouse as the data destination.

- 📌 **Which type of table should an insurance company use to store supplier attribute details for aggregating claims?**
  - A. Fact table.
  - B. Dimension table.
  - C. Staging table.
  - **Correct:** B. A dimension table stores attributes used to group numeric measures.

- 📌 **What is a semantic model in the data warehouse experience?**
  - A. A semantic model is a business-oriented data model that provides a consistent and reusable representation of data across the organization.
  - B. A semantic model is a physical data model that describes the structure of the data stored in the data warehouse.
  - C. A semantic model is a machine learning model that is used to make predictions based on data in the data warehouse.
  - **Correct:** A. A semantic model in the data warehouse experience provides a way to organize and structure data in a way that is meaningful to business users, enabling them to easily access and analyze data.

- 📌 **What is the purpose of item permissions in a workspace?**
  - A. To grant access to all items within a workspace.
  - B. To grant access to specific columns within a table.
  - C. To grant access to individual warehouses for downstream consumption.
  - **Correct:** C. By granting access to a single data warehouse using item permissions, you can enable downstream consumption of data.
