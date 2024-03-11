---
layout: default
title: SPARK in Docker One Master Two Worker
parent: Azure Articles
---
## <span style="color: #7e0041;">Table Of Contents</span>

- [Connecting to Azure Storage from Spark: Methods and Code Samples](#connecting-to-azure-storage-from-spark-methods-and-code-samples)
  - [Overview](#overview)
  - [Method 1: ABFS Driver for ADLS Gen2](#method-1-abfs-driver-for-adls-gen2)
    - [Sample Code for ABFS Driver:](#sample-code-for-abfs-driver)
  - [Method 2: Managed Identity for Azure-hosted Spark](#method-2-managed-identity-for-azure-hosted-spark)
    - [Sample Code for Managed Identity:](#sample-code-for-managed-identity)
  - [Method 3: Azure Blob Storage with Access Key](#method-3-azure-blob-storage-with-access-key)
    - [Sample Code for Access Key:](#sample-code-for-access-key)
  - [Method 4: Shared Access Signature (SAS)](#method-4-shared-access-signature-sas)
    - [Sample Code for SAS:](#sample-code-for-sas)
  - [Method 5: Environment Variables/Secrets](#method-5-environment-variablessecrets)
    - [Sample Code for Using Environment Variables/Secrets:](#sample-code-for-using-environment-variablessecrets)

# Connecting to Azure Storage from Spark: Methods and Code Samples

<p style="color: #006600; font-family: 'Trebuchet MS', Helvetica, sans-serif; background-color: #e6ffe6; padding: 15px; border-left: 5px solid #00cc66;">
In this guide, I will walk you through the different methods to connect Apache Spark to Azure Storage services including Azure Blob Storage and Azure Data Lake Storage. You will learn how to set up your Spark session to read and write data from and to Azure Storage using various authentication methods.
</p>

## <span style="color: #7e0041;">Overview</span>

Connecting Apache Spark to Azure Storage can be achieved through several methods, each suited for different scenarios and security requirements. We will cover the use of ABFS driver for Azure Data Lake Storage Gen2, managed identities in Azure-hosted Spark, shared access signatures, and more.

## <span style="color: #3333cc;">Method 1: ABFS Driver for ADLS Gen2</span>

<p style="color: #804000; font-family: 'Courier New', Courier, monospace; background-color: #fff5e6; padding: 15px; border-left: 5px solid #b35900;">
The ABFS (Azure Blob File System) driver is specially designed for Azure Data Lake Storage Gen2 and supports OAuth2 authentication, providing a secure method to access your data.
</p>

### <span style="color: #9e0059;">Sample Code for ABFS Driver</span>:

Here is a sample code to connect using OAuth authentication and service principal. The code requires Haddop Azure Storagae Jars which needs to be downloaded spearately.

```python
from pyspark.sql import SparkSession

# Replace with your Azure Storage account information
storage_account_name = "your_storage_account_name"
client_id = "your_client_id_of_the_registered_app"
client_secret = "your_client_secret_of_the_registered_app"
tenant_id = "your_tenant_id_of_the_registered_app"

spark = SparkSession.builder \
    .appName("Any_App_Name") \
    .config("spark.jars", 
             "/usr/local/lib/python3.8/dist-packages/pyspark/jars/hadoop-azure-3.3.3.jar,"\
             "/usr/local/lib/python3.8/dist-packages/pyspark/jars/hadoop-azure-datalake-3.3.3.jar,"\
             "/usr/local/lib/python3.8/dist-packages/pyspark/jars/hadoop-common-3.3.3.jar") \
    .config(f"fs.azure.account.auth.type.{storage_account_name}.dfs.core.windows.net", "OAuth") \
    .config(f"fs.azure.account.oauth.provider.type.{storage_account_name}.dfs.core.windows.net", "org.apache.hadoop.fs.azurebfs.oauth2.ClientCredsTokenProvider") \
    .config(f"fs.azure.account.oauth2.client.id.{storage_account_name}.dfs.core.windows.net", client_id) \
    .config(f"fs.azure.account.oauth2.client.secret.{storage_account_name}.dfs.core.windows.net", client_secret) \
    .config(f"fs.azure.account.oauth2.client.endpoint.{storage_account_name}.dfs.core.windows.net", f"https://login.microsoftonline.com/{tenant_id}/oauth2/token") \
    .getOrCreate()
```

## <span style="color: #3333cc;">Method 2: Managed Identity for Azure-hosted Spark</span>

<p style="color: #804000; font-family: 'Courier New', Courier, monospace; background-color: #fff5e6; padding: 15px; border-left: 5px solid #b35900;">
For Spark clusters hosted on Azure, Managed Identity offers a way to securely access Azure services without storing credentials in your code.
</p>

### <span style="color: #9e0059;">Sample Code for Managed Identity</span>:

```python
from pyspark.sql import SparkSession

spark = SparkSession.builder \
    .appName("Azure Blob with Managed Identity") \
    .config("fs.azure.account.auth.type.<storage_account_name>.blob.core.windows.net", "CustomAccessToken") \
    .config("fs.azure.account.custom.token.provider.class.<storage_account_name>.blob.core.windows.net", "org.apache.hadoop.fs.azurebfs.oauth2.ManagedIdentityCredentialProvider") \
    .getOrCreate()
```

## <span style="color: #3333cc;">Method 3: Azure Blob Storage with Access Key</span>

<p style="color: #804000; font-family: 'Courier New', Courier, monospace; background-color: #fff5e6; padding: 15px; border-left: 5px solid #b35900;">
Using the Azure Blob Storage access key is a straightforward method to establish a connection, but it's less secure than using OAuth2 or Managed Identities.
</p>

### <span style="color: #9e0059;">Sample Code for Access Key</span>:

```python
from pyspark.sql import SparkSession

spark = SparkSession.builder \
    .appName("Azure Blob Access with Access Key") \
    .config("fs.azure.account.key.<storage_account_name>.blob.core.windows.net", "<access_key>") \
    .getOrCreate()
```

## <span style="color: #3333cc;">Method 4: Shared Access Signature (SAS)</span>

<p style="color: #804000; font-family: 'Courier New', Courier, monospace; background-color: #fff5e6; padding:
15px; border-left: 5px solid #b35900;">
Shared Access Signatures (SAS) provide a secure way to grant limited access to your Azure Storage resources without exposing your account key.
</p>

### <span style="color: #9e0059;">Sample Code for SAS</span>:

```python
from pyspark.sql import SparkSession

spark = SparkSession.builder \
    .appName("Azure Blob Access with SAS") \
    .config("fs.azure.sas.<container_name>.<storage_account_name>.blob.core.windows.net", "<sas_token>") \
    .getOrCreate()
```

## <span style="color: #3333cc;">Method 5: Environment Variables/Secrets</span>

<p style="color: #804000; font-family: 'Courier New', Courier, monospace; background-color: #fff5e6; padding: 15px; border-left: 5px solid #b35900;">
For an extra layer of security, use environment variables or a secret scope to manage your credentials, keeping them out of your code base.
</p>

### <span style="color: #9e0059;">Sample Code for Using Environment Variables/Secrets</span>:

```python
import os
from pyspark.sql import SparkSession

# Assume the environment variables or secrets are already set
storage_account_name = os.getenv('STORAGE_ACCOUNT_NAME')
sas_token = os.getenv('SAS_TOKEN')

spark = SparkSession.builder \
    .appName("Azure Blob Access with Environment Variables") \
    .config(f"fs.azure.sas.<container_name>.{storage_account_name}.blob.core.windows.net", sas_token) \
    .getOrCreate()
```

