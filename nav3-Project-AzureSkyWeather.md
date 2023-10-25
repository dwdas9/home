---
layout: default
title: Project AzureSkyWeather
nav_order: 3
---
## Table of contents
- [Overview](#overview)
  - [Project AzureSkyWeather. Step1A: Data ingestion using Azure HTTP-Triggered Function And Azure Logic Apps](#project-azureskyweather-step1a-data-ingestion-using-azure-http-triggered-function-and-azure-logic-apps)
  - [Project AzureSkyWeather. Step1B: Data ingestion using Just Azure Timer-Triggered Function](#project-azureskyweather-step1b-data-ingestion-using-just-azure-timer-triggered-function)
  - [Project AzureSkyWeather. Step2A: Organize the weather files by timestamp using Plain Python](#project-azureskyweather-step2a-organize-the-weather-files-by-timestamp-using-plain-python)
  - [Project AzureSkyWeather. Step2B: Organize the weather files by timestamp using Spark and Hadoop](#project-azureskyweather-step2b-organize-the-weather-files-by-timestamp-using-spark-and-hadoop)


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

This is the first step of our project, focusing on data ingestion. In this segment, I'll show how we can fetch data from an API using an HTTP-triggered Azure Function, developed via VS Code. To schedule our function, we'll make use of Azure Logic Apps. By the end of this section, you'll have a comprehensive understanding of creating Azure functions. [Read more...](articles/AzureFunctions/AzureSkyWeather/HttpTriggered/Project_Details_HTTPTriggered.html)

---

## Project AzureSkyWeather. Step1B: Data ingestion using Just Azure Timer-Triggered Function

Now, I'll show a different way. We'll use a Timer-Triggered Azure function that already has a built-in timer. This is another option. Choosing the best way can depend on things like cost. Azure Logic Apps can cost more than Timer-Triggered functions. I've kept this article short because many steps for both functions are the same. [Read more...](articles/AzureFunctions/AzureSkyWeather/TimerTriggered/Project_Details_TimerTriggered.html)

---

## Project AzureSkyWeather. Step2A: Organize the weather files by timestamp using Plain Python

Here, I will show you how can can organize the weather files into directories like `year=yy/month=mm/day=dd/hour=h` using just Plain python. The code we will create can be easily incoporated into a Timer-trigger Azure function. That way we can schedule it to sort our files at a definite time. [Read more...](articles/Misc/SortAzureBlobFilesUsingLocalPython/LocalPython_AzureBlob.html)

---

## Project AzureSkyWeather. Step2B: Organize the weather files by timestamp using Spark and Hadoop

Now, I will show you how do the same using Standalone Spark and Hadoop Jars. This will give you a good idea about connecting using Spark with Hadoop Jars to work with Azure blob storage[Read more...](articles/Misc/Spark_To_ADLS/Part2-SortingADLSContainerUsingSpark.html)

---

© D Das  
📧 [das.d@hotmail.com](mailto:das.d@hotmail.com) | [ddasdocs@gmail.com](mailto:ddasdocs@gmail.com)