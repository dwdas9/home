# High-Cardinality Partitioning Disaster

!!! danger "Performance Impact"
    **Creates millions of tiny files** - Partitioning by high-cardinality columns destroys performance.

## The Problem

Partitioning by columns with many unique values (like user_id, transaction_id) creates one partition per unique value, resulting in millions of tiny files that are expensive to list and read.

```python title="❌ Problematic Code"
# BAD: Partitioning by high-cardinality column
df.write.partitionBy("user_id").parquet("output/")
# Creates millions of tiny partitions (one per user)
```

## Small Files Problem Impact

=== "Metadata Overhead"
    - Slow file listing operations
    - Increased storage system load
    - Poor subsequent read performance

=== "Storage Costs"
    - Minimum block sizes waste space
    - More inodes consumed
    - Backup and replication overhead

=== "Query Performance"
    - Task per file overhead
    - Poor parallelism
    - Inefficient resource usage

## Solutions

=== "Smart Partitioning Strategy"
    ```python title="✅ Low-Cardinality Partitioning"
    # GOOD: Partition by low-cardinality columns
    df.write.partitionBy("year", "month").parquet("output/")
    
    # For time-based partitioning
    from pyspark.sql.functions import date_format
    
    df_with_partition = df.withColumn(
        "year_month", 
        date_format(col("timestamp"), "yyyy-MM")
    )
    df_with_partition.write.partitionBy("year_month").parquet("output/")
    ```

=== "Hash-Based Partitioning"
    ```python title="✅ Bucketing High-Cardinality"
    # BETTER: Use hash-based partitioning for high-cardinality
    from pyspark.sql.functions import hash, col
    
    # Create buckets for high-cardinality column
    num_buckets = 100  # Adjust based on data size
    
    df_bucketed = df.withColumn(
        "user_bucket", 
        hash(col("user_id")) % num_buckets
    )
    
    df_bucketed.write.partitionBy("user_bucket").parquet("output/")
    ```

=== "Cardinality Analysis"
    ```python title="✅ Analyze Before Partitioning"
    def analyze_cardinality(df, columns, sample_fraction=0.1):
        """Analyze cardinality of potential partition columns"""
        
        print("=== Cardinality Analysis ===")
        sample_df = df.sample(sample_fraction)
        total_rows = df.count()
        sample_rows = sample_df.count()
        
        results = {}
        
        for column in columns:
            if column in df.columns:
                distinct_count = sample_df.select(column).distinct().count()
                
                # Estimate total distinct values
                estimated_distinct = distinct_count * (total_rows / sample_rows)
                
                results[column] = {
                    'estimated_distinct': int(estimated_distinct),
                    'cardinality_ratio': estimated_distinct / total_rows
                }
                
                # Partitioning recommendation
                if estimated_distinct < 100:
                    recommendation = "✅ Good for partitioning"
                elif estimated_distinct < 1000:
                    recommendation = "⚠️  Consider hash bucketing"
                else:
                    recommendation = "❌ Too high cardinality"
                
                print(f"{column}:")
                print(f"  Estimated distinct: {int(estimated_distinct):,}")
                print(f"  Cardinality ratio: {estimated_distinct/total_rows:.4f}")
                print(f"  Recommendation: {recommendation}")
                print()
        
        return results
    
    # Usage
    partition_analysis = analyze_cardinality(
        df, 
        columns=["user_id", "category", "date", "region"]
    )
    ```

=== "Hybrid Partitioning"
    ```python title="✅ Multi-Level Partitioning Strategy"
    def create_hybrid_partitioning(df, high_card_col, low_card_cols, bucket_count=50):
        """Combine low-cardinality and bucketed high-cardinality partitioning"""
        
        # Add hash bucket for high-cardinality column
        df_bucketed = df.withColumn(
            f"{high_card_col}_bucket",
            hash(col(high_card_col)) % bucket_count
        )
        
        # Combine with low-cardinality columns
        partition_cols = low_card_cols + [f"{high_card_col}_bucket"]
        
        print(f"Partitioning by: {partition_cols}")
        print(f"Expected partitions: ~{bucket_count * len(set(df.select(*low_card_cols).collect()))}")
        
        return df_bucketed, partition_cols
    
    # Usage
    df_final, partition_columns = create_hybrid_partitioning(
        df, 
        high_card_col="user_id", 
        low_card_cols=["year", "month"],
        bucket_count=100
    )
    
    df_final.write.partitionBy(*partition_columns).parquet("output/")
    ```

=== "Partition Validation"
    ```python title="✅ Validate Partition Strategy"
    def validate_partitioning_strategy(df, partition_cols, max_partitions=1000):
        """Validate that partitioning won't create too many partitions"""
        
        # Estimate partition count
        if isinstance(partition_cols, str):
            partition_cols = [partition_cols]
        
        # Sample to estimate combinations
        sample_df = df.sample(0.1)
        distinct_combinations = sample_df.select(*partition_cols).distinct().count()
        
        # Scale up estimate
        estimated_partitions = distinct_combinations * 10  # Conservative scaling
        
        print(f"Estimated partitions: {estimated_partitions}")
        print(f"Maximum recommended: {max_partitions}")
        
        if estimated_partitions > max_partitions:
            print("❌ Too many partitions predicted!")
            print("Recommendations:")
            print("  - Reduce cardinality with bucketing")
            print("  - Use fewer partition columns")
            print("  - Increase bucket sizes")
            return False
        else:
            print("✅ Partition count looks reasonable")
            return True
    
    # Validate before writing
    is_valid = validate_partitioning_strategy(df, ["year", "month", "user_bucket"])
    if is_valid:
        df.write.partitionBy("year", "month", "user_bucket").parquet("output/")
    ```

## Key Takeaways

!!! tip "Partitioning Guidelines"
    - **Ideal cardinality:** < 1000 distinct values per column
    - **Use hash bucketing** for high-cardinality columns
    - **Combine strategies** - low-cardinality + bucketed high-cardinality
    - **Always validate** estimated partition count before writing

## Measuring Impact

```python title="Partitioning Comparison"
# Bad: 1M user_id partitions → 1M tiny files
# Good: 12 month × 100 buckets → 1,200 reasonably-sized files
# Improvement: 99.9% fewer files, 10x faster reads
```

Thoughtful partitioning strategy is essential for maintainable data lakes. The upfront analysis prevents costly rework later.