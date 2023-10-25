---
layout: default
title: Project AzureSkyWeather
nav_order: 3
---
## Table of contents
- [Overview](#overview)
  - [Project AzureSkyWeather. Step1A: Data ingestion using Azure HTTP-Triggered Function And Azure Logic Apps](#project-azureskyweather-step1a-data-ingestion-using-azure-http-triggered-function-and-azure-logic-apps)
  - [Project AzureSkyWeather. Step1B: Data ingestion using Just Azure Timer-Triggered Function](#project-azureskyweather-step1b-data-ingestion-using-just-azure-timer-triggered-function)
  - [Project AzureSkyWeather. Step2A: Organize the weather files into directories like `year=yy/month=mm/day=dd/hour=h` using Plain Python](#project-azureskyweather-step2a-organize-the-weather-files-into-directories-like-yearyymonthmmdayddhourh-using-plain-python)
  - [Project AzureSkyWeather. Step2B: Organize the weather files into directories like `year=yy/month=mm/day=dd/hour=h` using Standalone Spark and Hadoop Jars](#project-azureskyweather-step2b-organize-the-weather-files-into-directories-like-yearyymonthmmdayddhourh-using-standalone-spark-and-hadoop-jars)


# Overview

**Objective:** Our goal is to develop an end-to-end data engineering solution using the Microsoft technology stack. We're mainly aiming to create a future-proof and efficient storage solution to store weather data sourced from web APIs for data science and analytics, .

**Project Components and Workflow:**

1. **Data Ingestion Techniques:**
   - **Step1A:** Here, we'll use an HTTP-triggered Azure Function to pull in data from a Web API. The whole activity will be scheduled via Azure Logic Apps.
   - **Step1B:** We'll also see how a timer-triggered Azure Function can do the same job, making additional services unnecessary.

2. **Ways to Sort Data:**
   - **Step2A:** We'll learn how to organise the weather files into directories like `year=yy/month=mm/day=dd/hour=h` using Local Spark and Hadoop Jars.
   - **Step2B:** As an alternative, we'll use Python combined with Azure's Python SDK. Plus, I'll show how this can be set up in a timer-based Azure Function for regular execution.

3. **Cleaning and Transforming Data:**
   - **Step3A:** Let's explore data cleaning and its conversion to parquet format using standalone Spark and Hadoop jars.
   - **Step3B:** We'll switch to Azure Databricks to see its advantages and how it simplifies our work.

4. **Advanced Processing:** The following steps will dive deeper into data science and analytics tasks.

**Thought Behind This:** Nowadays, many professionals prefer tools like Azure Data Factory, Azure Databricks, and Azure Synapse Analytics because of their all-in-one solutions. But, through this project, my idea is to show alternate methods. By understanding various alternatives, will strengthen your knowledge of data in the microsoft domain. Also knowing many methods will make you more confident in your choce of products.

## Project AzureSkyWeather. Step1A: Data ingestion using Azure HTTP-Triggered Function And Azure Logic Apps

This is the first step of the project, which involves data ingestion. Here, I will show how we can ingest data from an API using an HTTP-triggered Azure Function. We will use VS Code to develop the function. You will get an idea about how to set up your VS Code for Azure Function development. To schedule our function, we will use Azure Logic Apps. This section will give you a very good understanding of how to build Azure functions. [Read more...](articles/AzureFunctions/AzureSkyWeather/HttpTriggered/Project_Details_HTTPTriggered.html)

---

## Project AzureSkyWeather. Step1B: Data ingestion using Just Azure Timer-Triggered Function

Now, I'll show a different way. We'll use a Timer-Triggered Azure function that already has a built-in timer. This is another option. Choosing the best way can depend on things like cost. Azure Logic Apps can cost more than Timer-Triggered functions. I've kept this article short because many steps for both functions are the same. [Read more...](articles/AzureFunctions/AzureSkyWeather/TimerTriggered/Project_Details_TimerTriggered.html)

---

## Project AzureSkyWeather. Step2A: Organize the weather files into directories like `year=yy/month=mm/day=dd/hour=h` using Plain Python

Here, I will show you how can can organize the weather files into directories like `year=yy/month=mm/day=dd/hour=h` using just Plain python and how the same can be put into a Timer-trigger function for auto-scheduling.[Read more...]](articles/Misc/SortAzureBlobFilesUsingLocalPython/LocalPython_AzureBlob.html)

---

## Project AzureSkyWeather. Step2B: Organize the weather files into directories like `year=yy/month=mm/day=dd/hour=h` using Standalone Spark and Hadoop Jars

Now, I will show you how do the same using Standalone Spark and Hadoop Jars. This will give you a good idea about connecting using Spark with Hadoop Jars to work with Azure blob storage[Read more...](articles/Misc/Spark_To_ADLS/Part2-SortingADLSContainerUsingSpark.html)

---

© D Das  
📧 [das.d@hotmail.com](mailto:das.d@hotmail.com) | [ddasdocs@gmail.com](mailto:ddasdocs@gmail.com)