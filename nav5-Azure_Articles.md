---
layout: default
title: Azure Articles
nav_order: 5
---

<details open markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

# Overview

First things first - Don't forget to click [Read more...]

Hello everyone! In this guide, we'll focus on how to set up essential tools and environments for Data Engineering. Whether you're a beginner or already deep into the field, this straightforward guide aims to simplify your journey.


## <span style="color: SteelBlue;">Docker Spark Cluster Setup : One Master, Two Workers</span>
In this tutorial I'll guide you through setting up an Apache Spark cluster using Docker, with one master and two worker nodes in windows environment. We will use docker-compose.yaml to achieve this task [Read more...](articles/Misc/Docker/SparkDocker/SparkDockerSetup.html)

## <span style="color: SteelBlue;">Docker Apache Airflow Setup</span>
In this article, I'll show two approaches to setting up Apache Airflow using Docker on Windows. The first method, more suitable for production environments, involves a few additional steps. The second method is quicker, ideal for development settings. [Read more...](articles/Misc/Docker/AirflowDocker/Setup.html)

## <span style="color: SteelBlue;">Docker Confluent Kafka All-in-one Setup</span>

This guide will show you how to install an all-in-one confluent Kafka for development purpose in MacM1 Windows on Dockert. [Read more...](articles/Misc/Docker/Kafka/Confluent-Kafka.html)

## <span style="color: SteelBlue;">Docker Mongodb Setup</span>

This guide will show you how to setup Mongodb in Docker. [Read more...](articles/Misc/Docker/Mongodb/DockerMongodb.html)

## <span style="color: SteelBlue;">Docker Pyspark-Ubuntu Setup</span>

This guide will show you how to create a Python and Spark-optimized Ubuntu Docker image. I'll walk you through connecting this environment to Visual Studio Code via the Dev Containers extension, enabling a smooth, native-like development experience. Ubuntu is chosen for its stable, flexible apt-get package management, making it ideal for mimicking production setups. While other images like `python:3.9-slim`, Alpine Linux, and Debian were considered, Ubuntu's balance of features and commercial support stands out. [Read more...](articles/Misc/Pyspark_Ubuntu_Docker_Container/pyspark_docker.html)

## <span style="color: SteelBlue;">Install Spark/Pyspark in the Anaconda Ecosystem</span>

In this article, I'll guide you through setting up Spark/PySpark with Anaconda. I'll cover Anaconda installation, Java integration via Conda, and then move on to installing PySpark and `findspark`. I'll also explain setting up environment variables like `JAVA_HOME` and `SPARK_HOME`, and adding Java and PySpark to your PATH in Windows. You'll finish ready to start Jupyter Lab with PySpark configured. [Read more...](link_to_article3.html)

## <span style="color: SteelBlue;">Install Java, Python, SPARK, and PySpark On Windows</span>

This guide's all about setting up the basics for Data Engineering – Java, Python, SPARK, and PySpark. [Read more...](articles/Misc/InstallPythonPysparkSparkWin/JavaPythonSparkPysparkInstall.html)


## <span style="color: SteelBlue;">Managing Python in System PATH Using PowerShell</span>

When working with Python on Windows, ensuring it's accessible from any terminal or command prompt is pivotal. This accessibility is achieved by including Python in the system's PATH variable. In this guide, we'll delve into using PowerShell to check Python's presence in the PATH and add it if missing. [Read more...](link_to_article3.html)

## <span style="color: SteelBlue;">Can't run `docker ps` despite having docker installed?</span>

So, you've got Docker installed but running simple commands like `docker ps` is giving you a headache? No worries! It's likely just a path issue. Let's walk through a quick fix together and get you back on track. Ready? Let's dive in! [Read more...](articles/Misc/Running_docker_ps/how_to.html)

## <span style="color: SteelBlue;">How to Download and Use JAR Files from Apache Maven Repository</span>

Need to download JAR files like hadoop-azure-x.x.x.jar for your project? Don't worry, it's quite simple to get them from the Apache Maven Repository. Let's go through how to download and use these JAR files in your projects. [Read more...](articles/Misc/download_hadoop_jars/howto.html)

