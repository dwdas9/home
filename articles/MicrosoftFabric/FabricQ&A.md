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
  - **Answer:** <span style="color: white"> C. Fabric's OneLake provides a single, integrated environment for data professionals and the business to collaborate on data projects.</span>

- 📌 **What is the default storage format for Fabric's OneLake?**
  - A. Delta
  - B. JSON
  - C. CSV
  - **Answer:** <span style="color: white">A. The default storage format for OneLake is Delta Parquet, an open-source storage layer that brings reliability to data lakes.<span>

- 📌 **Which of the following Fabric workloads is used to move and transform data?**
  - A. Data Science
  - B. Data Warehousing
  - C. Data Factory
  
  **Answer:** <span style="color: white">C. The Data Factory workload combines Power Query with the scale of Azure Data Factory to move and transform data.

- 📌 **What is a Microsoft Fabric lakehouse?**
  - A. A relational database based on the Microsoft SQL Server database engine.
  - B. A hierarchy of folders and files in Azure Data Lake Store Gen2.
  - C. An analytical store that combines the file storage flexibility of a data lake with the SQL-based query capabilities of a data warehouse.
  - **Answer:** <span style="color: white">C. Lakehouses combine data lake and data warehouse features.

- 📌 **You want to include data in an external Azure Data Lake Store Gen2 location in your lakehouse, without the requirement to copy the data. What should you do?**
  - A. Create a Data pipeline that uses a Copy Data activity to load the external data into a file.
  - B. Create a shortcut.
  - C. Create a Dataflow (Gen2) that extracts the data and loads it into a table.

  **Answer:** <span style="color: white">B. A shortcut enables you to include external data in the lakehouse without copying the data.

- 📌 **You want to use Apache Spark to interactively explore data in a file in the lakehouse. What should you do?**
  - A. Create a notebook.
  - B. Switch to the SQL analytics endpoint mode.
  - C. Create a Dataflow (Gen2).
  - **Answer:** <span style="color: white">A. A notebook enables interactive Spark coding.

- 📌**Which of the following descriptions best fits Delta Lake?**

  - A. A Spark API for exporting data from a relational database into CSV files.
  - B. A relational storage layer for Spark that supports tables based on Parquet files.
  - C. A synchronization solution that replicates data between SQL Server and Spark.

  **Answer:** <span style="color: white">B. Delta Lake provides a relational storage layer in which you can create tables based on Parquet files in a data lake.


- 📌 **You have a managed table based on a folder that contains data files in delta format. If you drop the table, what happens?**

  - A. The table metadata and data files are deleted.
  - B. The table definition is removed from the metastore, but the data files remain intact.
  - C. The table definition remains in the metastore, but the data files are deleted.

  **Answer:** <span style="color: white">A. The life-cycle of the metadata and data for a managed table are the same.

- 📌 **What is a data pipeline?**
  - A. A special folder in OneLake storage where data can be exported from a lakehouse
  - B. A sequence of activities to orchestrate a data ingestion or transformation process
  - C. A saved Power Query
  - **Answer:** <span style="color: white">B. A pipeline consists of activities to ingest and transform data.

- 📌 **You want to use a pipeline to copy data to a folder with a specified name for each run. What should you do?**
  - A. Create multiple pipelines - one for each folder name
  - B. Use a Dataflow (Gen2)
  - C. Add a parameter to the pipeline and use it to specify the folder name for each run
  - **Answer:** <span style="color: white">C. Using a parameter enables greater flexibility for your pipeline.

- 📌 **You have previously run a pipeline containing multiple activities. What's the best way to check how long each individual activity took to complete?**
  - A. Rerun the pipeline and observe the output, timing each activity.
  - B. View the run details in the run history.
  - C. View the Refreshed value for your lakehouse's default dataset
  - **Answer:** <span style="color: white">B. The run history details show the time taken for each activity - optionally as a Gantt chart.

- 📌 **What is a Dataflow Gen2?**
  - A. A hybrid database that supports ACID transactions.
  - B. A way to export data to Power BI Desktop.
  - C. A way to import and transform data with Power Query Online.
  - **Answer:** <span style="color: white">C. Dataflow Gen2 allows you to get and transform data, then optionally ingest to a lakehouse.

