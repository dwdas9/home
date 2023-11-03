---
layout: default
title: Utility Coding - Compact Scripts for Routine Tasks
nav_order: 7
---

## <span style="color: Teal;">Table of Contents</span>
- [Overview](#overview)
  - [Python dummy data inserter into SQL Server](#python-dummy-data-inserter-into-sql-server)
  - [Validate JSON data using JSON Schema and Python](#validate-json-data-using-json-schema-and-python)
  - [Azure SDK: Flatten JSONs](#azure-sdk-flatten-jsons)


# <span style="color: BlueViolet;">Overview</span>

In this handy bunch of Python scripts, you'll find a bunch of quick-fixes and smart hacks primarily meant for folks working in Data Engineering and Data Science.

## <span style="color: SaddleBrown;">Python dummy data inserter into SQL Server</span>

This article provides a step-by-step guide on using a Python script to populate the `dbo.student` table in a SQL Server database with random data. This method is useful for testing and simulation purposes. We'll cover how to set up the script, how it functions, and how to run it to achieve the desired results. [Read more...](articles/Misc/Dummy_data/dummy-data-inserter.html)

## <span style="color: ForestGreen;">Validate JSON data using JSON Schema and Python</span>

This is a short tutorial on how to use Python to validate JSON file data. Rather than iterating through all the fields in the JSON, usage of libraries like JSONschema etc. are considered more efficient. Hence, I thought of sharing my experience. [Read more...](articles/Misc/JsonValidator/jsonvalidator.html)

## <span style="color: DarkRed;">Azure SDK: Flatten JSONs</span>

<span style="color: SteelBlue;">**Problem:**</span> To directly fetch JSON data from a web API and store it in a partitioned manner for enhanced analysis, utilizing only Spark for the process.

<span style="color: DarkSalmon;">**Solution:**</span>

Using Hadoop JARs with PySpark to establish a connection to Azure Data Lake Storage (ADLS). Through PySpark, the full functionality—from fetching the JSON data, partitioning it, to storing it—is seamlessly achieved.

**Tech stack:** ADLS, Pyspark, Haddop Azure Jars, Spark-Azure onnectivity.
[Read more...](articles/Misc/SparkAndAzureSDKScripts/FetchJsonWriteParquet.html)

---

© D Das  
📧 [das.d@hotmail.com](mailto:das.d@hotmail.com) | [ddasdocs@gmail.com](mailto:ddasdocs@gmail.com)