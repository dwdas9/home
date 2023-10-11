"""
This script fetches and reads a CSV file from Azure Data Lake Storage (ADLS) using OAuth authentication with Service Principal credentials stored in a Databricks secret scope linked to Azure Key Vault.
"""
storageAccountName = "saforone"
containerName = "demo"
filename = "circuits.csv"
clientID = dbutils.secrets.get(scope="azbackedscope", key="regappClientID")
clientSecret = dbutils.secrets.get(scope="azbackedscope", key="regappClientSecret")
directoryID = dbutils.secrets.get(scope="azbackedscope", key="regappDirectoryID")


spark.conf.set(f"fs.azure.account.auth.type.{storageAccountName}.dfs.core.windows.net", "OAuth")
spark.conf.set(f"fs.azure.account.oauth.provider.type.{storageAccountName}.dfs.core.windows.net", "org.apache.hadoop.fs.azurebfs.oauth2.ClientCredsTokenProvider")
spark.conf.set(f"fs.azure.account.oauth2.client.id.{storageAccountName}.dfs.core.windows.net", clientID)
spark.conf.set(f"fs.azure.account.oauth2.client.secret.{storageAccountName}.dfs.core.windows.net", clientSecret)
spark.conf.set(f"fs.azure.account.oauth2.client.endpoint.{storageAccountName}.dfs.core.windows.net", f"https://login.microsoftonline.com/{directoryID}/oauth2/token")

# For debugging: retrieve and print the client ID configuration.
# print(spark.conf.get(f"fs.azure.account.oauth2.client.id.{storage_account}.dfs.core.windows.net"))

adls_path = f"abfss://{containerName}@{storageAccountName}.dfs.core.windows.net/"
spark.read.csv(adls_path + filename).show()