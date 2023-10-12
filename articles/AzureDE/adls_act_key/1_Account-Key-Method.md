### Accessing ADLS from Databricks Using Account Keys - Shared Access Method:

Three ways to access ADLS are: using **ADLS Account Keys** (often referred to as the **Shared Access Key method**), **SAS tokens**, and **Service Principal (RBAC) with OAuth2**. Of these, the Shared Access Key method is considered the least secure.

To use **ADLS Account Keys**  method:

1. In the Azure Portal, navigate to Storage accounts, select the desired storage account, click on Access keys, and then copy either key1 or key2.
2. Implement the copied key within your code to access the ADLS.

```python
# Configuration for accessing ADLS using the Shared Access Key method:
# - Ensure you replace the 'accountKey' with your actual account key.
# - The ADLS Gen2 paths use the 'abfss' protocol. 
#   The format is 'abfss://<container_name>@<account_name>.dfs.core.windows.net/<path>'.
#   The last line displays the contents of the specified ADLS path using this format.
# - NOTE: For production purposes, it's advisable not to store the account key 
#   directly in the code. Instead, use Databricks' secret management utility as shown in the next block.

storageAccountName = "saforone"
accountKey = "lN7sdfdwl3s+4Bx0mKGTsPW1wShY2I+cSD5HVx0hr9CRzShpNCNhIwVaoDi4b/c8JQQsA4++AStEU1ioQ=="
# accountKey = dbutils.secrets.get(scope="scopeName", key="keyName")  # Recommended method for production
containerName = "demo"
filename = "circuits.csv"

spark.conf.set(f"fs.azure.account.key.{storageAccountName}.dfs.core.windows.net", accountKey)

adls_path = f"abfss://{containerName}@{storageAccountName}.dfs.core.windows.net/"
spark.read.csv(adls_path + filename).show()
```

```python

"""
This script reads a CSV file from Azure Data Lake Storage (ADLS) using an account key stored in Azure Key Vault, accessed via a linked Databricks secret scope.

Prerequisites:
- Create an Azure Key Vault-backed secret scope in Databricks.
- Obtain the account key from Azure: Azure Portal > Storage Account > Access keys > key1/key2.
- Set up this secret scope to contain your ADLS access key.
- Ensure the 'AzureDatabricks' app has the appropriate role in Azure Key Vault to access secrets.
- spark.conf.set("fs.azure", "org.apache.hadoop.fs.azurebfs.AzureBlobFileSystem") is required if the same code is executed in Spark rather than Databricks
"""

storageAccountName = "saforone"
accountKey = dbutils.secrets.get(scope="azbackedscope", key="access-key-saforone")
containerName = "demo"
filename = "circuits.csv"


spark.conf.set(f"fs.azure.account.key.{storageAccountName}.dfs.core.windows.net", accountKey)

adls_path = f"abfss://{containerName}@{storageAccountName}.dfs.core.windows.net/"
spark.read.csv(adls_path + filename).show()
```