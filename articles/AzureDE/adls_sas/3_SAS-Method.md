"""
This script accesses a CSV file from Azure Data Lake Storage (ADLS) using a Shared Access Signature (SAS) token and displays its content in Databricks.

To obtain the SAS token:
1. Navigate to the Azure Portal.
2. Select the desired Storage Account or file
3. In the left navigation pane, under 'Security + networking', choose 'Shared access signature'.
4. Configure the desired permissions, start and expiry times, and other settings.
5. Click 'Generate SAS and connection string'.
6. Add the generated SAS token to the Azure Key Vault.
"""


storageAccountName = "saforone" 
sasToken = "sp=r&st=2023-10-09T05:51:24Z&se=2023-10-19T13:51:24Z&spr=https&sv=2022-11-02&sr=b&sig=8kEnKtmMkWxDnEN3IrWm6zQpz4q2VIzewkcbX7d3Wes%3D" 
containerName = "demo"
filename = "circuits.csv"

spark.conf.set(f"fs.azure.sas.{containerName}.{storageAccountName}.dfs.core.windows.net", sasToken) 
adls_path = f"abfss://{containerName}@{storageAccountName}.dfs.core.windows.net/" 
spark.read.csv(adls_path + filename).show()