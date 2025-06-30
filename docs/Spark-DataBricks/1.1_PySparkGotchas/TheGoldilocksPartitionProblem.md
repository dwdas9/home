# The Goldilocks Partition Problem

!!! danger "Performance Impact"
    **5-100x slower** - Partitions that are too small create overhead; too large cause memory issues.

## The Problem

Spark performance is highly sensitive to partition size. Too small creates scheduling overhead, too large causes memory pressure. Finding the "just right" size is critical.

```python title="❌ Problematic Code"
# BAD: Ignoring partition sizes
df = spark.read.parquet("data/")
print(f"Partitions: {df.rdd.getNumPartitions()}")  # Could be 1 or 10,000!
result = df.groupBy("category").count().collect()
```

## Partition Size Impact

=== "Too Small (< 10MB)"
    - High task scheduling overhead
    - Underutilized executors  
    - Inefficient network usage
    - More coordination than computation

=== "Too Large (> 1GB)"
    - Memory pressure and spilling
    - GC overhead
    - Risk of OOM errors
    - Poor parallelism

=== "Just Right (100-200MB)"
    - Optimal resource utilization
    - Balanced parallelism
    - Efficient processing
    - Good memory usage

## Solutions

=== "Partition Analysis"
    ```python title="✅ Analyze Current Partitions"
    def analyze_partitions(df, df_name="DataFrame"):
        """Comprehensive partition analysis"""
        print(f"=== {df_name} Partition Analysis ===")
        
        num_partitions = df.rdd.getNumPartitions()
        print(f"Number of partitions: {num_partitions}")
        
        # Sample partition sizes
        partition_counts = df.rdd.mapPartitions(lambda x: [sum(1 for _ in x)]).collect()
        
        if partition_counts:
            min_size = min(partition_counts)
            max_size = max(partition_counts)
            avg_size = sum(partition_counts) / len(partition_counts)
            
            print(f"Partition sizes:")
            print(f"  Min: {min_size:,} rows")
            print(f"  Max: {max_size:,} rows") 
            print(f"  Avg: {avg_size:,.0f} rows")
            
            # Skew detection
            skew_ratio = max_size / avg_size if avg_size > 0 else 0
            if skew_ratio > 3:
                print(f"⚠️  High skew: Max is {skew_ratio:.1f}x larger than average")
            
            # Size recommendations
            estimated_mb_per_partition = avg_size * 0.001  # Rough estimate
            print(f"Estimated avg size: ~{estimated_mb_per_partition:.1f} MB")
            
            if estimated_mb_per_partition < 50:
                print("💡 Consider reducing partitions (coalesce)")
            elif estimated_mb_per_partition > 300:
                print("💡 Consider increasing partitions (repartition)")
            else:
                print("✅ Partition sizes look good!")
        
        return df
    
    # Usage
    df = analyze_partitions(df, "Sales Data")
    ```

=== "Optimal Partitioning"
    ```python title="✅ Calculate Optimal Partitions"
    def optimize_partitions(df, target_partition_size_mb=128):
        """Calculate and apply optimal partitioning"""
        
        # Estimate total size
        sample_count = df.sample(0.01).count()
        if sample_count == 0:
            return df.coalesce(1)
            
        total_count = df.count()
        sample_data = df.sample(0.01).take(min(100, sample_count))
        
        if sample_data:
            # Estimate row size
            avg_row_size_bytes = sum(len(str(row)) for row in sample_data) / len(sample_data) * 2
            total_size_mb = (total_count * avg_row_size_bytes) / (1024 * 1024)
            
            optimal_partitions = max(1, int(total_size_mb / target_partition_size_mb))
            optimal_partitions = min(optimal_partitions, 4000)  # Cap at reasonable max
            
            print(f"Dataset size: {total_size_mb:.1f} MB")
            print(f"Target partition size: {target_partition_size_mb} MB")
            print(f"Optimal partitions: {optimal_partitions}")
            
            current_partitions = df.rdd.getNumPartitions()
            
            if optimal_partitions < current_partitions:
                print("Applying coalesce...")
                return df.coalesce(optimal_partitions)
            elif optimal_partitions > current_partitions * 1.5:
                print("Applying repartition...")
                return df.repartition(optimal_partitions)
            else:
                print("Current partitioning is acceptable")
                return df
        
        return df
    
    # Apply optimization
    df_optimized = optimize_partitions(df)
    ```

=== "Advanced Partitioning"
    ```python title="✅ Intelligent Partitioning Strategy"
    def intelligent_partition(df, operation_type="general"):
        """Apply partitioning strategy based on operation type"""
        
        current_partitions = df.rdd.getNumPartitions()
        
        # Estimate data characteristics
        sample_df = df.sample(0.01)
        estimated_rows = df.count()
        
        if operation_type == "join":
            # Joins benefit from more partitions for parallelism
            target_rows_per_partition = 50000
            optimal_partitions = max(200, estimated_rows // target_rows_per_partition)
            
        elif operation_type == "aggregation":
            # Aggregations need fewer, larger partitions to reduce shuffle
            target_rows_per_partition = 200000
            optimal_partitions = max(50, estimated_rows // target_rows_per_partition)
            
        elif operation_type == "io":
            # I/O operations benefit from larger partitions
            target_rows_per_partition = 500000
            optimal_partitions = max(20, estimated_rows // target_rows_per_partition)
            
        else:  # general
            target_rows_per_partition = 100000
            optimal_partitions = max(100, estimated_rows // target_rows_per_partition)
        
        optimal_partitions = min(optimal_partitions, 2000)  # Reasonable upper bound
        
        print(f"Operation: {operation_type}")
        print(f"Current partitions: {current_partitions}")
        print(f"Recommended partitions: {optimal_partitions}")
        
        if abs(optimal_partitions - current_partitions) / current_partitions > 0.3:
            if optimal_partitions < current_partitions:
                return df.coalesce(optimal_partitions)
            else:
                return df.repartition(optimal_partitions)
        
        return df
    
    # Usage for different operations
    df_for_joins = intelligent_partition(df, "join")
    df_for_agg = intelligent_partition(df, "aggregation")
    ```

## Key Takeaways

!!! tip "Partitioning Guidelines"
    - **Target size:** 100-200MB per partition
    - **Row count:** 50K-500K rows per partition
    - **Use coalesce** when reducing partitions (no shuffle)
    - **Use repartition** when increasing partitions (with shuffle)
    - **Monitor skew** - max should be < 3x average

## Measuring Impact

```python title="Optimization Results"
# Before: 10,000 partitions (1MB each) → 20x task overhead
# After:  100 partitions (100MB each) → optimal performance
# Improvement: 20x fewer tasks, 80% less overhead
```

Proper partitioning is the foundation of good Spark performance. It's worth spending time to get this right as it affects every subsequent operation.