---
layout: default
title: Pyspark
parent: Languages
nav_order: 1
---
- [Get all session information](#get-all-session-information)
- [Common df operations - Part1](#common-df-operations---part1)
- [Common df operations - Part2](#common-df-operations---part2)

# Get all session information

```python
print("Spark version:", spark.version)
print("Application name:", spark.sparkContext.appName)
print("Master URL:", spark.sparkContext.master)
print("Application ID:", spark.sparkContext.applicationId)
print("Number of executors:", len(spark.sparkContext._jsc.sc().statusTracker().getExecutorInfos()))
print("Cores per executor:", spark.sparkContext.defaultParallelism)
print("Memory per executor:", spark.conf.get("spark.executor.memory"))
print("All configuration properties:", spark.sparkContext.getConf().getAll())
print("Active jobs:", spark.sparkContext.statusTracker().getActiveJobIds())
print("Active stages:", spark.sparkContext.statusTracker().getActiveStageIds())
```
# Common df operations - Part1

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
# Common df operations - Part2

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
