---
layout: default
title: Mount ADLS on Databricks
parent: Spark-Databricks
---

## Mounting ADLS Gen2 on Databricks using AAD OAuth & Service Principal

Integrating Databricks with Azure Data Lake Storage Gen2 (ADLS Gen2) through Azure Active Directory (AAD) OAuth and service principal provides a secure data access method. This tutorial quickly guides you through mounting ADLS Gen2 storage to the Databricks File System (DBFS).

### Quick Steps:

1. **Azure Setup**:
   - Have an ADLS Gen2 storage account.
   - Set up a service principal in Azure AD.

| Step | Action | Details |
|------|--------|---------|
| 1 | **Azure Portal** | Navigate to [Azure Portal](https://portal.azure.com/). |
| 2 | **Azure AD** | Select "Azure Active Directory" > "App registrations". |
| 3 | **New Registration** | Click "+ New registration". |
| 4 | **Details** | Provide a name, select account type, and set the redirect URI (if needed). |
| 5 | **Register** | Click "Register". Note down the Application (client) ID. |
| 6 | **Certificates & secrets** | Under "Manage", select "Certificates & secrets". |
| 7 | **New Client Secret** | Click "+ New client secret". Provide a description and select the expiration. |
| 8 | **Save Secret** | After adding, save the value of the client secret. <br> **To Azure Key Vault:** <table><tr><td>1. **Navigate**</td><td>Go to Azure Key Vault in the portal.</td></tr><tr><td>2. **Select or Create**</td><td>Choose an existing vault or create a new one.</td></tr><tr><td>3. **Secrets Section**</td><td>Click on "Secrets" in the left pane.</td></tr><tr><td>4. **+ Generate/Import**</td><td>Add the new secret, give it a name and paste the value.</td></tr></table> |

  - Make sure to properly set permissions on the Key Vault to allow the necessary entities (like applications or users) to access the secret.
  - Remember to store the client secret securely; it's displayed only once.

   - Grant `Storage Blob Data Contributor` role to the service principal on the storage.

2. **Fetch Credentials**:
   <sub>Use Databricks secrets for security.</sub>
   ```python
   clientID = dbutils.secrets.get(scope="azbackedscope", key="regappClientID")
   clientSecret = dbutils.secrets.get(scope="azbackedscope", key="regappClientSecret")
   directoryID = dbutils.secrets.get(scope="azbackedscope", key="regappDirectoryID")
   ```

3. **Set OAuth Configs**:
   <sub>Prepare OAuth authentication dictionary.</sub>
   ```python
   configs = {
       "fs.azure.account.auth.type": "OAuth",
       "fs.azure.account.oauth.provider.type": "org.apache.hadoop.fs.azurebfs.oauth2.ClientCredsTokenProvider",
       "fs.azure.account.oauth2.client.id": clientID,
       "fs.azure.account.oauth2.client.secret": clientSecret,
       "fs.azure.account.oauth2.client.endpoint": f"https://login.microsoftonline.com/{directoryID}/oauth2/token"
   }
   ```

4. **Mount Storage**:
   ```python
   adlsPath = f"abfss://{containerName}@{storageAccountName}.dfs.core.windows.net/"
   mountPoint = "/mnt/your_mount_name"
   
   dbutils.fs.mount(
       source=adlsPath,
       mount_point=mountPoint,
       extra_configs=configs
   )
   ```

5. **Check Mount**:
   <sub>Validate with a quick file list.</sub>
   ```python
   display(dbutils.fs.ls(mountPoint))
   ```
### Conclusion:

With the ADLS Gen2 storage now mounted on DBFS, you can easily read/write data using the DBFS path, offering a streamlined and secure way to integrate Databricks with ADLS Gen2 using Azure Active Directory (AAD) OAuth authentication.

```python
"""
This script is designed to mount Azure Data Lake Storage Gen2 (ADLS Gen2) into the Databricks File System.
ADLS Gen2 is accessed using the `abfss` scheme which denotes Azure Blob File System with SSL.
The script employs Azure Active Directory (AAD) OAuth authentication leveraging a service principal.
"""
# Define the Azure Data Lake Storage Gen2 account details.
storageAccountName = "saforone"
containerName = "demo"
fileName = "circuits.csv"

# Fetch the service principal credentials from a Databricks secret scope linked to Azure Key Vault.
clientID = dbutils.secrets.get(scope="azbackedscope", key="regappClientID")
clientSecret = dbutils.secrets.get(scope="azbackedscope", key="regappClientSecret")
directoryID = dbutils.secrets.get(scope="azbackedscope", key="regappDirectoryID")

# Construct the full path to the ADLS Gen2 location using the `abfss` scheme.
adlsPath = f"abfss://{containerName}@{storageAccountName}.dfs.core.windows.net/"

# Define the OAuth configurations for accessing ADLS Gen2 - OAuth token provider, service principal credentials and endpoint
configs = {
    "fs.azure.account.auth.type": "OAuth",
    "fs.azure.account.oauth.provider.type": "org.apache.hadoop.fs.azurebfs.oauth2.ClientCredsTokenProvider",
    "fs.azure.account.oauth2.client.id": clientID,
    "fs.azure.account.oauth2.client.secret": clientSecret,
    "fs.azure.account.oauth2.client.endpoint": f"https://login.microsoftonline.com/{directoryID}/oauth2/token"
}

# Define the Databricks mount point. Note: mount points in Databricks should always start with "/mnt/".
mountPoint = "/mnt/forone/demo"

# Mount ADLS Gen2 storage to the Databricks File System.
dbutils.fs.mount(
  source=adlsPath,
  mount_point=mountPoint,
  extra_configs=configs
)

# Display the contents of the mounted ADLS Gen2 location.
display(dbutils.fs.ls(mountPoint))

```