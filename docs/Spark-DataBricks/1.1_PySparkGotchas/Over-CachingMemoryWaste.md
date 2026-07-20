# Over-Caching Memory Waste

!!! danger "Performance Impact"
    **Memory exhaustion, slower jobs** - Caching DataFrames used only once wastes precious executor memory.

## The Problem

Caching every DataFrame "just in case" consumes executor memory that could be used for actual computation. This leads to memory pressure, spilling, and degraded performance.

```python title="❌ Problematic Code"
# BAD: Cache everything approach
df1 = spark.read.parquet("data1.parquet").cache()  # Used once
df2 = spark.read.parquet("data2.parquet").cache()  # Used once  
df3 = spark.read.parquet("data3.parquet").cache()  # Used once

result = df1.join(df2, "key").join(df3, "key")  # Memory wasted!
```

## Over-Caching Consequences

=== "Memory Issues"
    - Executor memory exhaustion
    - Increased GC pressure
    - Spilling to disk (defeats cache purpose)

=== "Performance Impact"
    - Reduced performance for actually reused data
    - Slower job execution
    - Resource contention

## Solutions

=== "Strategic Caching"
    ```python title="✅ Cache Only Reused DataFrames"
    # GOOD: Cache only reused DataFrames
    expensive_df = df.groupBy("category").agg(
        count("*").alias("count"),
        avg("price").alias("avg_price"),
        sum("revenue").alias("total_revenue")
    )
    
    # This will be reused multiple times
    expensive_df.cache()
    
    # Multiple operations using cached data
    high_volume = expensive_df.filter(col("count") > 1000)
    low_volume = expensive_df.filter(col("count") < 100)
    mid_range = expensive_df.filter(
        (col("count") >= 100) & (col("count") <= 1000)
    )
    
    # Clean up when done
    expensive_df.unpersist()
    ```

=== "Smart Caching Decision"
    ```python title="✅ Intelligent Caching Logic"
    def should_cache(df, usage_count, computation_cost="medium"):
        """Decide whether to cache based on usage patterns"""
        
        cost_weights = {
            "low": 1,      # Simple transformations
            "medium": 3,   # Joins, groupBy
            "high": 10     # Complex aggregations, multiple joins
        }
        
        weight = cost_weights.get(computation_cost, 3)
        cache_benefit_score = usage_count * weight
        
        # Memory consideration
        partition_count = df.rdd.getNumPartitions()
        memory_concern = partition_count > 1000
        
        return {
            "should_cache": cache_benefit_score >= 6 and not memory_concern,
            "score": cache_benefit_score,
            "memory_concern": memory_concern
        }
    
    # Usage example
    expensive_computation = df.groupBy("category", "region").agg(
        countDistinct("user_id"),
        avg("amount")
    )
    
    cache_decision = should_cache(
        expensive_computation, 
        usage_count=3, 
        computation_cost="high"
    )
    
    if cache_decision["should_cache"]:
        expensive_computation.cache()
        print(f"✅ Caching (score: {cache_decision['score']})")
    else:
        print(f"❌ Not caching (score: {cache_decision['score']})")
    ```

=== "Cache Management"
    ```python title="✅ Automatic Cache Cleanup"
    from contextlib import contextmanager
    
    @contextmanager
    def managed_cache(df, storage_level=None):
        """Context manager for automatic cache cleanup"""
        if storage_level:
            df.persist(storage_level)
        else:
            df.cache()
        
        try:
            df.count()  # Trigger cache
            yield df
        finally:
            df.unpersist()
    
    # Usage - automatic cleanup
    expensive_df = df.groupBy("category").agg(count("*"))
    
    with managed_cache(expensive_df) as cached_df:
        result1 = cached_df.filter(col("count") > 100).collect()
        result2 = cached_df.filter(col("count") < 50).collect()
        # Automatic cleanup when exiting context
    ```

=== "Cache Monitoring"
    ```python title="✅ Monitor Cache Usage"
    def monitor_cache_usage():
        """Monitor current cache usage across cluster"""
        print("=== Cache Usage Report ===")
        
        storage_infos = spark.sparkContext._jsc.sc().getRDDStorageInfo()
        
        total_memory_used = 0
        total_disk_used = 0
        
        for storage_info in storage_infos:
            rdd_id = storage_info.id()
            memory_size_mb = storage_info.memSize() / (1024 * 1024)
            disk_size_mb = storage_info.diskSize() / (1024 * 1024)
            
            total_memory_used += memory_size_mb
            total_disk_used += disk_size_mb
            
            print(f"RDD {rdd_id}: {memory_size_mb:.1f}MB memory, {disk_size_mb:.1f}MB disk")
        
        print(f"Total: {total_memory_used:.1f}MB memory, {total_disk_used:.1f}MB disk")
        
        # Get executor memory info
        executors = spark.sparkContext.statusTracker().getExecutorInfos()
        total_executor_memory = sum(exec.maxMemory for exec in executors)
        cache_ratio = (total_memory_used * 1024 * 1024) / total_executor_memory
        
        print(f"Cache memory ratio: {cache_ratio:.1%}")
        
        if cache_ratio > 0.8:
            print("⚠️  High cache memory usage!")
    
    # Monitor periodically
    monitor_cache_usage()
    ```

## Key Takeaways

!!! tip "Caching Best Practices"
    - **Cache when:** DataFrame used 2+ times, expensive computation, memory available
    - **Don't cache:** One-time use, simple transformations, memory constrained
    - **Monitor usage** regularly to prevent memory issues
    - **Clean up** with `.unpersist()` when done

## Measuring Impact

```python title="Cache Optimization Results"
# Before: 5 cached DataFrames (3 unused) → 60% memory waste
# After:  2 strategically cached DataFrames → optimal memory usage
# Improvement: 3x better memory efficiency, faster execution
```

Strategic caching is about quality over quantity. Cache the right DataFrames at the right time, not everything "just in case".