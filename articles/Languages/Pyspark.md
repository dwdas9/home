---
layout: default
title: Pyspark
parent: Languages
nav_order: 1
---
- [Get all session information](#get-all-session-information)
- [Decoding Spark Installs: PySpark \& Spark on Windows](#decoding-spark-installs-pyspark--spark-on-windows)
  - [Introduction](#introduction)
  - [Standalone Python vs. Anaconda Python](#standalone-python-vs-anaconda-python)
    - [Standalone Python](#standalone-python)
    - [Anaconda Python](#anaconda-python)
  - [PySpark via pip vs. Full Apache Spark Installation](#pyspark-via-pip-vs-full-apache-spark-installation)
    - [PySpark via pip](#pyspark-via-pip)
    - [Full Apache Spark Installation](#full-apache-spark-installation)
    - [Conclusion](#conclusion)
- [Frequently asked Pyspark questions](#frequently-asked-pyspark-questions)

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
