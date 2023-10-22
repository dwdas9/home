---
layout: default
title: Sorting Files in ADLS Container Using Standalone Spark
nav_exclude: true
---

## Table of contents
- [Project Sparkzure Part2 - Sorting Files in ADLS Container Using Standalone Spark](#project-sparkzure-part2---sorting-files-in-adls-container-using-standalone-spark)
    - [Overview of the Article](#overview-of-the-article)
    - [My Environment](#my-environment)
    - [The scenario](#the-scenario)
    - [Kickstart](#kickstart)
      - [Environment Setup](#environment-setup)
        - [Download the jars by running this command from terminal:](#download-the-jars-by-running-this-command-from-terminal)
        - [Copy the jars to the SPARK\_HOME/Jars location](#copy-the-jars-to-the-spark_homejars-location)
      - [Run the Spark Code](#run-the-spark-code)
    - [Conclusion](#conclusion)
    - [Appendix](#appendix)
      - [Programmatic options for Creating Containers, Sorting Files etc:](#programmatic-options-for-creating-containers-sorting-files-etc)

---

# Project Sparkzure Part2 - Sorting Files in ADLS Container Using Standalone Spark

### Overview of the Article

In Part 1, we dived into accessing ADLS files with Pyspark and Hadoop Jars. Now, let's switch gears a bit. In this article, we'll explore how to sort—by creating containers and moving/renaming files—the content in an Azure Data Lake Container using just a Standalone Spark application. While there's always the route of Azure Data Factory, Databricks, or Azure Logic Apps, I want to spotlight this approach. Why? Because it's not only a viable alternative, but it also comes with the perk of being nearly cost-free compared to the other Azure services I mentioned.

### My Environment

- **Deployment Platform:** Docker
- **Operating System:** Ubuntu
- **Python Version:** 3.8.10
- **Development IDE:** Visual Studio Code connected to the container
- **Spark Setup:** Standalone Spark installed as part of Pyspark(`pip install pyspark`)
- **Spark Home** /usr/local/lib/python3.8/dist-packages/pyspark/
- **Jars Location** /usr/local/lib/python3.8/dist-packages/pyspark/jars/

### The scenario

We have a container name "weather-timer" that contains JSON files formatted as `YYYY-10-22-12.json`. These files hold weather information retrieved from a web API. The files need to be sorted in the format  `year=yyyy/month=mm/day=dd/hour=hh.json`. This is a real-world requirement, as a structure like this can make partition pruning more efficient during query time if you're using a system like Apache Hive or Delta Lake.

### Kickstart

#### Environment Setup

For ADLS connectivity in standalone PySpark, we need to download these 3 super-important Jars:
- `hadoop-azure-<version>.jar`: Supports Azure Blob Storage and Spark integration.
- `hadoop-azure-datalake-<version>.jar`: For for ADLS access, including authentication features.
- `hadoop-common-<version>.jar`: Contains utilities for the other JARs.

##### Download the jars by running this command from terminal:

Run teh following command in terminal. Note: The version of jars might change over time.

 ```bash
cd ~
wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-azure/3.3.3/hadoop-azure-3.3.3.jar
wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-azure-datalake/3.3.3/hadoop-azure-datalake-3.3.3.jar
wget https://repo1.maven.org/maven2/org/apache/hadoop/hadoop-common/3.3.3/hadoop-common-3.3.3.jar
   
```
##### Copy the jars to the SPARK_HOME/Jars location

```bash
   cd ~  # assuming you downloaded the JARs in the home directory
   cp *.jar /usr/local/lib/python3.8/dist-packages/pyspark/jars/
```
#### Run the Spark Code

This is the code for performing the sorting. It checks if there are containers. If not, it makes them. Before you run the code, make sure you replace placeholders like `<YOUR_STORAGE_ACT_NAME>`, `<YOUR_REG_APP_CLIENT_ID>`, `<YOUR_REG_APP_TENANT_ID>`, `<YOUR_REG_APP_CLIENT_SECRET>`, `<YOUR_CONTAINER_NAME>`, and paths to JAR files with the actual values.. Also, update any other settings to match your system.

```Python

# Importing the necessary module for SparkSession from the PySpark library.
from pyspark.sql import SparkSession

#Note: The location of jars is where we copied them after downloadign with wget
spark = SparkSession.builder \
    .appName("ADLS Access") \
    .config("spark.jars", 
            "/usr/local/lib/python3.8/dist-packages/pyspark/jars/hadoop-azure-3.3.3.jar,"\
            "/usr/local/lib/python3.8/dist-packages/pyspark/jars/hadoop-azure-datalake-3.3.3.jar,"\
            "/usr/local/lib/python3.8/dist-packages/pyspark/jars/hadoop-common-3.3.3.jar") \
    .getOrCreate()


# Configuring PySpark for Azure Data Lake Storage (ADLS) Authentication using OAuth
# Credentials and configurations
storage_account_name = "<YOUR_STORAGE_ACT_NAME>"
regapp_client_id = "<YOUR_REG_APP_CLIENT_ID>" # Application (client) ID of the registered app
regapp_directory_id = "<YOUR_REG_APP_TENANT_ID>" # Directory (tenant) ID of the registered app
regapp_client_secret = "<YOUR_REG_APP_CLIENT_SECRET>"

# Set the authentication type to OAuth for the specified storage account---------------
spark.conf.set(f"fs.azure.account.auth.type.{storage_account_name}.dfs.core.windows.net", "OAuth")

# Define the token provider type for OAuth. The 'ClientCredsTokenProvider' is specified for the client credentials flow.
spark.conf.set(f"fs.azure.account.oauth.provider.type.{storage_account_name}.dfs.core.windows.net", "org.apache.hadoop.fs.azurebfs.oauth2.ClientCredsTokenProvider")

# Provide the client ID (application ID) of the registered application in Azure Active Directory (AD).
spark.conf.set(f"fs.azure.account.oauth2.client.id.{storage_account_name}.dfs.core.windows.net", regapp_client_id)

# Set the client secret of the registered application. This acts as a password for the application to verify its identity.
spark.conf.set(f"fs.azure.account.oauth2.client.secret.{storage_account_name}.dfs.core.windows.net", regapp_client_secret)

# Specify the OAuth 2.0 token endpoint, allowing the application to retrieve tokens for authentication.
spark.conf.set(f"fs.azure.account.oauth2.client.endpoint.{storage_account_name}.dfs.core.windows.net", f"https://login.microsoftonline.com/{regapp_directory_id}/oauth2/token")
#----------------------------------------------------------------------------------------
#---------Code to perform the sorting----------------------------------------------------
# Define the ADLS Gen2 base path
base_path = f"abfss://<YOUR_CONTAINER_NAME>@<YOUR_STORAGE_ACT_NAME>.dfs.core.windows.net/"

conf = spark._jsc.hadoopConfiguration()
conf.set("fs.abfss.impl", "org.apache.hadoop.fs.azurebfs.AzureBlobFileSystem")
uri = spark._jvm.java.net.URI
path_obj = spark._jvm.org.apache.hadoop.fs.Path(base_path)
file_system = spark._jvm.org.apache.hadoop.fs.FileSystem.get(uri(base_path), conf)

old_files = [status.getPath().toString() for status in file_system.globStatus(spark._jvm.org.apache.hadoop.fs.Path(base_path + "*-*.json"))]

# Diagnostic: Check the number of files fetched
print(f"Number of files to be processed: {len(old_files)}")

# Test with a subset (for diagnostic purposes)
subset_of_files = old_files[:5]

for old_file_path in old_files:
    # Extract year, month, day, and hour from the old file path
    filename = old_file_path.split('/')[-1]
    year, month, day, hour = filename.split('-')[:4]

    # Construct the new directory structure based on the desired format
    new_directory = base_path + f"year={year}/month={month}/day={day}/"
    
    # Check if the directory exists; if not, create it
    if not file_system.exists(spark._jvm.org.apache.hadoop.fs.Path(new_directory)):
        file_system.mkdirs(spark._jvm.org.apache.hadoop.fs.Path(new_directory))

    # Construct the new file path
    new_file_path = new_directory + f"hour={hour}"

    # Diagnostic: Printing the move action
    print(f"Moving {old_file_path} to {new_file_path}")

    # Rename (move) the file to the new path and check if it's successful
    success = file_system.rename(spark._jvm.org.apache.hadoop.fs.Path(old_file_path), spark._jvm.org.apache.hadoop.fs.Path(new_file_path))

    # Diagnostic: Check if the move was successful
    print(f"Move success: {success}")

print("Files rearranged successfully for the subset!")
#---------Code to perform the sorting----------------------------------------------------

```
### Conclusion

There are many ways to organize files in a container, like using ADF, Databricks, or Logic Apps. But this way is good too because it's free, unlike some pretty-expensive options like Databricks. I shared this article to let us know there's another option out there. It shows how we perform such operation on Azure DataLake from an outside standalone application.


### Appendix

#### Programmatic options for Creating Containers, Sorting Files etc:

If you want to compare what other programmatic options we have to peroform such operation, here is the comparison:

1. **Reading/Writing Large Datasets**: 
    - **Best Tool**: PySpark.
    - **Reason**: Spark is designed for distributed data processing. Reading and processing large datasets from ADLS Gen2 into Spark dataframes will be efficient.
    
2. **Listing Files in a Container/Directory**:
    - **Best Tool**: PySpark or Hadoop FileSystem API.
    - **Reason**: PySpark provides simple methods to list files, but if you're already interfacing with Hadoop's FileSystem API for other tasks, it's also a good choice.
    
3. **Renaming or Moving Files**:
    - **Best Tool**: Hadoop FileSystem API.
    - **Reason**: While this can be done with the Azure SDK, the Hadoop FileSystem API provides a more direct interface when working alongside Spark.
    
4. **Creating Containers or Directories**:
    - **Best Tool**: Azure SDK (`azure-storage-file-datalake`).
    - **Reason**: Creating containers or directories is a simple storage management task. The Azure SDK provides direct methods to do this without unnecessary overhead.
    
5. **Setting Permissions or Managing Access**:
    - **Best Tool**: Azure SDK.
    - **Reason**: Managing permissions or access control is more straightforward with the Azure SDK, which provides methods tailored for these tasks.

---


© D Das  
📧 [das.d@hotmail.com](mailto:das.d@hotmail.com) | [ddasdocs@gmail.com](mailto:ddasdocs@gmail.com)