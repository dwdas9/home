---
layout: default
title: JSON-DeltaLake-OPG
parent: MicrosoftFabric
nav_order: 7
---
- [Background](#background)
- [Let's start](#lets-start)
  - [Prepare the Local Files and On-Premises Gateway](#prepare-the-local-files-and-on-premises-gateway)
  - [Create a Delta Lake Table to Store the JSON Data](#create-a-delta-lake-table-to-store-the-json-data)
  - [Set Up the Copy Data Process](#set-up-the-copy-data-process)
  - [Run the Pipeline](#run-the-pipeline)
  - [Check the Delta Lake Table Data](#check-the-delta-lake-table-data)
- [Conclusion](#conclusion)


![\alt text](images\image-40.png)


## Background

Here, I'll show you two things:

1. How to connect Fabric or Azure Data Factory (ADF) to your local file system using an on-premises gateway.
2. How to use a simple, no-code method to automatically copy JSON files into a Delta Lake table.

## Let's start

### Prepare the Local Files and On-Premises Gateway

1. Download the sample JSON files from [here](SampleJsonFiles.zip) and place them in a local folder on your computer.
2. Install the on-premises gateway. It’s straightforward and easy to install. You can find detailed instructions [here](../PowerPlatform/OnPremiseGateway.md).

Note: Ensure that an admin account has all permissions in the security tab of the local folder. While not always practical, admin access simplifies the setup and reduces complications.

![\alt text](images\image-36.png)

### Create a Delta Lake Table to Store the JSON Data

Create a notebook and run the following SparkSQL code:

```python
%%sql

Create table jsonDelta (
  id string,
  name string,
  email string,
  age int,
  country string
) using delta
```

Remember: **using delta** at the end.

![\alt text](images\image-33.png)

### Set Up the Copy Data Process

- **Source Setup**: Follow the diagram to set up the source. Ensure the admin account has the right permissions for the source folder.

![\alt text](images\image-34.png)

- **Destination Setup**: Follow the diagram for the destination setup.

![\alt text](images\image-35.png)

- **Mapping Setup**: Follow the diagram to set up the mapping.

![\alt text](images\image-37.png)

### Run the Pipeline

Click "Run." The pipeline will process all the JSON files and add the data to the Delta Lake table. That’s it!

![\alt text](images\image-38.png)

### Check the Delta Lake Table Data

Go to the lakehouse, expand the table, and you will see that all the JSON data has been loaded into the Delta Lake table.

![\alt text](images\image-39.png)

## Conclusion

I hope I was able to show how nearly no-code, simple, and straightforward it is to load data from your local system into a Delta Lake in Fabric.
