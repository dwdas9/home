## Blob storage introduction

Blobs are files in the sky blob containers are folders. Blobs are democractic and secular. The hold any file type, regardless of size, format and location.

But the god old blob is not even as fast as your local file system. They take longer time to answer. They can't be indexed(that means, files stored in them can't be queried well). But, they are used alongside databses to store non-queryable  data, like a photo.

Where are blobs used?

Well, first just like your laptops filesytem - to store documents.
Sometimes, static images, some source files etc for general public is stored in blob.
And, it is used as hard disk as well. Azure VMS use blobs  for hard-disk!

Blob  lives inside a blob container. Unlimited blobs can live in a container and you can have unlimited number  of contaners. Like your files in your laptop, blobs also have fields, like name, attributes etc to seach them easily.

## Blob APIs

Blob has Rest-based APIs they can do work like Put blob, List blob, Copy  Blob,  Delete blob, List containers and so on

## Blob Types

Block blob: The regular blob
Append  blob: They only lets you append, not delete/update.
Page blob: I mentioned, Virtual machine hard  disks are blobs. The virtual machine stores data in the blob hard disk as page blobs.


## Let's quiz

1. You want to store information about your girlfiriend and later query the list to find out which girlfriend lived where. True or false: blob storage is a good choice for this data? 

True
False

Answer: False. Blobs are not appropriate for structured data that needs to be queried frequently. They have higher latency than memory and local disk and don't have the indexing features that make databases efficient at running queries.

2. Blobs provide unstructured data storage. What does unstructured mean? 

Blobs can't be organized or named.
There are no restrictions on the type of data you can store in blobs.
Blobs can't contain structured data, like JSON or XML.

Answer: Blobs do not impose any structure on your data, meaning your application can store any type of data in a blob.

3. Which of the following describes a good strategy for creating storage accounts and blob containers for your application? 

Create both your Azure Storage accounts and containers before deploying your application.
Create Azure Storage accounts in your application as needed. Create the containers before deploying the application.
Create Azure Storage accounts before deploying your app. Create containers in your application as needed.

Answer: Creating an Azure Storage account is an administrative activity and can be done prior to deploying an application. Container creation is lightweight and is often driven by run-time data which makes it a good activity to do in your application.

4. Which of the following can be used to initialize the Blob Storage client library within an application? 

An Azure username and password.
The Azure Storage account connection string.
A globally-unique identifier (GUID) that represents the application.
The Azure Storage account datacenter and location identifiers.

Answer: A storage account connection string contains all the information needed to connect to Blob storage, most importantly the account name and the account key.

5. What happens when you obtain a BlobClient reference from BlobContainerClient with the name of a blob? 

A new block blob is created in storage.
A BlobClient object is created locally. No network calls are made.
An exception is thrown if the blob does not exist in storage.
The contents of the named blob are downloaded.

Answer: Getting a blob reference does not make any calls to Azure Storage, it simply creates an object locally that can work with a stored blob.