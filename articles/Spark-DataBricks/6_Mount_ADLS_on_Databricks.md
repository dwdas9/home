---
layout: default
title: Mount ADLS on Databricks
parent: Spark-Databricks
nav_order: 6
---

<details open markdown="block">
  <summary>
    Table of contents
  </summary>
  {: .text-delta }
1. TOC
{:toc}
</details>

## Mount ADLS Gen2 on Databricks Using AAD OAuth & Service Principal

Integrate Databricks with Azure Data Lake Storage Gen2 (ADLS Gen2) securely using Azure Active Directory (AAD) OAuth and a service principal. 

Follow these steps:

1. **Azure Setup**:
   - **Create Service Principal**: In the [Azure Portal](https://portal.azure.com/), navigate to **Azure Active Directory** > **App registrations** > **New registration**. Provide a name and register the application. Save the Application (client) ID and create a new client secret under **Certificates & secrets**. Save the client secret value.
   - **Assign Role**: In your storage account, assign the `Storage Blob Data Contributor` role to the service principal.

2. **Store Credentials in Key Vault**: In Azure Key Vault, add the client ID, client secret, and tenant ID as secrets.

3. **Databricks Configuration**: In your Databricks notebook, follow these steps to configure and mount ADLS Gen2:

   - **Fetch Credentials**:

     ```python
     clientID = dbutils.secrets.get(scope="azbackedscope", key="regappClientID")
     clientSecret = dbutils.secrets.get(scope="azbackedscope", key="regappClientSecret")
     directoryID = dbutils.secrets.get(scope="azbackedscope", key="regappDirectoryID")
     ```

   - **Set OAuth Configs**:

     ```python
     configs = {
         "fs.azure.account.auth.type": "OAuth",
         "fs.azure.account.oauth.provider.type": "org.apache.hadoop.fs.azurebfs.oauth2.ClientCredsTokenProvider",
         "fs.azure.account.oauth2.client.id": clientID,
         "fs.azure.account.oauth2.client.secret": clientSecret,
         "fs.azure.account.oauth2.client.endpoint": f"https://login.microsoftonline.com/{directoryID}/oauth2/token"
     }
     ```

   - **Mount Storage**:

     ```python
     storageAccountName = "your_storage_account_name"
     containerName = "your_container_name"
     mountPoint = "/mnt/your_mount_name"
     
     adlsPath = f"abfss://{containerName}@{storageAccountName}.dfs.core.windows.net/"
     
     dbutils.fs.mount(
         source=adlsPath,
         mount_point=mountPoint,
         extra_configs=configs
     )
     ```

   - **Verify Mount**:

     ```python
     display(dbutils.fs.ls(mountPoint))
     ```

## Conclusion

With ADLS Gen2 storage mounted on DBFS, you can read and write data more conveniently. The code becomes simpler as you don't have to authenticate every time, making it feel like accessing local storage.