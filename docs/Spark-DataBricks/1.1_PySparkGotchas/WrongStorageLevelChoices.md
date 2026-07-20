# Wrong Storage Level Choices

!!! danger "Performance Impact"
    **Cache eviction, memory pressure** - Using inappropriate storage levels causes cache thrashing.

## The Problem

Using the default MEMORY_ONLY storage level when data doesn't fit in memory leads to constant cache eviction and poor performance. Different use cases need different storage strategies.

```python title="❌ Problematic Code"
# BAD: Default MEMORY_ONLY when data doesn't fit
large_df.cache()  # Uses MEMORY_ONLY, causes eviction cascades
```

## Storage Level Comparison

| Storage Level | Memory | Disk | Serialized | Replicated | Best For |
|---------------|--------|------|------------|------------|----------|
| MEMORY_ONLY | ✅ | ❌ | ❌ | ❌ | Small datasets, fast access |
| MEMORY_AND_DISK | ✅ | ✅ | ❌ | ❌ | Medium datasets |
| MEMORY_ONLY_SER | ✅ | ❌ | ✅ | ❌ | Memory-constrained |
| MEMORY_AND_DISK_SER | ✅ | ✅ | ✅ | ❌ | Large datasets |
| DISK_ONLY | ❌ | ✅ | ✅ | ❌ | Rarely accessed |

## Solutions

=== "Choose Appropriate Storage"
    ```python title="✅ Match Storage to Use Case"
    from pyspark import StorageLevel
    
    # For large datasets that might not fit in memory
    large_df.persist(StorageLevel.MEMORY_AND_DISK_SER)
    
    # For critical data that needs high availability
    critical_df.persist(StorageLevel.MEMORY_ONLY_2)  # Replicated
    
    # For infrequently accessed but expensive to compute
    archive_df.persist(StorageLevel.DISK_ONLY)
    
    # For iterative algorithms with memory constraints
    ml_features.persist(StorageLevel.MEMORY_AND_DISK_SER_2)
    ```

=== "Intelligent Storage Selection"
    ```python title="✅ Auto-Select Storage Level"
    def select_optimal_storage_level(df, access_pattern="frequent", memory_available_gb=8):
        """Select optimal storage level based on usage pattern"""
        
        # Estimate DataFrame size
        sample_count = df.sample(0.01).count()
        if sample_count == 0:
            return StorageLevel.MEMORY_ONLY
        
        total_count = df.count()
        estimated_size_gb = (total_count / sample_count) * 0.1  # Rough estimate
        
        # Storage level decision matrix
        if access_pattern == "frequent":
            if estimated_size_gb < memory_available_gb * 0.3:
                return StorageLevel.MEMORY_ONLY
            elif estimated_size_gb < memory_available_gb * 0.6:
                return StorageLevel.MEMORY_ONLY_SER
            else:
                return StorageLevel.MEMORY_AND_DISK_SER
                
        elif access_pattern == "occasional":
            if estimated_size_gb < memory_available_gb * 0.2:
                return StorageLevel.MEMORY_ONLY
            else:
                return StorageLevel.MEMORY_AND_DISK_SER
                
        elif access_pattern == "rare":
            return StorageLevel.DISK_ONLY
            
        elif access_pattern == "critical":
            if estimated_size_gb < memory_available_gb * 0.4:
                return StorageLevel.MEMORY_ONLY_2  # Replicated
            else:
                return StorageLevel.MEMORY_AND_DISK_SER_2
        
        return StorageLevel.MEMORY_AND_DISK_SER  # Safe default
    
    # Usage
    storage_level = select_optimal_storage_level(
        df=expensive_computation,
        access_pattern="frequent", 
        memory_available_gb=16
    )
    
    expensive_computation.persist(storage_level)
    print(f"Using storage level: {storage_level}")
    ```

