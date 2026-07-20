# The Small Files Performance Killer

!!! danger "Performance Impact"
    **10-50x slower execution** - Reading thousands of small files creates excessive task overhead.

## The Problem

When Spark reads many small files, it creates one task per file. This leads to massive scheduling overhead where executors spend more time coordinating than processing data.

```python title="❌ Problematic Code"
# BAD: Reading 10,000 small JSON files
df = spark.read.json("s3://bucket/small-files/*.json")
# Creates 10,000 tasks with massive overhead
result = df.filter(col("date") > "2023-01-01").collect()
```

## Why This Happens

=== "Task Overhead"
    - Each file becomes a separate task
    - Task scheduling overhead dominates processing
    - Network latency multiplied by file count

=== "Resource Waste"
    - Executors underutilized
    - More coordination than computation
    - Poor cluster efficiency

## Solutions

=== "Quick Fix"
    ```python title="✅ Coalesce After Reading"
    # Combine small files into larger partitions
    df = spark.read.json("s3://bucket/small-files/*.json").coalesce(100)
    ```

=== "Better Approach"
    ```python title="✅ Whole Text Files"
    # For very small files, use wholeTextFiles
    rdd = spark.sparkContext.wholeTextFiles("s3://bucket/small-files/*.json")
    df = spark.read.json(rdd.values())
    ```

=== "Best Practice"
    ```python title="✅ File Optimization Utility"
    def optimize_small_files(input_path, output_path, target_size_mb=128):
        """Combine small files into optimally-sized partitions"""
        df = spark.read.json(input_path)
        
        # Calculate optimal partitions
        total_size_mb = estimate_dataframe_size_mb(df)
        optimal_partitions = max(1, total_size_mb // target_size_mb)
        
        df.coalesce(optimal_partitions) \
          .write \
          .mode("overwrite") \
          .parquet(output_path)
        
        print(f"Optimized: {optimal_partitions} partitions, ~{target_size_mb}MB each")
    
    # Usage
    optimize_small_files("s3://bucket/small-files/", "s3://bucket/optimized/")
    ```

## Key Takeaways

!!! tip "Performance Rules"
    - **Target:** 100-200MB per partition
    - **Method:** Use `.coalesce()` after reading
    - **Alternative:** `wholeTextFiles()` for very small files
    - **Prevention:** Optimize during ingestion

## Measuring Impact

```python title="Performance Comparison"
# Before: 10,000 tasks, 45 minutes
# After:  100 tasks, 3 minutes  
# Improvement: 15x faster ⚡
```

The small files problem is one of the most common performance killers in Spark. A simple coalesce operation can provide dramatic speedups with minimal code changes.