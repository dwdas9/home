---
layout: default
title: Project Sparkzure
parent: Azure DE Projects
nav_order: 2
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

In this article I will show you how you can connect to Azure Storage and perform blob operations from a Standlone Pyspark Setup. We will make use of Hadoop jars to perform the same.

## How to Connect an local/on-premise Pyspark Setup with Azure Data Lake

We all know that Azure Databricks easily connects with ADLS because they share the same Azure setup. But if you're using a basic Spark setup, it gets a bit tricky because you have to carefully manage some JAR files. In this guide, we'll start our journey by making a simple connection to Azure from a standalone Spark and fetching some basic info. I'll also show you how to set up this connection inside a Docker container. We'll also learn how to connect Visual Studio Code to this Docker, so you can run PySpark easily! [Read more...](articles/Misc/Spark_To_ADLS/Part1-spark_to_ADLS.html)


## Method 1: How to rearrange items in Blob storage using an local/on-premise Pyspark & Hadoop Jars

In this article, we'll see how to sort files in an Azure Data Lake Container by using a Standalone Spark application. You could use Azure Data Factory, Databricks, or Azure Logic Apps, but this method stands out. It's an alternative and often much cheaper than the other mentioned Azure services. This is a real-world requirement; having a structure like this can make partition pruning more efficient during query time, especially if you're using a system like Apache Hive or Delta Lake. [Read more...](articles/Misc/Spark_To_ADLS/Part2-SortingADLSContainerUsingSpark.html)



## Method 2: How to rearrange items in Blob storage using an local/on-premise Python and Azure Python libraries(SDK)

I the previous article I showed you how to sort files using Spark and Hadoop Jars. Here I will show you how using just straightforward python method in a local setup we can achieve teh same output, i.e, sort the files inside our Azure blob container. This is a real-world-scenario and such well-partioned data structures are required for analysis and Migration. [Read more...](articles/Misc/SortAzureBlobFilesUsingLocalPython/LocalPython_AzureBlob.html)


## How to schedule our Blob file organizer Python script usign Azure Timer-Trigger Function

In the last two articles I showed you and artisinal-appreaoch to organize content inside Azure blob storage. But, we may require to schedule such function. Here I will show you how I converted my Python script[Method2] to a timer-triggered Azure function which runs everyday at 11.30 PM. [Read more...](tbd)

---

© D Das  
📧 [das.d@hotmail.com](mailto:das.d@hotmail.com) | [ddasdocs@gmail.com](mailto:ddasdocs@gmail.com)