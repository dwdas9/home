---
layout: default
title: Misc Data Engineering Articles
nav_order: 2
---

## Table of Contents
- [Overview](#overview)
  - [Setting Up Azure Databricks](#setting-up-azure-databricks)
  - [A Step-by-Step Guide to Connect Standalone Spark with Azure Data Lake](#a-step-by-step-guide-to-connect-standalone-spark-with-azure-data-lake)
  - [A Step-by-Step Guide to work with Azure Data Lake Containers using Standalone Spark](#a-step-by-step-guide-to-work-with-azure-data-lake-containers-using-standalone-spark)
  - [How to use a simple local Python code to rearrange Azure Blob storage files into a hierarchical structure](#how-to-use-a-simple-local-python-code-to-rearrange-azure-blob-storage-files-into-a-hierarchical-structure)
  - [Python dummy data inserter into SQL Server](#python-dummy-data-inserter-into-sql-server)
  - [Install Spark/Pyspark in the Anaconda Ecosystem](#install-sparkpyspark-in-the-anaconda-ecosystem)
  - [Setting up a Dockerized Spark Environment on Ubuntu for Windows](#setting-up-a-dockerized-spark-environment-on-ubuntu-for-windows)
  - [Managing Python in System PATH Using PowerShell](#managing-python-in-system-path-using-powershell)
  - [Unable to run `docker ps` despite having docker installed?](#unable-to-run-docker-ps-despite-having-docker-installed)

# Overview
In this section, I'll share articles that may prove valuable for your daily tasks in data engineering and associated domains.

---

## Setting Up Azure Databricks

In this article, I will walk you through the steps to set up your Azure Databricks workspace, create clusters, and begin working with notebooks.[Read more...](articles/AzureDE/dbrk_setup/1_Setup-Azure-Databricks.html)

---

## A Step-by-Step Guide to Connect Standalone Spark with Azure Data Lake

While Azure Databricks effortlessly links with ADLS thanks to shared Azure Directory infrastructure, standalone Spark setups demand meticulous JAR dependencies management in the site-packages directory. This guide walks you through connecting ADLS from standalone Spark in a Docker container and demonstrates connecting Visual Studio Code to the Docker instance to run PySpark. [Read more...](articles/Misc/Spark_To_ADLS/Part1-spark_to_ADLS.html)

---

## A Step-by-Step Guide to work with Azure Data Lake Containers using Standalone Spark

In this article, we'll see how to sort files in an Azure Data Lake Container by using a Standalone Spark application. You could use Azure Data Factory, Databricks, or Azure Logic Apps, but this method stands out. It's an alternative and often much cheaper than the other mentioned Azure services. This is a real-world requirement; having a structure like this can make partition pruning more efficient during query time, especially if you're using a system like Apache Hive or Delta Lake. [Read more...](articles/Misc/Spark_To_ADLS/Part2-SortingADLSContainerUsingSpark.html)

---

## How to use a simple local Python code to rearrange Azure Blob storage files into a hierarchical structure

I the previous article I showed you how to sort files using Spark and HDFS Jars. Here I will show you how using just straightforward python method in a local setup we can achieve teh same output, i.e, sort the files inside our Azure blob container. This is a real-world-scenario and such well-partioned structures are required for analysis and Migration. [Read more...](articles/Misc/SortAzureBlobFilesUsingLocalPython/LocalPython_AzureBlob.html)

---

## Python dummy data inserter into SQL Server

This article provides a step-by-step guide on using a Python script to populate the `dbo.student` table in a SQL Server database with random data. This method is useful for testing and simulation purposes. We'll cover how to set up the script, how it functions, and how to run it to achieve the desired results. [Read more...](articles/Misc/Dummy_data/dummy-data-inserter.html)

---
## Install Spark/Pyspark in the Anaconda Ecosystem

In this article, we'll provide a step-by-step guide to set up Spark/PySpark in the Anaconda ecosystem. We'll start with the installation of Anaconda based on your operating system. Then, we'll incorporate Java using Conda. Following that, we'll install PySpark and the `findspark` library, ensuring smooth integration with Jupyter. A crucial part of our guide focuses on setting environment variables. Specifically, we'll detail the process of configuring `JAVA_HOME` and `SPARK_HOME` variables and adding Java and PySpark to the system's PATH on a standard Windows setup. By the end of this guide, you'll be fully prepared to launch Jupyter Lab with PySpark, having all necessary configurations in place. [Read more...](link_to_article3.html)

---

## Setting up a Dockerized Spark Environment on Ubuntu for Windows

In this guide, I'll demonstrate how to create an Ubuntu Docker image fine-tuned for Python and Spark. We'll see how to connect the environment to Visual Studio Code using the Dev Containers extension. This VS extension allows you to work within a containerized environment seamlessly, offering the impression that all processes are running natively on your local machine. Ubuntu was selected as the base image due to its renowned stability, comprehensive apt-get system for handling packages, and flexibility in managing system-level packages or mimicking production setups. We considered other options like Python-focused images (e.g.,  python:3.9-slim,), Alpine Linux for its minimalism and security, and Debian which parallels Ubuntu's benefits but lacks some commercial features. [Read more...](link_to_article3.html)

---
## Managing Python in System PATH Using PowerShell

When working with Python on Windows, ensuring it's accessible from any terminal or command prompt is pivotal. This accessibility is achieved by including Python in the system's PATH variable. In this guide, we'll delve into using PowerShell to check Python's presence in the PATH and add it if missing.[Read more...](link_to_article3.html)

---
## Unable to run `docker ps` despite having docker installed?

Hey there! 🌟 So, you've got Docker installed but running simple commands like `docker ps` is giving you a headache? No worries! It's likely just a path issue. Let's walk through a quick fix together and get you back on track. Ready? Let's dive in! 🚀 [Read more...](articles/Misc/Running_docker_ps/how_to.html)

---

© D Das  
📧 [das.d@hotmail.com](mailto:das.d@hotmail.com) | [ddasdocs@gmail.com](mailto:ddasdocs@gmail.com)