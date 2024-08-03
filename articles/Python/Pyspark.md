---
layout: default
title: PySpark
parent: Python Ecosystem
nav_order: 1
has_children: true
---

- [Get all session information](#get-all-session-information)
- [Common df operations - Part 1](#common-df-operations---part-1)
- [Common df operations - Part 2](#common-df-operations---part-2)
  - [`withColumn` and `withColumnRenamed` in PySpark](#withcolumn-and-withcolumnrenamed-in-pyspark)

# Get all session information

```python

import os
import sys
from pyspark.sql import SparkSession

# Initialize a Spark session
spark = SparkSession.builder.appName("ExampleApp").getOrCreate()

# Print Spark information in a presentable format
print(f"Spark version: {spark.version}")
print(f"Application name: {spark.sparkContext.appName}")
print(f"Master URL: {spark.sparkContext.master}")
print(f"Application ID: {spark.sparkContext.applicationId}")
print(f"Number of executors: {len(spark.sparkContext._jsc.sc().statusTracker().getExecutorInfos())}")
print(f"Cores per executor: {spark.sparkContext.defaultParallelism}")

# Try to get the memory per executor configuration
try:
    executor_memory = spark.conf.get("spark.executor.memory")
    print(f"Memory per executor: {executor_memory}")
except Exception as e:
    print("Memory per executor: Configuration not found.")

# Print all configuration properties in a formatted way
print("\nAll configuration properties:")
for conf_key, conf_value in spark.sparkContext.getConf().getAll():
    print(f"  {conf_key}: {conf_value}")

# Print active jobs and stages using correct methods
print(f"\nActive jobs: {spark.sparkContext.statusTracker().getActiveJobIds()}")
print(f"Active stages: {spark.sparkContext.statusTracker().getActiveStageIds()}")

# Print additional environment information
print(f"\nSpark home: {os.getenv('SPARK_HOME')}")
print(f"Java home: {os.getenv('JAVA_HOME')}")
print(f"Python version: {sys.version}")
print(f"Python executable: {sys.executable}")
print(f"Current working directory: {os.getcwd()}")
print(f"User home directory: {os.path.expanduser('~')}")
print(f"System PATH: {os.getenv('PATH')}")

```

# Common df operations - Part 1

| **Operation**                | **Description**                                                                                  | **Example**                                                                                   |
|------------------------------|--------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------|
| **select()**                 | Selects a subset of columns.                                                                     | `df.select("col1", "col2")`                                                                   |
| **filter()**                 | Filters rows based on a condition.                                                               | `df.filter(df["col"] > 10)`                                                                   |
| **withColumn()**             | Adds or replaces a column.                                                                       | `df.withColumn("new_col", df["col"] * 2)`                                                     |
| **drop()**                   | Drops one or more columns.                                                                       | `df.drop("col1", "col2")`                                                                     |
| **groupBy()**                | Groups rows by specified columns.                                                                | `df.groupBy("col").count()`                                                                   |
| **agg()**                    | Aggregates data based on a specified column or expression.                                       | `df.groupBy("col").agg({"col2": "sum"})`                                                      |
| **orderBy()**                | Sorts the DataFrame by specified columns.                                                        | `df.orderBy("col")`                                                                           |
| **join()**                   | Joins two DataFrames.                                                                            | `df1.join(df2, df1["col1"] == df2["col2"], "inner")`                                          |
| **union()**                  | Unions two DataFrames.                                                                           | `df1.union(df2)`                                                                              |
| **distinct()**               | Removes duplicate rows.                                                                          | `df.distinct()`                                                                               |
| **dropDuplicates()**         | Drops duplicate rows based on specified columns.                                                 | `df.dropDuplicates(["col1", "col2"])`                                                         |
| **sample()**                 | Returns a random sample of the DataFrame.                                                        | `df.sample(0.1)`                                                                              |
| **count()**                  | Returns the number of rows in the DataFrame.                                                     | `df.count()`                                                                                  |
| **show()**                   | Displays the first n rows of the DataFrame.                                                      | `df.show(5)`                                                                                  |
| **collect()**                | Returns all the rows as a list of Row objects.                                                   | `df.collect()`                                                                                |
| **repartition()**            | Repartitions the DataFrame into the specified number of partitions.                              | `df.repartition(10)`                                                                          |
| **coalesce()**               | Reduces the number of partitions in the DataFrame.                                               | `df.coalesce(1)`                                                                              |
| **cache()**                  | Caches the DataFrame in memory.                                                                  | `df.cache()`                                                                                  |
| **persist()**                | Persists the DataFrame with the specified storage level.                                         | `df.persist(StorageLevel.DISK_ONLY)`                                                          |
| **createOrReplaceTempView()**| Creates or replaces a temporary view with the DataFrame.                                         | `df.createOrReplaceTempView("temp_view")`                                                     |
| **write**                    | Writes the DataFrame to a specified format (e.g., Parquet, CSV).                                 | `df.write.format("parquet").save("path/to/save")`                                             |
| **printSchema()**            | Prints the schema of the DataFrame.                                                              | `df.printSchema()`                                                                            |
| **dtypes**                   | Returns a list of tuples with column names and data types.                                       | `df.dtypes`                                                                                   |
| **schema**                   | Returns the schema of the DataFrame as a `StructType`.                                           | `df.schema`                                                                                   |
| **describe()**               | Computes basic statistics for numeric and string columns.                                        | `df.describe().show()`                                                                        |
| **explain()**                | Prints the physical plan to execute the DataFrame query.                                         | `df.explain()`                                                                                |
| **head()**                   | Returns the first n rows as a list of Row objects.                                               | `df.head(5)`                                                                                  |
| **first()**                  | Returns the first row as a Row object.                                                           | `df.first()`                                                                                  |
| **withColumnRenamed()**      | Renames an existing column.                                                                      | `df.withColumnRenamed("old_name", "new_name")`                                                |
| **cast()**                   | Converts the data type of a DataFrame column.                                                    | `df.withColumn("age", col("age").cast("integer"))`                                            |
| **alias()**                  | Assigns an alias to a DataFrame column or DataFrame.                                             | `df.select(col("col1").alias("new_col1"))`                                                    |

# Common df operations - Part 2

| **Operation**                | **Description**                                                                                  | **Example**                                                                                   |
|------------------------------|--------------------------------------------------------------------------------------------------|-----------------------------------------------------------------------------------------------|
| **select()**                 | Selects a subset of columns.                                                                     | `df.select("col1", "col2")`                                                                   |
| **filter()**                 | Filters rows based on a condition.                                                               | `df.filter(df["col"] > 10)`                                                                   |
| **withColumn()**             | Adds or replaces a column.                                                                       | `df.withColumn("new_col", df["col"] * 2)`                                                     |
| **drop()**                   | Drops one or more columns.                                                                       | `df.drop("col1", "col2")`                                                                     |
| **groupBy()**                | Groups rows by specified columns.                                                                | `df.groupBy("col").count()`                                                                   |
| **agg()**                    | Aggregates data based on a specified column or expression.                                       | `df.groupBy("col").agg({"col2": "sum"})`                                                      |
| **orderBy()**                | Sorts the DataFrame by specified columns.                                                        | `df.orderBy("col")`                                                                           |
| **join()**                   | Joins two DataFrames.                                                                            | `df1.join(df2, df1["col1"] == df2["col2"], "inner")`                                          |
| **union()**                  | Unions two DataFrames.                                                                           | `df1.union(df2)`                                                                              |
| **distinct()**               | Removes duplicate rows.                                                                          | `df.distinct()`                                                                               |
| **dropDuplicates()**         | Drops duplicate rows based on specified columns.                                                 | `df.dropDuplicates(["col1", "col2"])`                                                         |
| **sample()**                 | Returns a random sample of the DataFrame.                                                        | `df.sample(0.1)`                                                                              |
| **count()**                  | Returns the number of rows in the DataFrame.                                                     | `df.count()`                                                                                  |
| **show()**                   | Displays the first n rows of the DataFrame.                                                      | `df.show(5)`                                                                                  |
| **collect()**                | Returns all the rows as a list of Row objects.                                                   | `df.collect()`                                                                                |
| **repartition()**            | Repartitions the DataFrame into the specified number of partitions.                              | `df.repartition(10)`                                                                          |
| **coalesce()**               | Reduces the number of partitions in the DataFrame.                                               | `df.coalesce(1)`                                                                              |
| **cache()**                  | Caches the DataFrame in memory.                                                                  | `df.cache()`                                                                                  |
| **persist()**                | Persists the DataFrame with the specified storage level.                                         | `df.persist(StorageLevel.DISK_ONLY)`                                                          |
| **createOrReplaceTempView()**| Creates or replaces a temporary view with the DataFrame.                                         | `df.createOrReplaceTempView("temp_view")`                                                     |
| **write**                    | Writes the DataFrame to a specified format (e.g., Parquet, CSV).                                 | `df.write.format("parquet").save("path/to/save")`                                             |
| **printSchema()**            | Prints the schema of the DataFrame.                                                              | `df.printSchema()`                                                                            |
| **dtypes**                   | Returns a list of tuples with column names and data types.                                       | `df.dtypes`                                                                                   |
| **schema**                   | Returns the schema of the DataFrame as a `StructType`.                                           | `df.schema`                                                                                   |
| **describe()**               | Computes basic statistics for numeric and string columns.                                        | `df.describe().show()`                                                                        |
| **explain()**                | Prints the physical plan to execute the DataFrame query.                                         | `df.explain()`                                                                                |
| **head()**                   | Returns the first n rows as a list of Row objects.                                               | `df.head(5)`                                                                                  |
| **first()**                  | Returns the first row as a Row object.                                                           | `df.first()`                                                                                  |
| **withColumnRenamed()**      | Renames an existing column.                                                                      | `df.withColumnRenamed("old_name", "new_name")`                                                |
| **cast()**                   | Converts the data type of a DataFrame column.                                                    | `df.withColumn("age", col("age").cast("integer"))`                                            |
| **alias()**                  | Assigns an alias to a DataFrame column or DataFrame.                                             | `df.select(col("col1").alias("new_col1"))`                                                    |

## `withColumn` and `withColumnRenamed` in PySpark

| Technique                     | Description                              | Example Code                                                                                                                                                                   |
|-------------------------------|------------------------------------------|-------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| Add New Column                | Add a new column with a constant value   | `storesDF.withColumn("constantColumn", lit(1))`                                                                                                                                |
| Rename Column                 | Rename an existing column                | `storesDF.withColumnRenamed("oldColumnName", "newColumnName")`                                                                                                                 |
| Modify Existing Column        | Modify an existing column                | `storesDF.withColumn("existingColumn", col("existingColumn") * 2)`                                                                                                             |
| Split Column into Multiple    | Split a column into multiple columns     | `storesDF.withColumn("part1", split(col("compositeColumn"), "_").getItem(0)).withColumn("part2", split(col("compositeColumn"), "_").getItem(1))`                               |
| Cast Column to New Type       | Cast a column to a new type              | `storesDF.withColumn("castedColumn", col("columnToCast").cast("Integer"))`                                                                                                     |
| Apply UDF                     | Apply a user-defined function (UDF)      | `storesDF.withColumn("newColumn", udfFunction(col("existingColumn")))`                                                                                                         |
| Conditional Column            | Add a column based on a condition        | `storesDF.withColumn("newColumn", when(col("conditionColumn") > 0, "Positive").otherwise("Negative"))`                                                                         |
| Add Column from Expression    | Add a column from an expression          | `storesDF.withColumn("expressionColumn", col("columnA") + col("columnB"))`                                                                                                     |
| Drop Column                   | Drop a column                            | `storesDF.drop("columnToDrop")`                                                                                                                                               |
| Add Column with SQL Expression| Add a column using SQL expression        | `storesDF.withColumn("newColumn", expr("existingColumn + 1"))`                                                                                                                 |


