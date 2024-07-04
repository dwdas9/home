---
layout: default
title: Meet Mr. Azure Blob
parent: Azure Articles
nav_order: 1
---
- [Meet Mr. Azure Blob](#meet-mr-azure-blob)
    - [Where are Blobs Used?](#where-are-blobs-used)
  - [Blob APIs](#blob-apis)
  - [Types of Blobs](#types-of-blobs)
  - [Let's Quiz](#lets-quiz)

![alt text](azureblobs.jpg)

## Meet Mr. Azure Blob

Blobs are like files in the sky, and blob containers are like folders(in the sky). Blobs are flexible and can hold any file type, regardless of size, format, or location.

However, blob storage is not as fast as your local file system. It takes longer to access files, and they can't be indexed easily, which means you can't search the files as effectively. But blobs are used in MSSQL database for storing non-queryable data, like photos, alongside databases.

#### Where are Blobs Used?

- **Document Storage**: Just like your laptop's file system, blobs can be used to store documents.
- **Static Content**: Blobs can be used to store static images or other files to share over internet or for public access.
- **Virtual Hard Disks**: Azure Virtual Machines use blobs as their hard disks.

Blobs live inside a blob container. You can have unlimited blobs in a container and unlimited containers. Similar to your laptop's files, blobs have fields like name and attributes to make them easy to search. One more thing, blobs are flat. Meaning, no subfolders.

### Blob APIs

Blob storage has REST-based APIs that allow you to:
- Put (upload) blobs
- List blobs
- Copy blobs
- Delete blobs
- List containers

And much more..

### Types of Blobs

1. **Block Blob**: The standard type of blob.
2. **Append Blob**: You can only add (append) data to these blobs; you can't delete or update them.
3. **Page Blob**: Used for virtual machine hard disks, where data is stored in pages.

### Let's Quiz

1. **You have a long list of exes' info, well-organized in a list, and want to query it to find their whereabouts. True or false: Is blob storage a good choice to store this data?**

   - True
   - False

   **Answer**: False. Blobs are not suitable for structured data that needs to be queried frequently. They have higher latency than memory and local disks and lack the indexing features that make databases efficient for running queries.

2. **Blobs provide unstructured data storage. What does unstructured mean?**

   - Blobs can't be organized or named.
   - There are no restrictions on the type of data you can store in blobs.
   - Blobs can't contain structured data, like JSON or XML.

   **Answer**: There are no restrictions on the type of data you can store in blobs. Blobs do not impose any structure on your data, meaning your application can store any type of data in a blob.

3. **Which of the following describes a good strategy for creating storage accounts and blob containers for your application?**

   - Create both your Azure Storage accounts and containers before deploying your application.
   - Create Azure Storage accounts in your application as needed. Create the containers before deploying the application.
   - Create Azure Storage accounts before deploying your app. Create containers in your application as needed.

   **Answer**: Creating an Azure Storage account is an administrative activity and can be done before deploying an application. Container creation is lightweight and is often driven by run-time data, making it a good activity to do in your application.

4. **Which of the following can be used to initialize the Blob Storage client library within an application?**

   - An Azure username and password.
   - The Azure Storage account connection string.
   - A globally-unique identifier (GUID) that represents the application.
   - The Azure Storage account datacenter and location identifiers.

   **Answer**: A storage account connection string contains all the information needed to connect to Blob storage, most importantly the account name and the account key.

5. **What happens when you obtain a BlobClient reference from BlobContainerClient with the name of a blob?**

   - A new block blob is created in storage.
   - A BlobClient object is created locally. No network calls are made.
   - An exception is thrown if the blob does not exist in storage.
   - The contents of the named blob are downloaded.

   **Answer**: Getting a blob reference does not make any calls to Azure Storage. It simply creates an object locally that can work with a stored blob.