=== "Storage Performance Testing"
    ```python title="✅ Test Storage Performance"
    def compare_storage_performance(df, test_operations=3):
        """Compare performance across different storage levels"""
        
        import time
        
        storage_levels = {
            "MEMORY_ONLY": StorageLevel.MEMORY_ONLY,
            "MEMORY_ONLY_SER": StorageLevel.MEMORY_ONLY_SER,
            "MEMORY_AND_DISK": StorageLevel.MEMORY_AND_DISK,
            "MEMORY_AND_DISK_SER": StorageLevel.MEMORY_AND_DISK_SER
        }
        
        results = {}
        test_df = df.limit(10000)  # Use smaller dataset for testing
        
        for name, level in storage_levels.items():
            print(f"Testing {name}...")
            
            # Cache with this storage level
            test_df.persist(level)
            
            # Trigger cache population
            start_time = time.time()
            cache_count = test_df.count()
            cache_time = time.time() - start_time
            
            # Test access performance
            access_times = []
            for i in range(test_operations):
                start_time = time.time()
                test_df.filter(col("amount") > 100).count()
                access_times.append(time.time() - start_time)
            
            avg_access_time = sum(access_times) / len(access_times)
            
            results[name] = {
                "cache_time": cache_time,
                "avg_access_time": avg_access_time,
                "total_time": cache_time + avg_access_time * test_operations
            }
            
            # Clean up
            test_df.unpersist()
            
            print(f"  Cache time: {cache_time:.2f}s")
            print(f"  Avg access: {avg_access_time:.2f}s")
        
        # Report best option
        best_option = min(results.keys(), key=lambda x: results[x]["total_time"])
        print(f"\n✅ Best performing: {best_option}")
        
        return results
    
    # Usage
    performance_results = compare_storage_performance(df)
    ```

=== "Dynamic Storage Adjustment"
    ```python title="✅ Adaptive Storage Management"
    class AdaptiveStorageManager:
        """Dynamically adjust storage levels based on memory pressure"""
        
        def __init__(self, spark_session):
            self.spark = spark_session
            self.cached_dataframes = {}
        
        def cache_with_monitoring(self, df, name, initial_level=StorageLevel.MEMORY_AND_DISK_SER):
            """Cache DataFrame with monitoring and potential adjustment"""
            
            df.persist(initial_level)
            df.count()  # Trigger cache
            
            self.cached_dataframes[name] = {
                'dataframe': df,
                'storage_level': initial_level,
                'access_count': 0
            }
            
            # Check memory pressure after caching
            if self._is_memory_pressure():
                print(f"Memory pressure detected, adjusting {name}")
                self._adjust_storage_levels()
        
        def access_dataframe(self, name):
            """Access cached DataFrame and track usage"""
            if name in self.cached_dataframes:
                self.cached_dataframes[name]['access_count'] += 1
                return self.cached_dataframes[name]['dataframe']
            return None
        
        def _is_memory_pressure(self):
            """Check if cluster is under memory pressure"""
            executors = self.spark.sparkContext.statusTracker().getExecutorInfos()
            
            for executor in executors:
                memory_usage = executor.memoryUsed / executor.maxMemory
                if memory_usage > 0.8:  # 80% threshold
                    return True
            return False
        
        def _adjust_storage_levels(self):
            """Adjust storage levels based on access patterns"""
            
            for name, info in self.cached_dataframes.items():
                df = info['dataframe']
                access_count = info['access_count']
                current_level = info['storage_level']
                
                # Frequently accessed: keep in memory
                if access_count > 5:
                    continue
                
                # Rarely accessed: move to disk
                elif access_count < 2:
                    df.unpersist()
                    df.persist(StorageLevel.DISK_ONLY)
                    info['storage_level'] = StorageLevel.DISK_ONLY
                    print(f"Moved {name} to DISK_ONLY")
        
        def cleanup_all(self):
            """Clean up all cached DataFrames"""
            for name, info in self.cached_dataframes.items():
                info['dataframe'].unpersist()
            self.cached_dataframes.clear()
    
    # Usage
    storage_manager = AdaptiveStorageManager(spark)
    storage_manager.cache_with_monitoring(expensive_df, "aggregated_data")
    
    # Access DataFrame
    result = storage_manager.access_dataframe("aggregated_data")
    ```

## Key Takeaways

!!! tip "Storage Level Guidelines"
    - **Data size vs available memory** determines primary choice
    - **Access frequency** - frequent access favors memory
    - **Fault tolerance needs** - critical data should be replicated
    - **Cost sensitivity** - disk is cheaper than memory

## Measuring Impact

```python title="Storage Optimization Results"
# MEMORY_ONLY (large dataset): Constant eviction, 5x slower
# MEMORY_AND_DISK_SER: Stable performance, 2x compression
# Improvement: Consistent performance, better resource utilization
```

The right storage level prevents cache thrashing and ensures predictable performance. Choose based on data characteristics and access patterns, not defaults.