- 📌 **Which workload experience lets you create a Dataflow Gen2?**
  - A. Real-time analytics.
  - B. Data warehouse.
  - C. Data Factory.
  - **Answer:** <span style="color: white">C. Data Factory and Power BI workloads allow Dataflow Gen2 creation.

- 📌 **You need to connect to and transform data to be loaded into a Fabric lakehouse. You aren't comfortable using Spark notebooks, so decide to use Dataflows Gen2. How would you complete this task?**
  - A. Connect to Data Factory workload > Create a Dataflow Gen2 to transform data > add your lakehouse as the data destination.
  - B. Connect to Real-time Analytics workload > Create Pipeline to copy data > Transform data with an Eventstream.
  - C. Connect to Data Factory workload > Create Pipeline to copy data and load to lakehouse > Transform directly in the lakehouse.
  - **Answer:** <span style="color: white">A. Connect to Data Factory workload > Create a Dataflow Gen2 to transform data > add your lakehouse as the data destination.

- 📌 **Which type of table should an insurance company use to store supplier attribute details for aggregating claims?**
  - A. Fact table.
  - B. Dimension table.
  - C. Staging table.
  - **Correct:** <span style="color: white">B. A dimension table stores attributes used to group numeric measures.

- 📌 **What is a semantic model in the data warehouse experience?**
  - A. A semantic model is a business-oriented data model that provides a consistent and reusable representation of data across the organization.
  - B. A semantic model is a physical data model that describes the structure of the data stored in the data warehouse.
  - C. A semantic model is a machine learning model that is used to make predictions based on data in the data warehouse.
  - **Correct:** <span style="color: white">A. A semantic model in the data warehouse experience provides a way to organize and structure data in a way that is meaningful to business users, enabling them to easily access and analyze data.

- 📌 **What is the purpose of item permissions in a workspace?**
  - A. To grant access to all items within a workspace.
  - B. To grant access to specific columns within a table.
  - C. To grant access to individual warehouses for downstream consumption.
  - **Correct:** <span style="color: white">C. By granting access to a single data warehouse using item permissions, you can enable downstream consumption of data.
Sure, here's the revised version:

📌 **You have access to a historical dataset that contains the monthly expenses of the marketing department. You want to generate predictions of the expenses for the coming month. Which type of machine learning model is needed?**
- A. Classification
  - <span style="color: white">Incorrect. Classification is used when you want to predict a categorical value.
- B. Regression
  - <span style="color: white">Incorrect. Regression is used when you want to predict numerical values.
- **C. Forecasting**
  - <span style="color: white">Correct. Forecasting is used when you want to predict future numerical values based on time-series data.

📌 **Which feature in Microsoft Fabric should you use to review the results of MLflow's tracking through a user interface?**
- A. Notebooks
  - <span style="color: white">Incorrect. You can use MLflow in a notebook to review tracked metrics. However, when working with notebooks you need to write code and don't use a user interface.
- **B. Experiments**
  - <span style="color: white">Correct. Microsoft Fabric's experiments offer a visual user interface to explore the metrics.
- C. Models
  - <span style="color: white">Incorrect. Metrics are only shown when a model is saved.

📌 **Which feature in Microsoft Fabric should you use to accelerate data exploration and cleansing?**
- A. Dataflows
- B. Data Wrangler
- C. Lakehouse
-  <span style="color: white">Correct. Use Data Wrangler to visualize and clean your data.</span>

📌 **Which of the following statements best describes the concept of capacity in Fabric?**

- Capacity refers to a dedicated space for organizations to create, store, and manage Fabric items.

- Capacity defines the ability of a resource to perform an activity or to produce output.

- Capacity is a collection of items that are logically grouped together.

- **Answer:** <span style="color: white">Capacity defines the ability of a resource to perform an activity or to produce output.</span>

📌 **Which of the following statements is true about the difference between promotion and certification in Fabric?**

- Promotion and certification both allow any workspace member to endorse content.

- Promotion requires a higher level of permissions than certification.

- Certification must be enabled in the tenant by the admin, while promotion can be done by a workspace member.

- **Answer:** <span style="color: white">Certification must be enabled in the tenant by the admin, and only designated certifiers can perform the endorsement. In contrast, promotion can be done by any workspace member who has been granted the necessary permissions.</span>

