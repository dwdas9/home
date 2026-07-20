
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

## Analyse a dataframe

```python
# 1. Print the Schema
print("# 1. Schema of the DataFrame:")
df.printSchema()  # Displays the schema (column names, data types, nullability)

# 2. Show the First Few Rows
print("\n# 2. First 10 Rows of the DataFrame:")
df.show(10, truncate=False)  # Displays the first 10 rows without truncating columns

# 3. Describe the Data
print("\n# 3. Summary Statistics for Numeric Columns:")
df.describe().show()  # Provides summary statistics for numeric columns

# 4. Count the Number of Rows
row_count = df.count()  # Returns the total number of rows
print(f"\n# 4. Total Number of Rows: {row_count}")

# 5. Check for Null Values
from pyspark.sql.functions import isnull, when, count
print("\n# 5. Number of Null Values in Each Column:")
df.select([count(when(isnull(c), c)).alias(c) for c in df.columns]).show()  # Counts null values in each column

# 6. Get Column Names
columns = df.columns  # Returns a list of column names
print(f"\n# 6. Column Names: {columns}")

# 7. Summary Statistics for All Columns
print("\n# 7. Summary Statistics for All Columns:")
df.summary().show()  # Provides summary statistics for all columns

# 8. Distinct Values in a Column
print("\n# 8. Distinct Values in the 'Invoice' Column:")
df.select("Invoice").distinct().show()  # Shows all distinct values in the "Invoice" column

# 9. Data Types of Columns
print("\n# 9. Data Types of Each Column:")
print(df.dtypes)  # Returns a list of tuples with each column’s name and data type

# 10. Display Summary Statistics for Specific Columns
print("\n# 10. Summary Statistics for 'Quantity' and 'Price' Columns:")
df.describe("Quantity", "Price").show()  # Summary stats for "Quantity" and "Price" columns

# 11. Group and Aggregate Data
print("\n# 11. Group and Count by 'Country':")
df.groupBy("Country").count().show()  # Groups data by "Country" and counts occurrences

# 12. Sample Data
print("\n# 12. Random 10% Sample of the DataFrame:")
df.sample(0.1).show()  # Returns a 10% random sample of the DataFrame

# 13. Check DataFrame Size
row_count = df.count()
column_count = len(df.columns)
print(f"\n# 13. Number of Rows: {row_count}, Number of Columns: {column_count}")

# 14. Drop Duplicates
print("\n# 14. DataFrame After Dropping Duplicates Based on 'InvoiceNo':")
df.dropDuplicates(["InvoiceNo"]).show()  # Removes duplicate rows based on "InvoiceNo"

# 15. Check DataFrame Memory Usage
memory_usage = df.rdd.map(lambda row: len(str(row))).reduce(lambda a, b: a + b)
print(f"\n# 15. Estimated Memory Usage: {memory_usage} bytes")

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
| Add Column with SQL Expression| Add a column using SQL expression        | `storesDF.withColumn("newColumn", expr("existingColumn + 1"))`                                                                                                                 