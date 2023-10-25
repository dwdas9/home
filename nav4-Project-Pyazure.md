---
layout: default
title: Project Pyazure
nav_order: 4
---

## Table of Contents
- [Overview](#overview)
  - [How to Connect an local/on-premise Spark Setup with Azure Data Lake](#how-to-connect-an-localon-premise-spark-setup-with-azure-data-lake)
  - [Method 1: How to rearrange items in Blob storage using an local/on-premise Pyspark \& Hadoop Jars](#method-1-how-to-rearrange-items-in-blob-storage-using-an-localon-premise-pyspark--hadoop-jars)
  - [Method 2: How to rearrange items in Blob storage using an local/on-premise Python and Azure SDK libraries](#method-2-how-to-rearrange-items-in-blob-storage-using-an-localon-premise-python-and-azure-sdk-libraries)
  - [How to schedule our Blob file organizer Python script usign Azure Timer-Trigger Function](#how-to-schedule-our-blob-file-organizer-python-script-usign-azure-timer-trigger-function)

# Overview

This article talks about how we can use Python and Spark to work with Azure Storage. I know we can do a lot of these things directly with Azure's built-in tools. But it's always good to know these cost-saving and artisinal approaches where we just use a basic Spark setup and a regular Python setting.

---

## How to Connect an local/on-premise Spark Setup with Azure Data Lake

We all know that Azure Databricks easily connects with ADLS because they share the same Azure setup. But if you're using a basic Spark setup, it gets a bit tricky because you have to carefully manage some JAR files. In this guide, we'll start our journey by making a simple connection to Azure from a standalone Spark and fetching some basic info. I'll also show you how to set up this connection inside a Docker container. We'll also learn how to connect Visual Studio Code to this Docker, so you can run PySpark easily! [Read more...](articles/Misc/Spark_To_ADLS/Part1-spark_to_ADLS.html)

---

## Method 1: How to rearrange items in Blob storage using an local/on-premise Pyspark & Hadoop Jars

In this article, we'll see how to sort files in an Azure Data Lake Container by using a Standalone Spark application. You could use Azure Data Factory, Databricks, or Azure Logic Apps, but this method stands out. It's an alternative and often much cheaper than the other mentioned Azure services. This is a real-world requirement; having a structure like this can make partition pruning more efficient during query time, especially if you're using a system like Apache Hive or Delta Lake. [Read more...](articles/Misc/Spark_To_ADLS/Part2-SortingADLSContainerUsingSpark.html)

---

## Method 2: How to rearrange items in Blob storage using an local/on-premise Python and Azure SDK libraries

I the previous article I showed you how to sort files using Spark and Hadoop Jars. Here I will show you how using just straightforward python method in a local setup we can achieve teh same output, i.e, sort the files inside our Azure blob container. This is a real-world-scenario and such well-partioned data structures are required for analysis and Migration. [Read more...](articles/Misc/SortAzureBlobFilesUsingLocalPython/LocalPython_AzureBlob.html)

---

## How to schedule our Blob file organizer Python script usign Azure Timer-Trigger Function

In the last two articles I showed you and artisinal-appreaoch to organize content inside Azure blob storage. But, we may require to auto-schedule such function. Here I will show you how I converted my Python script[Method2] to a timer-triggered Azure function which runs everyday at 11.30 PM [Read more...](tbd)

---


© D Das  
📧 [das.d@hotmail.com](mailto:das.d@hotmail.com) | [ddasdocs@gmail.com](mailto:ddasdocs@gmail.com)