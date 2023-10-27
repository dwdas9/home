---
layout: default
title: Misc Data Engineering Articles
nav_order: 5
---

## Table of Contents
- [Overview](#overview)
  - [Setting Up Azure Databricks](#setting-up-azure-databricks)
  - [Installing Key Elements for Data Engineering: Java, Python, SPARK, and PySpark](#installing-key-elements-for-data-engineering-java-python-spark-and-pyspark)
  - [Python dummy data inserter into SQL Server](#python-dummy-data-inserter-into-sql-server)
  - [Install Spark/Pyspark in the Anaconda Ecosystem](#install-sparkpyspark-in-the-anaconda-ecosystem)
  - [Setting up a Dockerized Spark Environment on Ubuntu for Windows](#setting-up-a-dockerized-spark-environment-on-ubuntu-for-windows)
  - [Managing Python in System PATH Using PowerShell](#managing-python-in-system-path-using-powershell)
  - [Unable to run `docker ps` despite having docker installed?](#unable-to-run-docker-ps-despite-having-docker-installed)
  - [How to Download and Use JAR Files from Apache Maven Repository](#how-to-download-and-use-jar-files-from-apache-maven-repository)
  - [Pip install Pyspark vs FULL Spark](#pip-install-pyspark-vs-full-spark)

# Overview
In this section, I'll share articles that may prove valuable for your daily tasks in data engineering and associated domains.


## Setting Up Azure Databricks

In this article, I will walk you through the steps to set up your Azure Databricks workspace, create clusters, and begin working with notebooks.[Read more...](articles/AzureDE/dbrk_setup/1_Setup-Azure-Databricks.html)

## Installing Key Elements for Data Engineering: Java, Python, SPARK, and PySpark

This guide's all about setting up the basics for Data Engineering – Java, Python, SPARK, and PySpark. It's simple and to the point, making sure you've got what you need to start your data journey. [Read more...](articles/Misc/InstallPythonPysparkSparkWin/JavaPythonSparkPysparkInstall.html)

## Python dummy data inserter into SQL Server

This article provides a step-by-step guide on using a Python script to populate the `dbo.student` table in a SQL Server database with random data. This method is useful for testing and simulation purposes. We'll cover how to set up the script, how it functions, and how to run it to achieve the desired results. [Read more...](articles/Misc/Dummy_data/dummy-data-inserter.html)


## Install Spark/Pyspark in the Anaconda Ecosystem

In this article, we'll provide a step-by-step guide to set up Spark/PySpark in the Anaconda ecosystem. We'll start with the installation of Anaconda based on your operating system. Then, we'll incorporate Java using Conda. Following that, we'll install PySpark and the `findspark` library, ensuring smooth integration with Jupyter. A crucial part of our guide focuses on setting environment variables. Specifically, we'll detail the process of configuring `JAVA_HOME` and `SPARK_HOME` variables and adding Java and PySpark to the system's PATH on a standard Windows setup. By the end of this guide, you'll be fully prepared to launch Jupyter Lab with PySpark, having all necessary configurations in place. [Read more...](link_to_article3.html)


## Setting up a Dockerized Spark Environment on Ubuntu for Windows

In this guide, I'll demonstrate how to create an Ubuntu Docker image fine-tuned for Python and Spark. We'll see how to connect the environment to Visual Studio Code using the Dev Containers extension. This VS extension allows you to work within a containerized environment seamlessly, offering the impression that all processes are running natively on your local machine. Ubuntu was selected as the base image due to its renowned stability, comprehensive apt-get system for handling packages, and flexibility in managing system-level packages or mimicking production setups. We considered other options like Python-focused images (e.g.,  python:3.9-slim,), Alpine Linux for its minimalism and security, and Debian which parallels Ubuntu's benefits but lacks some commercial features. [Read more...](link_to_article3.html)



## Managing Python in System PATH Using PowerShell

When working with Python on Windows, ensuring it's accessible from any terminal or command prompt is pivotal. This accessibility is achieved by including Python in the system's PATH variable. In this guide, we'll delve into using PowerShell to check Python's presence in the PATH and add it if missing.[Read more...](link_to_article3.html)

## Unable to run `docker ps` despite having docker installed?

Hey there! 🌟 So, you've got Docker installed but running simple commands like `docker ps` is giving you a headache? No worries! It's likely just a path issue. Let's walk through a quick fix together and get you back on track. Ready? Let's dive in! 🚀 [Read more...](articles/Misc/Running_docker_ps/how_to.html)

## How to Download and Use JAR Files from Apache Maven Repository

Need to download JAR files like hadoop-azure-x.x.x.jar for your project? Don't worry, it's quite simple to get them from the Apache Maven Repository. Let's go through how to download and use these JAR files in your projects. [Read more...](articles/Misc/download_hadoop_jars/howto.html)

## Pip install Pyspark vs FULL Spark

The article provides a clear explanation about installing PySpark using pip. It corrects the common misconception that `pip install pyspark` installs the full Apache Spark framework. In reality, it installs only PySpark and a minimal, standalone version of Apache Spark, sufficient for running Spark in a local, simulated cluster environment on a single machine. This breakdown is crucial for understanding the setup and capabilities of your Spark installation.[Read more...](articles/Misc/Pyspark_And_Spark/PysparkIsNotFullSpark.html)


---

© D Das  
📧 [das.d@hotmail.com](mailto:das.d@hotmail.com) | [ddasdocs@gmail.com](mailto:ddasdocs@gmail.com)