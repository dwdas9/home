---
layout: default
title: Misc Articles
nav_order: 3
---
# Misc Articles

In this section, I'll share articles that may prove valuable for your daily tasks in data engineering and associated domains.

## Table of Contents
- [Misc Articles](#misc-articles)
  - [Table of Contents](#table-of-contents)
  - [Article 1: Dummy data inserter](#article-1-dummy-data-inserter)
  - [Article 2: Azure Data Lake To Spark](#article-2-azure-data-lake-to-spark)
  - [Install Spark/Pyspark in the Anaconda Ecosystem](#install-sparkpyspark-in-the-anaconda-ecosystem)
  - [Managing Python in System PATH Using PowerShell](#managing-python-in-system-path-using-powershell)
  - [Managing Python in System PATH Using PowerShell](#managing-python-in-system-path-using-powershell-1)
  - [Setting Up a Dockerized Spark Environment on Ubuntu for Windows](#setting-up-a-dockerized-spark-environment-on-ubuntu-for-windows)

---

## Article 1: Dummy data inserter

This article provides a step-by-step guide on using a Python script to populate the `dbo.student` table in a SQL Server database with random data. This method is useful for testing and simulation purposes. We'll cover how to set up the script, how it functions, and how to run it to achieve the desired results.

[Read more...](articles/Misc/Dummy_Data_Inserter/dummy-data-inserter.html)

---

## Article 2: Azure Data Lake To Spark

Configuring ADLS for Azure Databricks is straightforward due to their shared Azure Directory (AD) infrastructure and Databricks’ built-in support for ADLS. For standalone Spark applications, however, integrating with ADLS requires careful management of JAR dependencies in the site-packages directory.

[Read more...](articles/Misc/Spark_To_ADLS/spark_to_ADLS.html)

---

## Install Spark/Pyspark in the Anaconda Ecosystem

In this article, we'll provide a step-by-step guide to set up Spark/PySpark in the Anaconda ecosystem. We'll start with the installation of Anaconda based on your operating system. Then, we'll incorporate Java using Conda. Following that, we'll install PySpark and the `findspark` library, ensuring smooth integration with Jupyter. A crucial part of our guide focuses on setting environment variables. Specifically, we'll detail the process of configuring `JAVA_HOME` and `SPARK_HOME` variables and adding Java and PySpark to the system's PATH on a standard Windows setup. By the end of this guide, you'll be fully prepared to launch Jupyter Lab with PySpark, having all necessary configurations in place. 

[Read more...](link_to_article3.md)

---

## Managing Python in System PATH Using PowerShell

When working with Python on Windows, ensuring it's accessible from any terminal or command prompt is pivotal. This accessibility is achieved by including Python in the system's PATH variable. In this guide, we'll delve into using PowerShell to check Python's presence in the PATH and add it if missing.

[Read more...](link_to_article3.md)

---

## Managing Python in System PATH Using PowerShell

When working with Python on Windows, ensuring it's accessible from any terminal or command prompt is pivotal. This accessibility is achieved by including Python in the system's PATH variable. In this guide, we'll delve into using PowerShell to check Python's presence in the PATH and add it if missing.

[Read more...](link_to_article3.md)

---

## Setting Up a Dockerized Spark Environment on Ubuntu for Windows

In this guide, I'll demonstrate how to create an Ubuntu Docker image fine-tuned for Python and Spark. We'll see how to connect the environment to Visual Studio Code using the Dev Containers extension. This VS extension allows you to work within a containerized environment seamlessly, offering the impression that all processes are running natively on your local machine. Ubuntu was selected as the base image due to its renowned stability, comprehensive apt-get system for handling packages, and flexibility in managing system-level packages or mimicking production setups. We considered other options like Python-focused images (e.g.,  python:3.9-slim,), Alpine Linux for its minimalism and security, and Debian which parallels Ubuntu's benefits but lacks some commercial features.

[Read more...](link_to_article3.md)

