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


### Dropping a table

![alt text](droptable.png)

### DataFrame Operations
1. **Creating a DataFrame**
   ```python
   from pyspark.sql import SparkSession
   spark = SparkSession.builder.appName("xxx").getOrCreate()
   df = spark.read.csv("abc.csv", header=True, inferSchema=True)
   ```

2. **Show Data**
   ```python
   df.show()
   df.show(n=10, truncate=False)
   ```

3. **Schema and Columns**
   ```python
   df.printSchema()
   df.columns
   ```

4. **Selecting Columns**
   ```python
   df.select("column1", "column2").show()
   ```

5. **Filtering Data**
   ```python
   df.filter(df["column"] > value).show()
   df.filter(df["column"] == "value").show()
   ```

6. **Adding Columns**
   ```python
   df.withColumn("new_column", df["existing_column"] * 2).show()
   ```

7. **Renaming Columns**
   ```python
   df.withColumnRenamed("old_name", "new_name")
   ```

8. **Dropping Columns**
   ```python
   df.drop("column_name")
   ```

9. **Grouping and Aggregating**
   ```python
   df.groupBy("column").count().show()
   df.groupBy("column").agg({"column2": "avg", "column3": "sum"}).show()
   ```

10. **Sorting Data**
    ```python
    df.orderBy("column").show()
    df.orderBy(df["column"].desc()).show()
    ```

### RDD Operations
1. **Creating an RDD**
   ```python
   rdd = spark.sparkContext.parallelize([1, 2, 3, 4, 5])
   ```

2. **Transformations**
   ```python
   rdd2 = rdd.map(lambda x: x * 2)
   rdd3 = rdd.filter(lambda x: x % 2 == 0)
   ```

3. **Actions**
   ```python
   rdd.collect()
   rdd.count()
   rdd.first()
   rdd.take(3)
   ```

### SQL Operations
1. **Creating Temp View**
   ```python
   df.createOrReplaceTempView("table_name")
   ```

2. **Running SQL Queries**
   ```python
   spark.sql("SELECT * FROM table_name").show()
   ```

### Saving Data
1. **Saving as CSV**
   ```python
   df.write.csv("path/to/save.csv")
   ```

2. **Saving as Parquet**
   ```python
   df.write.parquet("path/to/save.parquet")
   ```

3. **Saving to Hive**
   ```python
   df.write.saveAsTable("table_name")
   ```

### Miscellaneous
1. **Caching and Unpersisting DataFrames**
   ```python
   df.cache()
   df.unpersist()
   ```

2. **Explain Plan**
   ```python
   df.explain()
   ```

3. **Repartitioning Data**
   ```python
   df.repartition(10)
   df.coalesce(5)
   ```