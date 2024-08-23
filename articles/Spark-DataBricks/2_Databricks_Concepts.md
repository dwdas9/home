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
- **Control Plane**: This is where all the management happens. It includes the Databricks web app, Unity Catalog, Cluster Manager, Workflow Manager, Jobs, Notebooks, etc. Think of it as the control center where you manage everything.

- **Data/Compute Plane**: This is where the actual work gets done. It has the clusters and the data. The Data Plane is where your data is processed, and where the machines that do the work are located.
  - **Serverless Compute Plane**: Here, everything is managed inside the Databricks account, even though the actual servers are in Azure, AWS, or GCP.
  - **Classic Compute Plane**: In this setup, the servers are mainly managed from your cloud account (like Azure, AWS, or GCP).

- **Personas**: This is the look and feel of your Databricks web UI. There are different personas like Data Science and Engineering, Analyst, and Practitioner, each giving you a different experience based on what you do.

> Databricks is like the **Uber of Apache Spark**. It doesn't own any servers; it just runs on the cloud with your subscription. Both Databricks and Microsoft/Google takes a cut from the bill :-) Well played, Databricks—take open-source, add some sauce, use cloud infrastructure, and make money! Honestly, running a Spark cluster on HDInsight is way more cost-effective. At least there, you're not paying extra for the open-source and that Databricks sauce.


## Databricks Clusters

- Databricks has two types of clusters: 
  - **All-purpose:** Mainly for interactive work. Like, you want to run cells and see what's happening. Many users can use an all-purpose cluster.
  - **Job:** When things don't need any interaction. To run jobs.

- And two modes of clusters
  - **Standard(Multi-mode):** THis is the default mode. Has at-least two VMS - one master, one worker.
  - **Single node:** Low cost. Only one node. Say for some curious student.

- Runtime has three versions
  - **Standard:** Normal spark and normal stuff.
  - **Machine Learning:** Has some useful machine learning libraries installed
  - **Photon**: Has some speed for SQL

- And Access mode
  - Single User is always there
  - Shared mode is for Premium plan. Has unity Catalog
  - 