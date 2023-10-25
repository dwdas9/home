---
layout: default
title: Project AzureSkyWeather
nav_order: 1
---
## Table of contents
- [Overview](#overview)
  - [Project AzureSkyWeather. Part 1A: Using Azure HTTP-Triggered Function](#project-azureskyweather-part-1a-using-azure-http-triggered-function)
  - [Project AzureSkyWeather. Part 1B: Using Azure Timer-Triggered Function](#project-azureskyweather-part-1b-using-azure-timer-triggered-function)
  - [Project AzureSkyWeather. Part 2: Sorting the JSON files based on Timestamp for partition pruning](#project-azureskyweather-part-2-sorting-the-json-files-based-on-timestamp-for-partition-pruning)


# Overview

In this segment, we'll dive deep into the world of Azure Functions, Microsoft's event-driven, serverless compute platform. Azure Functions empower developers to run event-triggered code without having to manage the underlying infrastructure. It's an efficient and scalable way to handle operations such as data processing, integration with other services, or any action that can be mapped to an input event.

I'll show how to use Azure Functions for different tasks. We'll look at common ways people use them. For example, when someone visits a website or when data changes. We'll also learn how to set them up and manage them. By the end, you'll know more about how Azure Functions can help in your projects.


## Project AzureSkyWeather. Part 1A: Using Azure HTTP-Triggered Function

In this article, I'll delve into building an HTTP-triggered Azure Function using Python V2 on Azure Functions and Visual Studio Code. I've chosen an HTTP-trigger for its on-demand execution, combined with the powerful scheduling capability of Azure Logic Apps. Our primary focus is to fetch weather data from `weatherapi.com` and store it as JSON in Azure Blob Storage, efficiently organized by hourly timestamps. I've incorporated robust error handling, ensuring resilience against potential API and storage issues. Additionally, I've added a unique feature that allows for a personalized greeting based on input parameters. Join me as I break down the technical nuances of this serverless solution. [Read more...](articles/AzureFunctions/AzureSkyWeather/HttpTriggered/Project_Details_HTTPTriggered.html)

---
## Project AzureSkyWeather. Part 1B: Using Azure Timer-Triggered Function

In Part 1A, I talked about making an HTTP-Triggered Azure function and using Azure Logic Apps to set its timing. Now, I'll show a different way. We'll use a Timer-Triggered Azure function that already has a built-in timer. This is another option. Choosing the best way can depend on things like cost. Azure Logic Apps can cost more than Timer-Triggered functions. I've kept this article short because many steps for both functions are the same.
[Read more...](articles/AzureFunctions/AzureSkyWeather/TimerTriggered/Project_Details_TimerTriggered.html)

---
## Project AzureSkyWeather. Part 2: Sorting the JSON files based on Timestamp for partition pruning

Note: Apart from the method shown here, you can also achieve the same using just local Python. Have a look at this section: [Link to the section](articles/Misc/SortAzureBlobFilesUsingLocalPython/LocalPython_AzureBlob.html)

In this article, we'll see how to sort files in an Azure Data Lake Container by using a Standalone Spark application. You could use Azure Data Factory, Databricks, or Azure Logic Apps, but this method stands out. It's an alternative and often much cheaper than the other mentioned Azure services. This is a real-world requirement; having a structure like this can make partition pruning more efficient during query time, especially if you're using a system like Apache Hive or Delta Lake.[Read more...](articles/Misc/Spark_To_ADLS/Part2-SortingADLSContainerUsingSpark.html)

---

© D Das  
📧 [das.d@hotmail.com](mailto:das.d@hotmail.com) | [ddasdocs@gmail.com](mailto:ddasdocs@gmail.com)