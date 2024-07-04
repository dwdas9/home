---
layout: default
title: Flatten Json Using Azure SDK
parent: Languages
---

## <span style="color: SlateGray;Font-family: Segoe UI, sans-serif;">Table of Contents</span>

- [Flatten JSON Files in Azure Blob Storage using Azure SDK for Python](#flatten-json-files-in-azure-blob-storage-using-azure-sdk-for-python)
  - [Background](#background)
  - [Prerequisites](#prerequisites)
  - [Create the script](#create-the-script)
  - [Explanation of key elements in the script](#explanation-of-key-elements-in-the-script)
  - [Appendix](#appendix)
    - [The complete script](#the-complete-script)
    - [Azure Python SDK(libs) ecosystem](#azure-python-sdklibs-ecosystem)
    - [Convert the script into an Azure Function](#convert-the-script-into-an-azure-function)


# <span style="color: Teal;Font-family: Segoe UI, sans-serif;">Flatten JSON Files in Azure Blob Storage using Azure SDK for Python</span>

## <span style="color: PaleVioletRed;Font-family: Segoe UI, sans-serif;">Background</span>

A ADLS container has many JSON files with nested structure. This article shows how to flatten those Json files for better handling later.

## <span style="color: blueviolet;Font-family: Segoe UI, sans-serif;">Prerequisites</span>



- A python-development ready VS Code environment
- Install the required Azure SDK(libs) to work with Azure storage.

```bash
pip install azure-storage-blob
```
- A source container with the JSON files.
- A destination container where the flattened json will be kept. The script can either replace the original files with the processed ones or store them in a separate folder.
- Storage account keys. This code uses Account key method to authenticate. You can get the keys using these steps:
  - Open the **Storage Accounts** containing the container. Go to **Settings**,  **Access keys**.
  - Copy and keep the **Connection string** from here.


## <span style="color: DodgerBlue;Font-family: Segoe UI, sans-serif;">Create the script</span>



To create the Python code in Visual Studio Code follow these steps:

- Create a new file with the `.py` extension.
- Import the necessary libraries:

```python
import json
from azure.storage.blob import BlobServiceClient
import logging
```

- Define the `flatten_json()` function:

```python
def flatten_json(y, parent_key='', sep='_'):
  items = []
  for k, v in y.items():
    new_key = f"{parent_key}{sep}{k}" if parent_key else k
    if isinstance(v, dict):
      items.extend(flatten_json(v, new_key, sep=sep).items())
    else:
      items.append((new_key, v))
  return dict(items)
```

- Define the `main()` function:

```python
def main():
  # Initialize Blob Service Client
  blob_service_client = BlobServiceClient.from_connection_string(
    "DefaultEndpointsProtocol=https;AccountName=<Your_Storage_Account_Name>;AccountKey=<The_Storage_Act_Key>;EndpointSuffix=core.windows.net")

  # Iterate over blobs in the "source_container" container
  container_client = blob_service_client.get_container_client("source_container")
  for blob in container_client.list_blobs():
    try:
      # Download the blob
      blob_client = blob_service_client.get_blob_client(container="dest_container", blob=blob.name)
      data_str = blob_client.download_blob().readall().decode('utf-8')

      # Decode the blob data to a string
      data = json.loads(data_str)

      # Flatten the JSON data
      flattened_data = flatten_json(data)

      # Move blob to the "silver" container
      target_blob_client = blob_service_client.get_blob_client(container="dest_container", blob=blob.name)
      target_blob_client.upload_blob(json.dumps(flattened_data), overwrite=True)

      # Delete the original blob (optional)
      # blob_client.delete_blob()
    except Exception as e:
      logging.error(f"Error processing blob {blob.name}: {e}")

if __name__ == "__main__":
  main()
```

- Save the file.
- Press `F5` to run the code.

## <span style="color: Red;Font-family: Segoe UI, sans-serif;">Explanation of key elements in the script</span>

Here is what the scirpt does. This will help you understand how Azure SDK for Blob Stroage works:

1. **Initializes a BlobServiceClient object** using the `from_connection_string()` method. This object is used to interact with the Azure Blob Storage service.
2. **Gets a container client** for the `silver` container using the `get_container_client()` method. This object is used to interact with the specified container.
3. **Iterates over all blobs in the container** using the `list_blobs()` method.
4. For each blob, the function does the following:
    * **Downloads the blob** using the `get_blob_client()` and `download_blob()` methods.
    * **Decodes the blob data** to a string using the `decode()` method.
    * **Parses the JSON data** in the string using the `json.loads()` function.
    * **Flattens the JSON data** using the `flatten_json()` function that we provided.
    * **Moves the blob to the `silver` container** using the `upload_blob()` method.
    * **Deletes the original blob** (optional).

## <span style="color: DarkOrchid;Font-family: Segoe UI, sans-serif;">Appendix</span>

### <span style="color: Indigo;Font-family: Segoe UI, sans-serif;">The complete script</span>


Here is the complete script in one piece:

```python

"""
Author: Das
LTS: Very easy to run this code. Just pip install azure-storage-blob. And run the code anywhere with python.
    Fully working code anywhere. Windows/Ubuntu.
---
This script uses Azure SDK BlobServiceClient class to interact with Azure Blob Storage. It downloads blobs from a container, 
flattens their JSON content, and uploads them back to another container. 

The BlobServiceClient class is part of the Azure SDK for Python and is used to interact with Azure Blob Storage. 
    It provides methods for getting clients for specific containers and blobs, downloading blobs, and uploading blobs.
    The from_connection_string method is used to create an instance of BlobServiceClient using a connection string.
    The download_blob method returns a stream of data that can be read by calling readall.
    The upload_blob method uploads data to a blob, overwriting it if it already exists.
"""

import json
from azure.storage.blob import BlobServiceClient # BlobServiceClient is part of the Azure SDK for Python. It's used to interact with Azure Blob Storage.
import logging

# Function to flatten JSON objects
def flatten_json(y, parent_key='', sep='_'):
    items = []
    for k, v in y.items():
        new_key = f"{parent_key}{sep}{k}" if parent_key else k
        if isinstance(v, dict):
            items.extend(flatten_json(v, new_key, sep=sep).items())
        else:
            items.append((new_key, v))
    return dict(items)

# Main function
def main():
    # Initialize Blob Service Client using connection string. This is the main entry point for interacting with blobs in Azure Storage.
    blob_service_client = BlobServiceClient.from_connection_string("DefaultEndpointsProtocol=https;AccountName=<your-storage-account-Name>;AccountKey=<Your_Storage_Act_Con_String>;EndpointSuffix=core.windows.net")

    # Get a client for the "silver" container in the Blob Service. This client provides operations to interact with a specific container.
    container_client = blob_service_client.get_container_client("silver")
    # Iterate over blobs in the "weather-http" container
    for blob in container_client.list_blobs():
        try:
            # Get a client for the current blob. This client provides operations to interact with a specific blob.
            blob_client = blob_service_client.get_blob_client(container="silver", blob=blob.name)
            # Download the blob data and decode it from bytes to string. The download_blob method returns a stream of data.
            data_str = blob_client.download_blob().readall().decode('utf-8')

            try:
                data = json.loads(data_str)
            except json.JSONDecodeError:
                data = json.loads(blob_client.download_blob().readall().decode('utf-8'))

            # Flatten the JSON data
            flattened_data = flatten_json(data)

            # Get a client for the target blob in the "silver" container. This client will be used to upload data to this blob. Move blob to the "silver" container
            target_blob_client = blob_service_client.get_blob_client(container="silver", blob=blob.name)
            # Upload the flattened JSON data to the target blob, overwriting it if it already exists. The upload_blob method uploads data to a blob.
            target_blob_client.upload_blob(json.dumps(flattened_data), overwrite=True)
            
            # Uncomment the following line to delete the original blob after moving it to the "silver" container
            #blob_client.delete_blob()  # Delete the original blob after moving

        except Exception as e:
            logging.error(f"Error processing blob {blob.name}: {e}")

if __name__ == "__main__":
    main()

```

### <span style="color: LimeGreen;Font-family: Segoe UI, sans-serif;">Azure Python SDK(libs) ecosystem</span>


| Library                  | Explanation                                                                |
|--------------------------|----------------------------------------------------------------------------|
|🐍<span style="color: navy; font-weight: bold; font-size: 19px;">Azure SDK For Python</span> | Superset of all python packages (libs) for Azure. Can't be installed with a single pip. |
|📦 <span style="color: teal; font-weight: bold; font-size: 18px;">Azure Storage SDKs</span> | Subset of Azure SDK. Multiple libraries. Hence, no single pip command. |
|💦 <span style="color: olive; font-weight: bold; font-size: 16px;">Azure Blob Storage SDK</span> | Subset of Azure Storage SDK. Single Library - `pip install azure-storage-blob` |
|🛠️ <span style="color: maroon; font-weight: bold; font-size: 15px;">BlobServiceClient Class</span> | Storage Account Level |
|📁 <span style="color: darkgreen; font-weight: bold; font-size: 14px;">Container Client Class</span> | Container Level |
|📄 <span style="color: darkviolet; font-weight: bold; font-size: 13px;">Blob Client Class</span> | Blob Level |

### <span style="color: Chocolate;Font-family: Segoe UI, sans-serif;">Convert the script into an Azure Function</span>


The logic from my script can be easily incoporated into an azure function. You can easily put the entire logic into the functions `function_app.py`. Refer to my other articles on how to work with Azure Functions.

🌟 **Conclusion**: The Azure SDK for Python is a superset of libraries to work with Azure services. The Azure Blob Storage SDK for Python is a subset of the Azure SDK for working with Azure Blob Storage.

The script in this article uses the Azure Blob Storage SDK for Python to flatten JSON files in an Azure Blob Storage container. The script first downloads the blob from the container, then flattens the JSON data, and finally uploads the flattened JSON data back to the container.

---

© D Das  
📧 [das.d@hotmail.com](mailto:das.d@hotmail.com) | [ddasdocs@gmail.com](mailto:ddasdocs@gmail.com)