## <span style="color: SteelBlue;">Pip install Pyspark vs FULL Spark</span>

The article provides a clear explanation about installing PySpark using pip. It corrects the common misconception that `pip install pyspark` installs the full Apache Spark framework. In reality, it installs only PySpark and a minimal, standalone version of Apache Spark, sufficient for running Spark in a local, simulated cluster environment on a single machine. This breakdown is crucial for understanding the setup and capabilities of your Spark installation. [Read more...](articles/Misc/Pyspark_And_Spark/PysparkIsNotFullSpark.html)

## <span style="color: SteelBlue;">Setting Up Azure Databricks</span>

In this article, I will walk you through the steps to set up your Azure Databricks workspace, create clusters, and begin working with notebooks. [Read more...](articles/AzureDE/dbrk_setup/1_Setup-Azure-Databricks.html)

## <span style="color: ForestGreen;">Spark - Azure Connection Methods</span>

There are multiple ways to connect to Azure Storage using Spark. Both from an external on-premise spark to a spark hosted in external docker to Spark/Databricks on Azure [Read more...](articles/Misc/MardownNoImageArticles/WaysToConnectSparkToAzure.html)

## <span style="color: ForestGreen;">JSON Validate  using  Schema</span>

This is a short tutorial on how to use Python to validate JSON file data. Rather than iterating through all the fields in the JSON, usage of libraries like JSONschema etc. are considered more efficient. Hence, I thought of sharing my experience. [Read more...](articles/Misc/JsonValidator/jsonvalidator.html)

## <span style="color: DarkRed;">JSON Fetch n Convert  To Parquet</span>

**Problem:** To directly fetch JSON data from a web API and store it in a partitioned manner for enhanced analysis, utilizing only Spark for the process.

**Solution:**

Using Hadoop JARs with PySpark to establish a connection to Azure Data Lake Storage (ADLS). Through PySpark, the full functionality—from fetching the JSON data, partitioning it, to storing it—is seamlessly achieved.

**Tech stack:** ADLS, Pyspark, Haddop Azure Jars, Spark-Azure onnectivity.
[Read more...](articles/Misc/SparkAndAzureSDKScripts/FetchJsonWriteParquet.html)

## <span style="color: PaleVioletRed;">JSON Clean-Validate-Migrate </span>

<span style="color: navy;">**Problem:**</span>
**JSON files in the source_container** are stored with **single quotes**, leading to **invalid schema issues**.

**Solution:**

- **Change encoding** to **UTF-8**.
- **Modify single quotes** to **double quotes**.
- **Validate against a JSON schema** post-modification.
- **Move Data:** Move to **dest_container**.
- **Optinal:** Convert to an Azure Function.

**Tech stack:** ADLS, Azure SDK/Libs, Azure Functions. [Read more...](articles/Misc/JsonValidator/BulkJsonValidator.html)

## <span style="color: DodgerBlue;">JSON Flatten </span>


**Problem:**
The source container has a lot of JSON files in nested format. They need to be flattened.

**Solution:**

- **Flatten** the source json files using Azure SDK(libs), BlobServiceClient
- **Move** the files to a destination container or simply replace the source files
- **Optinal:** Convert to an Azure Function.

**Tech stack:** ADLS, Azure SDK For Python, Azure Functions. [Read more...](articles/Misc/JsonFlatternerAzureSDK/JsonFlatAzureSDK.html)

## <span style="color: DimGray;">Python dummy data inserter into SQL Server</span>

This article provides a step-by-step guide on using a Python script to populate the `dbo.student` table in a SQL Server database with random data. This method is useful for testing and simulation purposes. We'll cover how to set up the script, how it functions, and how to run it to achieve the desired results. [Read more...](articles/Misc/Dummy_data/dummy-data-inserter.html)

---

© D Das  
📧 [das.d@hotmail.com](mailto:das.d@hotmail.com) | [ddasdocs@gmail.com](mailto:ddasdocs@gmail.com)