# Suboptimal File Format Choices

!!! danger "Performance Impact"
    **5-20x slower queries** - Using row-based formats for analytical workloads instead of columnar formats.

## The Problem

Using CSV or JSON for large analytical datasets forces Spark to read entire rows even when you only need specific columns, and provides no compression or optimization benefits.

```python title="❌ Problematic Code"
# BAD: Large analytical datasets in row-based formats
df = spark.read.csv("10TB_dataset.csv")
# No compression, no predicate pushdown, reads entire rows
result = df.select("revenue").filter(col("date") > "2023-01-01").sum()
```

## Format Comparison

| Format | Compression | Predicate Pushdown | Schema Evolution | ACID | Best For |
|--------|-------------|-------------------|------------------|------|----------|
| CSV | ❌ | ❌ | ❌ | ❌ | Small datasets, exports |
| JSON | ❌ | ❌ | ✅ | ❌ | Semi-structured data |
| Parquet | ✅ | ✅ | ✅ | ❌ | Analytics, data lakes |
| Delta | ✅ | ✅ | ✅ | ✅ | Production data lakes |

## Solutions

=== "Parquet for Analytics"
    ```python title="✅ Columnar Format"
    # GOOD: Columnar format with compression
    df = spark.read.parquet("10TB_dataset.parquet")
    
    # Benefits:
    # - 70-90% compression ratio
    # - Column pruning (only read needed columns)
    # - Predicate pushdown (filter at file level)
    # - Fast aggregations
    ```

=== "Delta for Production"
    ```python title="✅ ACID Transactions"
    # BETTER: Delta Lake for production
    df = spark.read.format("delta").load("delta-table/")
    
    # Additional benefits:
    # - Time travel (access historical versions)
    # - ACID transactions (concurrent reads/writes)
    # - Schema enforcement and evolution
    # - Automatic file optimization
    ```

=== "Migration Strategy"
    ```python title="✅ Format Migration Utility"
    def migrate_to_optimized_format(source_path, target_path, format_type="delta"):
        """Migrate data to optimized format with partitioning"""
        
        # Read source data (with schema to avoid inference)
        df = spark.read.option("inferSchema", "false").csv(source_path, header=True)
        
        # Add partitioning columns if date column exists
        if "date" in df.columns:
            from pyspark.sql.functions import year, month
            df = df.withColumn("year", year(col("date"))) \
                   .withColumn("month", month(col("date")))
            partition_cols = ["year", "month"]
        else:
            partition_cols = None
        
        # Write in optimized format
        writer = df.write.mode("overwrite")
        
        if partition_cols:
            writer = writer.partitionBy(*partition_cols)
            
        if format_type == "delta":
            writer.format("delta").save(target_path)
        else:
            writer.parquet(target_path)
            
        print(f"Migration complete: {format_type} format at {target_path}")
        
        # Report compression ratio
        original_size = get_directory_size(source_path)
        new_size = get_directory_size(target_path)
        compression_ratio = original_size / new_size
        print(f"Compression ratio: {compression_ratio:.1f}x smaller")
    
    # Usage
    migrate_to_optimized_format(
        source_path="s3://bucket/csv-data/",
        target_path="s3://bucket/delta-data/",
        format_type="delta"
    )
    ```

=== "Format Selection Guide"
    ```python title="✅ Choose Right Format"
    def recommend_file_format(use_case, data_size_gb, update_frequency):
        """Recommend optimal file format based on requirements"""
        
        if use_case == "analytics" and data_size_gb > 1:
            if update_frequency == "frequent":
                return "delta"  # ACID transactions needed
            else:
                return "parquet"  # Read-optimized
                
        elif use_case == "streaming":
            return "delta"  # Schema evolution, ACID
            
        elif use_case == "ml_training":
            return "parquet"  # Fast column access
            
        elif data_size_gb < 0.1:
            return "csv"  # Small data, simplicity matters
            
        else:
            return "parquet"  # Safe default for most cases
    
    # Usage
    format_choice = recommend_file_format(
        use_case="analytics",
        data_size_gb=100,
        update_frequency="daily"
    )
    print(f"Recommended format: {format_choice}")
    ```

## Key Takeaways

!!! tip "Format Selection Rules"
    - **Analytics workloads:** Use Parquet or Delta
    - **Production systems:** Use Delta for ACID guarantees
    - **Small datasets (< 100MB):** CSV is acceptable
    - **Schema evolution needs:** Avoid CSV

## Measuring Impact

```python title="Storage & Performance Comparison"
# CSV (1TB) → Parquet (200GB) → Delta (180GB)
# Query Speed: CSV baseline → Parquet 10x faster → Delta 12x faster
# Storage Cost: CSV baseline → Parquet 80% savings → Delta 82% savings
```

File format choice is one of the highest-impact optimizations you can make. The migration effort pays for itself within days through improved performance and reduced storage costs.