---

📌 **Which of the following sets of layers are typically associated with the Medallion Architecture for data management?**

- Raw, Polished, Refined

- Bronze, Silver, Gold

- Initial, Intermediate, Final

- **Answer:** <span style="color: white">Bronze, silver, gold is the correct sequence of layers typically used in the medallion architecture. Data flows from the raw and unrefined state (bronze) to a curated and validated state (silver), and finally to an enriched and well-structured presentation state (gold).</span>

📌 **Which tool is best suited for data transformation in Fabric when dealing with large-scale data that will continue to grow?**

- Dataflows (Gen2)

- Pipelines

- Notebooks

- **Answer:** <span style="color: white">Notebooks are a more suitable tool for data transformation with big data in Fabric.</span>

📌 **What is the benefit of storing different layers of your lakehouse in separate workspaces?**

- It can enhance security, manage capacity use, and optimize cost-effectiveness.

- It makes it easier to share data with colleagues.

- There's no benefit of storing different layers of your lakehouse in separate workspaces.

- **Answer:** <span style="color: white">Storing different layers of your lakehouse in separate workspaces enhances security and optimizes cost-effectiveness.</span>

---

📌 **What is the benefit of using Fabric notebooks over manual uploads for data ingestion?**

- Notebooks provide an automated approach to ingestion and transformation.

- Notebooks can orchestrate the Copy Data activity and transformations.

- Notebooks offer a user-friendly, low-code experience for large semantic models.

- **Answer:** <span style="color: white">Notebooks provide an automated approach to ingestion and transformation.</span>

📌 **What is the purpose of V-Order and Optimize Write in Delta tables?**

- V-Order and Optimize Write sorts the Delta table when queried with PySpark in a Fabric Notebook.

- V-Order and Optimize Write enhance Delta tables by sorting data and creating fewer, larger Parquet files.

- V-Order and Optimize Write create many small csv files.

- **Answer:** <span style="color: white">V-Order and Optimize Write enhance Delta tables by sorting data and creating fewer, larger Parquet files.</span>

📌 **Why consider basic data cleansing when loading data into Fabric lakehouse?**

- To reduce data load size and processing time.

- To ensure data quality and consistency.

- To enforce data privacy and security measures.

- **Answer:** <span style="color: white">Basic cleaning is done to ensure data quality and consistency before moving on to transformation and modeling steps.</span>

---

📌 **What is the purpose of creating a Reflex in Data Activator?**

- To connect to data sources, monitor conditions, and initiate actions.

- To customize your Fabric experience to Data Activator.

- To navigate between data mode and design mode.

- **Answer:** <span style="color: white">A Reflex item contains all the necessary details to connect to data sources, monitor conditions, and initiate actions for each business segment or process being monitored.</span>

📌 **What is Data Activator's capability in real-time data analysis?**

- Data Activator can only analyze data in batches.

- Data Activator can quickly respond to and analyze data in real-time.

- Data Activator can only analyze data from a single source.

- **Answer:** <span style="color: white">Data Activator is tailored to handle real-time data streams and can distinguish itself through its capability to quickly respond to and analyze data in real-time.</span>

📌 **What is one of Data Activator's strengths in terms of interoperability with other Fabric experiences?**

- Data Activator can ingest data from EventStreams and Power BI reports.

- Data Activator can't ingest data from other Fabric experiences.

- Data Activator can only ingest data from Power BI reports.

- **Answer:** <span style="color: white">One of Data Activator's strengths is its integration capabilities with other Fabric experiences, such as ingesting data from EventStreams and Power BI reports.</span>

---

📌 **You are developing a Microsoft Power BI semantic model. Two tables in the data model are not connected in a physical relationship. You need to establish a virtual relationship between the tables. Which DAX function should you use?**

- CROSSFILTER()

- PATH()

- TREATAS()

- USERELATIONSHIP()

- **Answer:** <span style="color: white">TREATAS() applies the result of a table expression as filters to columns from an unrelated table. USERELATIONSHIP() activates different physical relationships between tables during a query execution. CROSSFILTER() defines the cross filtering direction of a physical relationship. PATH() returns a string of all the members in the column hierarchy.</span>

