---
layout: default
title: Azure Utility Scripts
nav_order: 7
---

## <span style="color: Teal;">Table of Contents</span>
- [Overview](#overview)
  - [JSON Validate  using  Schema](#json-validate--using--schema)
  - [JSON Fetch n Convert  To Parquet](#json-fetch-n-convert--to-parquet)
  - [JSON Clean-Validate-Migrate ](#json-clean-validate-migrate-)
  - [JSON Flatten ](#json-flatten-)
  - [Python dummy data inserter into SQL Server](#python-dummy-data-inserter-into-sql-server)


# <span style="color: BlueViolet;">Overview</span>

This article shows few compact self-contained scripts that can be applied to many scenarios and customized further. The overview section gives you an idea of whats inside. These scripts are mainly for development projects with a python element. Most of the scripts are built using VS code.

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