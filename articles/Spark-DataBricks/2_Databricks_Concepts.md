---
layout: default
title: DatabricksConcepts
parent: Spark-Databricks
nav_order: 2
has_children: true
---

<details open markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>


# Databricks Architecture
Control Pane: Unity Catalog[Metastore, Access Control, Data Explorer] + Databricks web App, Cluster Manager, Workflow Manager, Jobs, Notebooks
Data Plane: Actual clusters(Compute resources) + Actual Data

Actual clusters - Data Plane
Cluster managers - Control pane
Data plane is where your data is processed. Where the cluseter mahcine stays.

3 Personas: Data Science and Engineering, Analyst, practitoner persona. It changes how your databricks will look.

## Database objects in Databricks

Database objects in Databricks means, Tables and Volumes. Tables store tabular 

# Catalogs and Metastore



### Unity Catalog in Databricks

Unity Catalog in Azure Databricks helps you manage your data by keeping all access control, tracking, and data discovery in one place. It makes it easier to control who can see and use your data, keeps track of data usage, and helps you find the data you need quickly.

**Key Features:**

1. **One-Time Setup for All:** Set up your data access rules once and they work everywhere.
2. **Easy Security:** Use familiar SQL commands to set who can see what.
3. **Automatic Tracking:** Keeps a log of who accessed the data and shows how the data is used.
4. **Find Data Easily:** Tag and search for your data easily.
5. **System Data Access:** Check audit logs and usage details.

**How It’s Organized:**

- **Metastore:** The main place where all data info and access rules are kept.
  - **One Per Region:** Usually set up automatically with a new workspace.
- **Hierarchy:**
  1. **Catalogs:** Big containers for your data, like folders.
  2. **Schemas:** Inside catalogs, like subfolders, holding tables and more.
  3. **Detailed Data:**
     - **Volumes:** Storage for unstructured data.
     - **Tables:** Data organized in rows and columns.
     - **Views:** Saved searches or queries on your tables.
     - **Functions:** Small bits of code that do calculations.
     - **Models:** AI models stored and managed.

This setup makes it simple to manage, secure, and find your data across all your Azure Databricks workspaces.
