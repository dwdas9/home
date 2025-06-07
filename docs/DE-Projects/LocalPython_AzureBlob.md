## Rearranging Files in Azure Blob Storage Using Python

### Background

During some of my projects, I often had to rearrange files inside Azure blob containers. In this write-up, I'm sharing a simple Python method I frequently use with the Azure SDKs. 

But before we dive in, it's essential to understand there are many other ways to achieve the same thing, some of which might be better for regular company setups:

1. You can run Spark externally and use Hadoop Jars with Pyspark. This is quite useful if you're looking for an in-house solution and don't want to spend too much on Databricks or ADFs. I've explained this method in detail in other articles on my site.
2. There are also options like Databricks, Azure Logic Apps, ADF, and the like.

One thing to note: While this Python method is easy, it's a bit slower compared to using Hadoop Jars with Spark. Also, if you're using Python externally, monitoring and maintenance can be a bit challenging.

I'm sharing this technique because it shows the capabilities of Azure SDK when paired with Python for Blob containers. It's good to know what can be done, even if there might be faster or more efficient methods out there.

### Prerequisites
1. Azure Blob Storage Account and a container with files.
2. `azure-identity` and `azure-storage-blob` Python packages. Install these with:
   ```bash
   pip install azure-identity azure-storage-blob
   ```

### Overview
Our primary goal is to rearrange files stored in my container named like `2023-10-23-00.json` into a hierarchical structured format like `year=2023/month=10/day=23/hour=00.json`.

### Kickstart: Step-by-step guide to writing the code

1. **Set up Azure Blob Storage SDK**:
   Start by authenticating against Azure with the credentials from your registered Azure app:
   ```python
   from azure.identity import ClientSecretCredential
   from azure.storage.blob import BlobServiceClient

   credential = ClientSecretCredential(
       tenant_id="YOUR_TENANT_ID", 
       client_id="YOUR_CLIENT_ID", 
       client_secret="YOUR_CLIENT_SECRET"
   )
   
   account_url = "https://YOUR_STORAGE_ACCOUNT_NAME.blob.core.windows.net/"  
   blob_service_client = BlobServiceClient(account_url=account_url, credential=credential)
   ```

2. **Listing Blobs**:
   Retrieve all blobs in your container and then filter the desired files:
   ```python
   container_client = blob_service_client.get_container_client("YOUR_CONTAINER_NAME")
   blobs = container_client.list_blobs()
   old_files = [blob.name for blob in blobs if "-*.json" in blob.name]
   ```

3. **File Rearrangement**:
   Deconstruct each blob's name to get the year, month, day, and hour. Then, design the new path:
   ```python
   for old_file_path in old_files:
       filename = old_file_path.split('/')[-1]
       year, month, day, hour = filename.split('-')[:4]
       new_directory = f"year={year}/month={month}/day={day}/"
       new_blob_path = new_directory + f"hour={hour}.json"
   ```

4. **Copying & Deleting Blobs**:
   Azure Blob Storage requires copying the blob to the new position and deleting the original:
   ```python
   source_blob = container_client.get_blob_client(old_file_path)
   destination_blob = container_client.get_blob_client(new_blob_path)
   destination_blob.start_copy_from_url(source_blob.url)
   source_blob.delete_blob()
   ```

5. **Simulating Directory-like Structure**:
   Azure Blob Storage doesn't have real directories. Instead, using `/` in blob names can emulate directory structures. By copying a blob to a new path with `/`, we can recreate a folder-like structure.

6. **Error Handling**:
   It's essential to manage errors. I ran into an `InvalidUri` error when attempting to create a directory-like structure  using 0-byte blobs. I tackled this by directly copying the blob to the desired path, which handled the pathing effectively.

### Conclusion
Shifting files in Azure Blob Storage can initially appear challenging, mainly due to its flat structure. Nevertheless, with the Azure SDK for Python and the correct strategy, restructuring blobs becomes feasible. Always remember to rigorously test your approach in a non-production environment before applying it to vital data.

### Appendix

#### Why use a structure like `year=2023/month=10/day=23/hour=00.json`?

This hierarchical directory structure aligns very well with common best practices for storing data in columnar storage formats like Parquet and ORC. Here's how:

1. **Partitioning**: The structure `year=2023/month=10/day=23/hour=00.json` inherently sets up partitioning for the data. When converted to Parquet or other storage formats, this structure will make it incredibly efficient to read specific partitions (like all data from a particular month or day) without scanning through the entire dataset. This reduces the amount of data that needs to be read and thus speeds up queries.

2. **Column Pruning**: If your dataset inside the JSON files includes multiple columns, Parquet (and other columnar formats) allows for column pruning. This means that if a particular analysis requires only a subset of columns, only those specific columns are read from the storage, saving both time and resources.

3. **Compression**: Both Parquet and ORC are known for efficient compression. When you have data organized hierarchically, and you're storing it in a columnar format, you can achieve significant storage savings. The structure also ensures that similar data types (like timestamps) are stored together, which can result in better compression ratios.

4. **Compatibility with Big Data Tools**: Tools like Spark and Hive work exceptionally well with columnar storage formats and can directly utilize the hierarchical structure for optimized data reads. If you ever decide to analyze the data using these tools, having them in this structure and format would be advantageous.

5. **Schema Evolution**: One of the advantages of Parquet (and to some extent, ORC) is the support for schema evolution. If your data structure changes over time (new columns are added, for example), these formats can handle those changes gracefully. Having an organized directory structure makes managing these schema changes over different time periods more straightforward.

**Long story short:**

Given these advantages, if you're considering a transition to Parquet or another efficient storage format in the future, this hierarchical structure will certainly come in handy and help in making the data storage and retrieval processes more efficient.

#### Complete tested code

If you want to test the complete code together here is it. Remember, place your original ids, secret in the placeholder. Also, its not a good practice to use creds like this they shoudl be stored in vaults. But for focussing on the core functionality and to reduce the number of code I used the ids and passwords right in the code.

```python
# Import necessary libraries
from azure.identity import ClientSecretCredential
from azure.storage.blob import BlobServiceClient
import re

# Replace your actual Azure 'App registrations' credentials here
tenant_dir_id_regd_app = "YOUR_TENANT_ID"
client_id_regd_app = "YOUR_CLIENT_ID"
client_secret_regd_app = "YOUR_CLIENT_SECRET"

# Specify the Azure Blob container name and storage account name
container_name = "YOUR_CONTAINER_NAME"
storage_act_name = "YOUR_STORAGE_ACCOUNT_NAME"

# Set up authentication using Azure ClientSecretCredential
# This is useful when you're using Azure AD for authentication
credential = ClientSecretCredential(
    tenant_id=tenant_dir_id_regd_app, 
    client_id=client_id_regd_app, 
    client_secret=client_secret_regd_app
)

# Initialize BlobServiceClient with the given account and credentials
account_url = f"https://{storage_act_name}.blob.core.windows.net/"
blob_service_client = BlobServiceClient(account_url=account_url, credential=credential)
container_client = blob_service_client.get_container_client(container_name)

# List all blobs in the specified ADLS container
# Then, filter out the files using a regular expression to match the desired format
blobs = container_client.list_blobs()
old_files = [blob.name for blob in blobs if re.match(r'^\d{4}-\d{2}-\d{2}-\d{2}.json$', blob.name)]

# Display the number of files that match the format and will be processed
print(f"Number of files to be processed: {len(old_files)}")

for old_file_path in old_files:
    # Break down the old file path to extract year, month, day, and hour
    filename = old_file_path.split('/')[-1]
    year, month, day, hour = filename.split('-')[:4]

    # Create the new hierarchical directory structure based on extracted date and time details
    new_blob_path = f"year={year}/month={month}/day={day}/hour={hour}"

    # Display the file movement details
    print(f"Moving {old_file_path} to {new_blob_path}")

    # Copy content from the old blob to the new blob location
    source_blob = container_client.get_blob_client(old_file_path)
    destination_blob = container_client.get_blob_client(new_blob_path)
    destination_blob.start_copy_from_url(source_blob.url)

    # Once the content is successfully copied, remove the old blob
    source_blob.delete_blob()

print("Files rearranged successfully!")

```

---
© D Das  
📧 [das.d@hotmail.com](mailto:das.d@hotmail.com) | [ddasdocs@gmail.com](mailto:ddasdocs@gmail.com)