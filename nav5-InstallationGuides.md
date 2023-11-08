---
layout: default
title: Installation Guides
nav_order: 5
---

## Table of Contents
- [Overview](#overview)
  - [Docker Spark Cluster Setup : One Master, Two Workers](#docker-spark-cluster-setup--one-master-two-workers)
  - [Docker Apache Airflow Setup](#docker-apache-airflow-setup)
  - [Docker Confluent Kafka All-in-one Setup](#docker-confluent-kafka-all-in-one-setup)
  - [Docker Mongodb Setup](#docker-mongodb-setup)
  - [Docker Pyspark-Ubuntu Setup](#docker-pyspark-ubuntu-setup)
  - [Install Spark/Pyspark in the Anaconda Ecosystem](#install-sparkpyspark-in-the-anaconda-ecosystem)
  - [Install Java, Python, SPARK, and PySpark On Windows](#install-java-python-spark-and-pyspark-on-windows)
  - [Managing Python in System PATH Using PowerShell](#managing-python-in-system-path-using-powershell)
  - [Can't run `docker ps` despite having docker installed?](#cant-run-docker-ps-despite-having-docker-installed)
  - [How to Download and Use JAR Files from Apache Maven Repository](#how-to-download-and-use-jar-files-from-apache-maven-repository)
  - [Pip install Pyspark vs FULL Spark](#pip-install-pyspark-vs-full-spark)
  - [Setting Up Azure Databricks](#setting-up-azure-databricks)


# Overview

Hello everyone! In this guide, we'll focus on how to set up essential tools and environments for Data Engineering. Whether you're a beginner or already deep into the field, this straightforward guide aims to simplify your journey.


## <span style="color: SteelBlue;">Docker Spark Cluster Setup : One Master, Two Workers</span>
In this tutorial I'll guide you through setting up an Apache Spark cluster using Docker, with one master and two worker nodes in windows environment. We will use docker-compose.yaml to achieve this task[Read more...](articles/Misc/Docker/SparkDocker/SparkDockerSetup.html)

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

---

© D Das  
📧 [das.d@hotmail.com](mailto:das.d@hotmail.com) | [ddasdocs@gmail.com](mailto:ddasdocs@gmail.com)