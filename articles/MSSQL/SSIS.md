# [SQL Server Integration Services](https://learn.microsoft.com/en-us/sql/integration-services/sql-server-integration-services?view=sql-server-ver16)

To put simply SSIS is the ETL tool for MSSQL Server. Before Azure Data Factory this was the ETL tool for Microosft ecosystem.

Common activity with this tool is extracting data from XML, Csvs, .txt files and load into MSSQL Server.

# How to install SSIS

SSIS is installed as an option during MSSQL installation. There is no separate installation of this. 

![](images/custom-image-2024-08-03-01-06-35.png)

![](images/custom-image-2024-08-03-01-28-00.png)

# Project 1

Overview:

Load  data into MSSQL table from flat file
Rename the file with current datetime
Move file to processed folder
Zip the renamed file
Delete moved file

The setup:

## Create the required Database in MSSQL

```sql
-- Create the database
CREATE DATABASE EmployeeDataDB;
GO

-- Use the newly created database
USE EmployeeDataDB;
GO

-- Create the table
CREATE TABLE EmployeeDetails (
    id INT PRIMARY KEY,
    first_name NVARCHAR(50),
    last_name NVARCHAR(50),
    passport_number NVARCHAR(20),
    country NVARCHAR(50),
    date_of_birth DATE,
    profession NVARCHAR(100)
);
GO

-- Verify the table creation
SELECT * FROM EmployeeDetails;
GO
```