---

📌 **You have a Fabric workspace that contains a lakehouse named Lakehouse1. A user named User1 plans to use Lakehouse explorer to read Lakehouse1 data. You need to assign a workspace role to User1. The solution must follow the principle of least privilege. Which workspace role should you assign to User1?**

- Admin

- Contributor

- Member

- Viewer

- **Answer:** <span style="color: white">To read the data from a Fabric lakehouse by using Lakehouse explorer, users must be assigned roles of either Admin, Member, or Contributor. However, respecting the least privileged principle, a user must be assigned the Contributor role. The viewer role does not provide permission to read the lakehouse data through Lakehouse explorer.</span>

---

📌 **You have a Fabric tenant that contains a workspace named Workspace1. Workspace1 contains a lakehouse, a data pipeline, a notebook, and several Microsoft Power BI reports. A user named User1 plans to use SQL to access the lakehouse to analyze data. User1 must have the following access: User1 must have read-only access to the lakehouse. User1 must NOT be able to access the rest of the items in Workspace1. User1 must NOT be able to use Spark to query the underlying files in the lakehouse. You need to configure access for User1. What should you do?**

- Add User1 to the workspace as a member, share the lakehouse with User1, and select Read all SQL Endpoint data.

- Add User1 to the workspace as a viewer, share the lakehouse with User1, and select Read all SQL Endpoint data.

- Share the lakehouse with User1 directly and select Build reports on the default dataset.

- Share the lakehouse with User1 directly and select Read all SQL Endpoint data.

- **Answer:** <span style="color: white">Since the user only needs access to the lakehouse and not the other items in the workspace, you should share the lakehouse directly and select Read all SQL Endpoint data. The user should not be added as a member of the workspace. All members of the workspace, even viewers, will be able to open all Power BI reports in the workspace. The SQL analytics endpoint itself cannot be shared directly; the Share options only show for the lakehouse.</span>

---

📌 **You use Microsoft Power BI Desktop to create a Power BI semantic model. You need to recommend a solution to collaborate with another Power BI modeler. The solution must ensure that you can both work on different parts of the model simultaneously. The solution must provide the most efficient and productive way to collaborate on the same model. What should you recommend?**

- Save your work as a PBIX file and email the file to the other modeler.

- Save your work as a PBIX file and publish the file to a Fabric workspace. Add the other modeler as member to the workspace.

- Save your work as a PBIX file to Microsoft OneDrive and share the file with the other modeler.

- Save your work as a Power BI Project (PBIP). Initialize a Git repository with version control.

- **Answer:** <span style="color: white">Saving your Power BI work as a PBIP enables you to save the work as individual plain text files in a simple, intuitive folder structure, which can be checked into a source control system such as Git. This will enable multiple developers to work on different parts of the model simultaneously. Emailing a Power BI model back and forth is not efficient for collaboration. Saving a Power BI model as a PBIX file to OneDrive eases developers access, but only one developer can have the file open at time. Publishing a PBIX file to a shared workspace does not allow multiple developers to work on the model simultaneously.</span>

---

📌 **You have a semantic model that pulls data from an Azure SQL database and is synced via Fabric deployment pipelines to three workspaces named Development, Test, and Production. You need to reduce the

 size of the dataset. Which DAX function should you use to remove unused columns?**

- SELECTCOLUMNS()

- KEEPFILTERS()

- ADDCOLUMNS()

- REMOVECOLUMNS()

- **Answer:** <span style="color: white">Use the SELECTCOLUMNS() function to select columns from a table while preserving the table structure. REMOVECOLUMNS() also removes columns from a table, but should be used only for columns that are not referenced anywhere else in the semantic model.</span>

---

📌 **What is the most cost-effective approach to move data from Azure Data Lake Storage to a lakehouse in Fabric?**

- Use the built-in Data Factory in Fabric to move the data.

- Use a Dataflow Gen2 to move the data.

- Use a Power BI Dataflow to move the data.

- Use a Spark Notebook to move the data.

- **Answer:** <span style="color: white">Using a built-in Data Factory in Fabric can be a cost-effective approach to move the data, providing an integrated and seamless way to handle data transfer within the same platform.</span>

