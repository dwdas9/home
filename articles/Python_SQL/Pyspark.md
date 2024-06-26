---
layout: default
title: Pyspark
parent: PythonSQL
nav_order: 1
---

## Get all session information

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