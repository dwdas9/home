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

