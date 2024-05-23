---
layout: default
title: Pyspark|SparkSQL CheatSheet
parent: MicrosoftFabric
nav_order: 2
---

- [Describe Formatted *TableName* ](#describe-formatted-tablename-)
- [DataFrame from csv](#dataframe-from-csv)
- [Write Delta Table](#write-delta-table)

### <span style="color: DeepSkyBlue; font-family: Segoe UI, sans-serif;">Describe Formatted *TableName* </span>

![alt text](describeformattedtablename.png)

### <span style="color: Coral; font-family: Segoe UI, sans-serif;">DataFrame from csv</span>

![alt text](SPARK.READ.FORMAT.png)

### Write Delta Table
![\alt text](images\SaveAstable.png)

# SQL

CREATE OR REPLACE VIEW <VIEWNAME> doesn't work in Fabric/AzureSynapse/ADF etc. Instead use this:
```SQL
If Exists (Select * From sys.sysobjects where name = 'apple')
    DROP TABLE dbo.apple;
GO
```
![alt text](images/Drop_If_Exists_Full.png)



![alt text](df.show.png)

![alt text](df.describe.png)

