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


## Setting Up Azure Databricks

Azure Databricks is a cloud-based platform built around Apache Spark, the popular open-source, parallel-processing framework. Let's walk through the steps to set it up:

### 1. **Log into the Azure Portal**

Before you start, make sure you have an Azure account. If not, sign up for one. Once you have an account, log into the [Azure Portal](https://portal.azure.com/).

### 2. **Create a Databricks Workspace**

- In the Azure Portal, click on "+ Create a resource".
- In the search box, type "Databricks" and select "Azure Databricks" from the list.
- Click the "Create" button.

### 3. **Configure the Workspace**

You'll need to provide:

- **Subscription**: Choose the Azure subscription you want to use.
- **Resource Group**: You can create a new one or use an existing resource group.
- **Workspace Name**: Give your Databricks workspace a name.
- **Region**: Select a region close to you or your target audience.
- **Pricing Tier**: Choose between "Standard" or "Premium". For most users, "Standard" is enough to start with.

Click "Review + Create", then "Create" once you've reviewed your settings.

### 4. **Launch the Workspace**

After Azure has finished setting up Databricks, go to the Azure Databricks service in the portal and click on "Launch Workspace". This will open the Databricks portal.

### 5. **Set Up a Cluster**

Before you can run any Spark code, you need a cluster:

- Inside the Databricks workspace, navigate to "Clusters" on the sidebar.
- Click on "+ Create Cluster".
- Give your cluster a name, select a runtime version, and choose the type and number of machines you want. For beginners, the default settings are usually sufficient.
- Click "Create Cluster".

### 6. **Create a Notebook**

Now you can write and run Spark code:

- Go to "Workspace", select "Create", and then "Notebook".
- Give it a name, select the language (Python, Scala, etc.), and link it to the cluster you created.

You can now start writing and executing Spark code in your notebook!

### 7. **Clean Up Resources**

To avoid unnecessary charges:

- Remember to terminate clusters when not in use. They will consume resources and can lead to unexpected costs.
- If you're done experimenting with Databricks, consider deleting the resource in the Azure Portal.

# Architecture
Control Pane: Unity Catalog[Metastore, Access Control, Data Explorer] + Databricks web App, Cluster Manager, Workflow Manager, Jobs, Notebooks
Data Plane: Actual clusters(Compute resources) + Actual Data

Actual clusters - Data Plane
Cluster managers - Control pane
Data plane is where your data is processed. Where the cluseter mahcine stays.

3 Personas: Data Science and Engineering, Analyst, practitoner persona. It changes how your databricks will look.

# Notebook magic commands

%python, %sql
%sh(only master node)
%pip
%run execute a remote notebook from this notebook

# dbutils

dbutils.fs.ls()
dbutils.secrets.get()
dbutils.notebook.run()
dbutils.widget.text()
dbutils.jobs.taskValues.set()

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
