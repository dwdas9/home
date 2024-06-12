---
layout: default
title: APPROX_COUNT_DISTINCT
parent: SynapseAnalytics
nav_order: 1
---
- [APPROX\_COUNT\_DISTINCT when COUNT(DISTINCT ColName) runs forever](#approx_count_distinct-when-countdistinct-colname-runs-forever)
- [How to run it?](#how-to-run-it)
- [Some Fun facts about this T-SQL function](#some-fun-facts-about-this-t-sql-function)

![alt text](images\approxcntdistinct.png)

## <span style="color: BlueViolet">APPROX_COUNT_DISTINCT</span> when <span style="color: CornflowerBlue">COUNT(DISTINCT ColName)</span> runs forever

Imagine your table has 1 trillion rows. You want to count distinct customer names. Do you think `COUNT(DISTINCT CustomerName)` will show you results in your lifetime?

No, for such scenarios, use `APPROX_COUNT_DISTINCT(ColName)`. It will give you around 97% accuracy.

## <span style="color: DarkCyan">How to run it?</span>

Pretty simple and straightforward.

**Normal Count**
```sql
SELECT COUNT(DISTINCT CustomerName) FROM Customers;
```

**Approximate Count**

```sql 
SELECT APPROX_COUNT_DISTINCT(CustomerName) FROM Customers; 
```
## <span style="color: Gray">Some Fun facts about this T-SQL function</span>

In MS SQL Server `APPROX_COUNT_DISTINCT` it first came in **SQL Server 2019**. It is **available in Synapse SQL**. These other brands support this function:

1. **Google BigQuery**
2. **Amazon Redshift**: It offers the `APPROXIMATE COUNT(DISTINCT column)` function, which serves a similar purpose.
3. **PostgreSQL**: The `approx_count_distinct` extension is available through the `HLL (HyperLogLog)` extension, which allows for approximate distinct counting.
4. **Apache Spark**: The `approx_count_distinct` function is available in Spark SQL, which uses HyperLogLog for approximate counting.
