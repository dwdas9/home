---
layout: default
title: Json To Parquet Using Spark And Azure
parent: PythonEcosystem
---

<img src="images\json_spark_azure.png" alt="Warehouse Directory" style="border: 2px solid #ccc; box-shadow: 3px 3px 8px rgba(0, 0, 0, 0.2); border-radius: 10px;">

## <span style="color: DimGray;">Table of Contents</span>
- [Json Transformation Using Spark And Azure](#json-transformation-using-spark-and-azure)
  - [Prerequisites](#prerequisites)
  - [Script Breakdown](#script-breakdown)
    - [Initialize Spark Session](#initialize-spark-session)
    - [Fetch and Load JSON Data](#fetch-and-load-json-data)
    - [Define Paths and Partition Data](#define-paths-and-partition-data)
    - [Stop Spark Session](#stop-spark-session)
  - [Appendix](#appendix)
    - [Reason for Partitioning](#reason-for-partitioning)
    - [Register App and Assign Blob Contributor Role](#register-app-and-assign-blob-contributor-role)
    - [The complete script](#the-complete-script)
  - [Conclusion](#conclusion)



# <span style="color: DarkOrchid;">Json Transformation Using Spark And Azure</span>

<p style="color: #006600; font-family: 'Trebuchet MS', Helvetica, sans-serif; background-color: #e6ffe6; padding: 15px; border-left: 5px solid #00cc66;">In this article, I'll guide you on how to retrieve JSON data from an online API using Spark and Hadoop tools. We'll learn to split the data and save it in a 'silver' level. Then, we'll take the data from 'silver', partition it again, and store it in a *'gold'* level as Parquet files. This process is in line with the lakehouse architecture standards too.
</p>

## <span style="color: #7e0041;">Prerequisites</span>

You'll need the following:

- **Azure Subscription**: For using Azure services.
- **Azure Data Lake Storage Gen2**: Two contaienrs, **silver** and **gold** inside a storage account.
- **Python with Pyspark** : To develop and test this code a simple pyspark environment will do.
- **Hadoop ADLS Jars**: You need to download the jars using tools like wget and store it and then refrence it in spark configuration. To know more refer to my [article](../Spark_To_ADLS/Part1-spark_to_ADLS.html).

## <span style="color: MediumSeaGreen;">Script Breakdown</span>

### <span style="color: Goldenrod">Initialize Spark Session</span>

The script starts by creating a spark session by passing the downloaded hadoop jars for ADLS. The authentication method used is OAuth with service princiapl. Note, the registered app should have **storage blob contributor role** at the storage account level(preferred) or individually for silver and bronze. See appendix below.

```python
# Author: Das, Purpose: Fetch and Partition Jsons
from pyspark.sql import SparkSession
import requests

# Note: Chek your actual client ID, tenant ID, and client secret value. Your's will be diffferent
storage_account_name = "TheStorageAccountNameHoldingSilverAndGoldContainers"
regapp_client_id = "Registered App's Client_ID"
regapp_directory_id = "Registered App's Directory ID"
regapp_client_secret = "Registered App's Client Secret Value"

# Initialize Spark session with Azure Data Lake Storage Gen2 configurations for OAuth Authentication using service princiapl
spark = SparkSession.builder \
    .appName("ADLS Access") \
    .config("spark.jars", 
             "/usr/local/lib/python3.8/dist-packages/pyspark/jars/hadoop-azure-3.3.3.jar,"\
             "/usr/local/lib/python3.8/dist-packages/pyspark/jars/hadoop-azure-datalake-3.3.3.jar,"\
             "/usr/local/lib/python3.8/dist-packages/pyspark/jars/hadoop-common-3.3.3.jar") \
    .config(f"fs.azure.account.auth.type.{storage_account_name}.dfs.core.windows.net", "OAuth") \
    .config(f"fs.azure.account.oauth.provider.type.{storage_account_name}.dfs.core.windows.net", "org.apache.hadoop.fs.azurebfs.oauth2.ClientCredsTokenProvider") \
    .config(f"fs.azure.account.oauth2.client.id.{storage_account_name}.dfs.core.windows.net", regapp_client_id) \
    .config(f"fs.azure.account.oauth2.client.secret.{storage_account_name}.dfs.core.windows.net", regapp_client_secret) \
    .config(f"fs.azure.account.oauth2.client.endpoint.{storage_account_name}.dfs.core.windows.net", f"https://login.microsoftonline.com/{regapp_directory_id}/oauth2/token") \
    .getOrCreate()
```

### <span style="color: CadetBlue">Fetch and Load JSON Data</span>

The next snippet fetches JSON data from a web API using the `requests` library and loads it into a DataFrame:

```python
import requests

# URL of the JSON data source
json_url = 'https://data.ct.gov/resource/5mzw-sjtu.json'
response = requests.get(json_url)
json_data = response.json()

# Convert JSON to a DataFrame
df = spark.createDataFrame(json_data)
```

### <span style="color: #9e0059;">Define Paths and Partition Data</span>

It's crucial to define the storage paths for 'silver' and 'gold' layers. Here's how the script partitions data:

```python
# Define base paths for silver and gold storage layers
silver_path = f"abfss://{storage_account_name}.dfs.core.windows.net/silver"
gold_path = f"abfss://{storage_account_name}.dfs.core.windows.net/gold"

# Example column to partition the data by
partition_column = 'date_column'

# Write the data to the silver layer, partitioned by 'partition_column'
df.write.partitionBy(partition_column).mode("overwrite").json(silver_path)

# Read and rename the partition column for clarity
df_silver = spark.read.json(silver_path).withColumnRenamed(partition_column, "date_partition")

# Write the transformed data to the gold layer as Parquet
df_silver.write.partitionBy("date_partition").mode("overwrite").parquet(gold_path)
```

### <span style="color: PaleVioletRed">Stop Spark Session</span>

Once all operations are complete, terminate the Spark session:

```python
spark.stop()
```

## <span style="color: DarkBlue">Appendix</span>

### <span style="color: DarkGreen">Reason for Partitioning</span>

Partitioning is crucial when dealing with large datasets. It helps in breaking the data into smaller, more manageable pieces, which can be processed faster and more efficiently. In this script, I have partitoned the data by date_column. However, you can partiton it further by other criteria.


### <span style="color: DimGray">Register App and Assign Blob Contributor Role</span>

<p style="font-family: 'Segoe UI', sans-serif; color: #555;">
Follow these merged steps to register your app in Azure AD and give it access to the silver and gold containers:
</p>

- Go to <span style="color: #004d99;">Azure Portal</span> → <span style="color: #004d99;">Azure Active Directory</span> → <span style="color: #004d99;">App registrations</span>, and create a new registration. Note your Application (client) ID and Directory (tenant) ID.
- Within the app, navigate to <span style="color: #004d99;">Certificates & secrets</span> to generate a new client secret. Remember to save the client secret value securely.
- In your Azure Storage account, under <span style="color: #004d99;">Access Control (IAM)</span>, add a role assignment. Select <span style="color: #4d9900;">"Storage Blob Data Contributor"</span> and assign it to your registered app using the Application (client) ID.

### <span style="color: SaddleBrown">The complete script</span>

You can use this script directly in a jupyter notebook or create a function with it. For higher loads the script can be run in spark cluster.

```python

from pyspark.sql import SparkSession
import requests

# Note: Chek your actual client ID, tenant ID, and client secret value. Your's will be diffferent
storage_account_name = "<input yours here>"
regapp_client_id = "<input yours here>"
regapp_directory_id = "<input yours here>"
regapp_client_secret = "<input yours here>"

# Initialize Spark session with Azure Data Lake Storage Gen2 configurations for OAuth Authentication using service princiapl
spark = SparkSession.builder \
    .appName("ADLS Access") \
    .config("spark.jars", 
             "/usr/local/lib/python3.8/dist-packages/pyspark/jars/hadoop-azure-3.3.3.jar,"\
             "/usr/local/lib/python3.8/dist-packages/pyspark/jars/hadoop-azure-datalake-3.3.3.jar,"\
             "/usr/local/lib/python3.8/dist-packages/pyspark/jars/hadoop-common-3.3.3.jar") \
    .config(f"fs.azure.account.auth.type.{storage_account_name}.dfs.core.windows.net", "OAuth") \
    .config(f"fs.azure.account.oauth.provider.type.{storage_account_name}.dfs.core.windows.net", "org.apache.hadoop.fs.azurebfs.oauth2.ClientCredsTokenProvider") \
    .config(f"fs.azure.account.oauth2.client.id.{storage_account_name}.dfs.core.windows.net", regapp_client_id) \
    .config(f"fs.azure.account.oauth2.client.secret.{storage_account_name}.dfs.core.windows.net", regapp_client_secret) \
    .config(f"fs.azure.account.oauth2.client.endpoint.{storage_account_name}.dfs.core.windows.net", f"https://login.microsoftonline.com/{regapp_directory_id}/oauth2/token") \
    .getOrCreate()

# Azure Storage configuration
silver_container_name = "silver"
gold_container_name = "gold"

# Download JSON data from the web
json_url = 'https://data.ct.gov/resource/5mzw-sjtu.json'
response = requests.get(json_url)
json_data = response.json()
# Assuming json_data is a list of dictionaries (records)
# Create a DataFrame from the JSON data
df = spark.createDataFrame(json_data)

# Define the base path for silver and gold containers
base_silver_path = f"abfss://{silver_container_name}@{storage_account_name}.dfs.core.windows.net/"
base_gold_path = f"abfss://{gold_container_name}@{storage_account_name}.dfs.core.windows.net/"

# Add the relative path and partition the data by the 'date_column'
# Replace 'date_column' with the actual column name you want to partition on
partition_column = 'daterecorded'  # Example partition column. You can choose another column in your case.
silver_path = f"{base_silver_path}data/"
gold_path = f"{base_gold_path}data/"

# Write JSON data to the silver container, partitioned by 'date_column'
df.write.partitionBy(partition_column).mode("overwrite").json(silver_path)

# Read the JSON file back into a DataFrame, it will recognize partitions automatically
df_silver = spark.read.json(f"{silver_path}").withColumnRenamed("daterecorded", "date_partition")

# Write the DataFrame to the gold container as a Parquet file, also partitioned
df_silver.write.partitionBy("date_partition").mode("overwrite").parquet(gold_path)

# Stop the Spark session
spark.stop()

```

## <span style="color: DeepPink">Conclusion</span>

<p style="color: #804000; font-family: 'Courier New', Courier, monospace; background-color: #fff5e6; padding: 15px; border-left: 5px solid #b35900;">
This is a versatile script that can be executed directly in a Jupyter notebook or encapsulated within a function for convenience. With minor configuration tweaks it can be run in a spark cluster to handle larger workloads. Note: with this script you might see warnings like *Warning: Ignoring non-Spark config property: fs.azure.account.oauth.provider.type.strgacweatherapp.dfs.core.windows.net*
</p>