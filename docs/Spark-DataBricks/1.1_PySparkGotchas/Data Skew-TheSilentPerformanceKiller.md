# Data Skew - The Silent Performance Killer

!!! danger "Performance Impact"
    **Some tasks take 100x longer** - Uneven key distribution creates massive partitions while others remain tiny.

## The Problem

Data skew occurs when join keys are unevenly distributed. A few keys have millions of records while most have just a few. This creates severe bottlenecks where 99% of tasks finish quickly but 1% take hours.

```python title="❌ Problematic Code"
# BAD: Join with severely skewed data
user_events = spark.read.table("user_events")    # Some users: millions of events
user_profiles = spark.read.table("user_profiles") # Even distribution

# Hot keys create massive partitions
result = user_events.join(user_profiles, "user_id")
# 99% of tasks finish in 30 seconds, 1% take 2 hours!
```

## Why Skew Kills Performance

=== "Anatomy of Skew"
    - 95% of partitions: 1,000 records each (finish quickly)
    - 5% of partitions: 1,000,000 records each (become stragglers)
    - **Result:** Entire job waits for slowest partition

=== "Real-World Impact"
    - Job that should take 10 minutes takes 3 hours
    - Cluster sits 95% idle waiting for stragglers
    - Potential executor OOM on large partitions

## Solutions

=== "Skew Detection"
    ```python title="✅ Detect Join Skew"
    def detect_join_skew(df, join_column, sample_fraction=0.1):
        """Detect data skew in join keys"""
        
        print(f"=== Skew Analysis for '{join_column}' ===")
        
        # Sample for performance on large datasets
        sample_df = df.sample(sample_fraction)
        
        # Get key distribution
        key_counts = sample_df.groupBy(join_column).count() \
                              .orderBy(col("count").desc())
        
        stats = key_counts.agg(
            min("count").alias("min_count"),
            max("count").alias("max_count"), 
            avg("count").alias("avg_count")
        ).collect()[0]
        
        # Scale up from sample
        scale_factor = 1 / sample_fraction
        scaled_max = stats["max_count"] * scale_factor
        scaled_avg = stats["avg_count"] * scale_factor
        
        skew_ratio = scaled_max / scaled_avg if scaled_avg > 0 else 0
        
        print(f"Key distribution (scaled from {sample_fraction*100}% sample):")
        print(f"  Average count per key: {scaled_avg:,.0f}")
        print(f"  Maximum count per key: {scaled_max:,.0f}")
        print(f"  Skew ratio (max/avg): {skew_ratio:.1f}")
        
        # Show top skewed keys
        print(f"\nTop 10 most frequent keys:")
        top_keys = key_counts.limit(10).collect()
        for row in top_keys:
            scaled_count = row["count"] * scale_factor
            print(f"  {row[join_column]}: {scaled_count:,.0f} records")
        
        # Skew assessment
        if skew_ratio > 10:
            print(f"\n🚨 SEVERE SKEW DETECTED! Ratio: {skew_ratio:.1f}")
            return "severe"
        elif skew_ratio > 3:
            print(f"\n⚠️  Moderate skew detected. Ratio: {skew_ratio:.1f}")
            return "moderate"
        else:
            print(f"\n✅ No significant skew. Ratio: {skew_ratio:.1f}")
            return "none"
    
    # Usage
    skew_level = detect_join_skew(user_events, "user_id")
    ```

=== "Broadcast Join Strategy"
    ```python title="✅ Smart Broadcast Join"
    def smart_broadcast_join(large_df, small_df, join_keys):
        """Intelligently decide on broadcast join to avoid skew"""
        
        # Estimate small table size
        small_sample = small_df.sample(0.1)
        if small_sample.count() > 0:
            sample_rows = small_sample.count()
            total_rows = small_df.count()