---
layout: default
title: KQL
parent: MicrosoftFabric
nav_order: 5
---

- [What is KQL?](#what-is-kql)
  - [Running KQL query in Fabric](#running-kql-query-in-fabric)
  - [**Database - KQL vs SQL**](#database---kql-vs-sql)
  - [**Query - KQL Vs SQL**](#query---kql-vs-sql)
    - [**KQL vs SQL DQLs**](#kql-vs-sql-dqls)
    - [**KQL DDLs, DMLs \& DQLs**](#kql-ddls-dmls--dqls)


## What is KQL?

![alt text](images\KQLDB.webp)

A **KQL (Kusto Query Language) Database** handles large volumes of structured, semi-structured, and unstructured data for real-time analytics and ad-hoc querying. It is part of the Azure Data Explorer service. The data in a KQL database is **stored in Azure Data Explorer**. It uses a **columnar storage** format, for high-performance.

![alt text](images\KQLTough.png)

### Running KQL query in Fabric

![alt text](images\howtorunquery.png)

There is **no magic command** like %%KQL

### **Database - KQL vs SQL**

| Feature                     | KQL Database                                     | Standard SQL Database                           |
|-----------------------------|--------------------------------------------------|-------------------------------------------------|
| **Query Language**          | Kusto Query Language (KQL)                       | Structured Query Language (SQL)                 |
| **Storage Format**          | Columnar                                         | Row-based                                       |
| **Optimized For**           | Real-time analytics, log and time-series data    | Transactional data, relational data             |
| **Data Structure**          | Tables, columns, materialized views, functions   | Tables, columns, views, stored procedures       |
| **Scalability**             | Highly scalable and distributed                  | Varies by implementation (SQL Server, MySQL, etc.) |
| **Indexing**                | Automatically indexed for fast query performance | Manual and automatic indexing                   |
| **Data Ingestion**          | Supports batch and streaming ingestion           | Primarily batch ingestion                       |
| **Use Cases**               | Log analytics, telemetry data, IoT data          | OLTP, data warehousing, reporting               |
| **Storage Location**        | Azure Data Explorer service in the cloud         | Varies (on-premises, cloud-based)               |
| **Performance**             | Optimized for read-heavy and analytical workloads| Balanced for read and write operations          |
| **Schema**                  | Flexible schema with support for semi-structured data | Rigid schema with well-defined data types       |

### **Query - KQL Vs SQL**

![alt text](images\SQLVsKQLWithQuery.png)

#### **KQL vs SQL DQLs**

| **Operation**                   | **SQL**                                                                                               | **KQL**                                                                                                           |
|---------------------------------|-------------------------------------------------------------------------------------------------------|-------------------------------------------------------------------------------------------------------------------|
| **Select and Count**            | `SELECT Name, Age, COUNT(*) FROM Employees WHERE Age > 30 GROUP BY Name, Age;`                        | `Employees \| where Age > 30 \| summarize count() by Name, Age`                                                   |
| **Group By and Order By**       | `SELECT Department, AVG(Salary) AS AverageSalary FROM Employees GROUP BY Department ORDER BY AverageSalary DESC;` | `Employees \| summarize AverageSalary=avg(Salary) by Department \| sort by AverageSalary desc`                  |
| **Join**                        | `SELECT e.Name, d.DepartmentName FROM Employees e JOIN Departments d ON e.DepartmentID = d.ID;`       | `Employees \| join kind=inner (Departments) on $left.DepartmentID == $right.ID \| project Name, DepartmentName`   |
| **Subquery and Limit**          | `SELECT Name FROM (SELECT * FROM Employees WHERE Age > 30) AS SubQuery WHERE DepartmentID = 5 LIMIT 10;` | `let SubQuery = Employees \| where Age > 30; SubQuery \| where DepartmentID == 5 \| project Name \| take 10`     |
| **String Functions**            | `SELECT Name FROM Employees WHERE UPPER(FirstName) = 'JOHN';`                                         | `Employees \| where tolower(FirstName) == 'john' \| project Name`                                                 |
| **Date Functions**              | `SELECT Name FROM Employees WHERE YEAR(HireDate) = 2020;`                                             | `Employees \| where datetime_part('year', HireDate) == 2020 \| project Name`                                       |
| **Between**                     | `SELECT * FROM Employees WHERE Age BETWEEN 25 AND 35;`                                                | `Employees \| where Age between (25 .. 35)`                                                                       |
| **Date Range**                  | `SELECT * FROM Sales WHERE SaleDate BETWEEN '2021-01-01' AND '2021-12-31';`                           | `Sales \| where SaleDate between (datetime(2021-01-01) .. datetime(2021-12-31))`                                  |
| **Distinct**                    | `SELECT DISTINCT Department FROM Employees;`                                                          | `Employees \| summarize by Department`                                                                            |
| **Top N**                       | `SELECT TOP 5 Name, Salary FROM Employees ORDER BY Salary DESC;`                                      | `Employees \| top 5 by Salary desc \| project Name, Salary`                                                       |
| **Aggregation with Conditions** | `SELECT Department, COUNT(*) FROM Employees WHERE Age > 30 GROUP BY Department;`                      | `Employees \| where Age > 30 \| summarize count() by Department`                                                  |

#### **KQL DDLs, DMLs & DQLs**


| **Description**                                      | **Example**                                                                                                  | **Category** |
|------------------------------------------------------|--------------------------------------------------------------------------------------------------------------|--------------|
| **Tables**                                           |                                                                                                              |              |
| Create a new table                                   | `.create table MyTable (Column1: string, Column2: int)`                                                      | DDL          |
| Show the schema of a table                           | `.show table MyTable schema`                                                                                 | DQL          |
| Ingest data into a table                             | `.ingest into table MyTable <DataSource>`                                                                    | DML          |
| Rename a table                                       | `.rename table OldTableName to NewTableName`                                                                 | DDL          |
| Drop a table                                         | `.drop table TableName`                                                                                      | DDL          |
| List all tables                                      | `.show tables`                                                                                               | DQL          |
| **Columns**                                          |                                                                                                              |              |
| Add a column                                         | `.alter table TableName add column ColumnName: DataType`                                                     | DDL          |
| Drop a column                                        | `.alter table TableName drop column ColumnName`                                                              | DDL          |
| Rename a column                                      | `.rename column OldColumnName to NewColumnName in table TableName`                                           | DDL          |
| **Functions**                                        |                                                                                                              |              |
| Create a new function                                | `.create function with (docstring = "Description", folder = "FolderName") MyFunction () { <KQLQuery> }`       | DDL          |
| Show available functions                             | `.show functions`                                                                                            | DQL          |
| **Materialized Views**                               |                                                                                                              |              |
| Create a new materialized view                       | `.create materialized-view MyView on table MyTable { <KQLQuery> }`                                           | DDL          |
| Show available materialized views                    | `.show materialized-views`                                                                                   | DQL          |
| **Indexes**                                          |                                                                                                              |              |
| Create an index                                      | `.create index IndexName on TableName (ColumnName)`                                                          | DDL          |
| Drop an index                                        | `.drop index IndexName on TableName`                                                                         | DDL          |
| Show indexes                                         | `.show indexes`                                                                                              | DQL          |
| **Ingest**                                           |                                                                                                              |              |
| Ingest data into a table                             | `.ingest into table MyTable <DataSource>`                                                                    | DML          |
| Ingest data from JSON                                | `.ingest into table TableName h@"https://path/to/file.json"`                                                 | DML          |
| **Database Operations**                              |                                                                                                              |              |
| Create a database                                    | `.create database DatabaseName`                                                                              | DDL          |
| Drop a database                                      | `.drop database DatabaseName`                                                                                | DDL          |
| List all databases                                   | `.show databases`                                                                                            | DQL          |
| **Permissions**                                      |                                                                                                              |              |
| Grant table permissions                              | `.grant select on table TableName to UserName`                                                               | DDL          |
| Revoke table permissions                             | `.revoke select on table TableName from UserName`                                                            | DDL          |
| Show permissions                                     | `.show table TableName policy access`                                                                        | DQL          |
| **Views**                                            |                                                                                                              |              |
| Create a view                                        | `.create view ViewName as <KQLQuery>`                                                                        | DDL          |
| Drop a view                                          | `.drop view ViewName`                                                                                        | DDL          |
| Show views                                           | `.show views`                                                                                                | DQL          |
| **Diagnostics**                                      |                                                                                                              |              |
| Show cluster diagnostics                             | `.show cluster diagnostics`                                                                                  | DQL          |
| Show table statistics                                | `.show table TableName stats`                                                                                | DQL          |
| **Data Export**                                      |                                                                                                              |              |
| Export data to JSON                                  | `.export to json at <FilePath> <KQLQuery>`                                                                   | DML          |

