---
layout: default
title: APPROX_COUNT_DISTINCT
parent: SynapseAnalytics
nav_order: 1
---

![alt text](count_distinct.png)

### APPROX_COUNT_DISTINCT - Lifesaver when the data is large. Too large

Imagine you have a huge database with 100 billion rows of customer names. Some names might be repeated. You want to find out how many unique customer names there are.

Your first thought might be to use the `COUNT()` function. But wait, 100 billion rows?! That will take forever!

This is where the `APPROX_COUNT_DISTINCT` function comes to the rescue. It gives you a result with about 97% accuracy and it's much faster. At least it will run within your lifetime!

So, next time you need to count unique values in a massive dataset, try using `APPROX_COUNT_DISTINCT`. It's quick and close enough to the real count for most purposes.

The `APPROX_COUNT_DISTINCT` function was introduced in **SQL Server 2019**. It is **available in Synapse SQL**. This function is also available in the following systems:

1. **Google BigQuery**
2. **Amazon Redshift**: It offers the `APPROXIMATE COUNT(DISTINCT column)` function, which serves a similar purpose.
3. **PostgreSQL**: The `approx_count_distinct` extension is available through the `HLL (HyperLogLog)` extension, which allows for approximate distinct counting.
4. **Apache Spark**: The `approx_count_distinct` function is available in Spark SQL, which uses HyperLogLog for approximate counting.
