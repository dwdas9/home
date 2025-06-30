# Schema Inference Double-Read Penalty

!!! danger "Performance Impact"
    **2x slower, 2x I/O cost** - Schema inference requires reading the entire dataset twice.

## The Problem

When you enable schema inference, Spark must scan the entire dataset to determine column types, then read it again to actually process the data.

```python title="❌ Problematic Code"
# BAD: Schema inference on large datasets
df = spark.read.csv("huge_dataset.csv", header=True, inferSchema=True)
# Spark reads the entire file twice!
```

## What Happens Under the Hood

=== "First Read"
    Spark scans entire dataset to infer schema
    
=== "Second Read" 
    Spark reads dataset again with inferred schema
    
=== "Cost Impact"
    - Double I/O operations
    - Double processing time  
    - Double cloud storage charges

## Solutions

=== "Predefined Schema"
    ```python title="✅ Define Schema Upfront"
    from pyspark.sql.types import StructType, StructField, StringType, IntegerType, TimestampType
    
    # Define schema once
    schema = StructType([
        StructField("user_id", StringType(), True),
        StructField("event_time", TimestampType(), True),
        StructField("event_count", IntegerType(), True)
    ])
    
    # Single read with known schema
    df = spark.read.csv("huge_dataset.csv", header=True, schema=schema)
    ```

=== "Schema Generation"
    ```python title="✅ Generate from Sample"
    def generate_schema_from_sample(file_path, sample_size=1000):
        """Generate schema from small sample"""
        sample_df = spark.read.csv(file_path, header=True, inferSchema=True).limit(sample_size)
        
        print("Generated Schema:")
        print("schema = StructType([")
        for field in sample_df.schema.fields:
            print(f'    StructField("{field.name}", {field.dataType}, {field.nullable}),')
        print("])")
        
        return sample_df.schema
    
    # Use for large datasets
    schema = generate_schema_from_sample("huge_dataset.csv")
    df = spark.read.csv("huge_dataset.csv", header=True, schema=schema)
    ```

=== "Smart Schema Caching"
    ```python title="✅ Schema Persistence"
    import json
    
    def save_schema(schema, file_path):
        """Save schema for reuse"""
        schema_json = schema.json()
        with open(f"{file_path}.schema", "w") as f:
            f.write(schema_json)
    
    def load_schema(file_path):
        """Load saved schema"""
        from pyspark.sql.types import StructType
        try:
            with open(f"{file_path}.schema", "r") as f:
                return StructType.fromJson(json.loads(f.read()))
        except FileNotFoundError:
            return None
    
    # Usage
    schema = load_schema("dataset.csv")
    if schema is None:
        # Generate and save schema once
        schema = generate_schema_from_sample("dataset.csv")
        save_schema(schema, "dataset.csv")
    
    df = spark.read.csv("dataset.csv", header=True, schema=schema)
    ```

## Key Takeaways

!!! tip "Schema Best Practices"
    - **Always define schemas** for production workloads
    - **Generate from samples** for unknown data
    - **Cache schemas** for repeated use
    - **Document schema changes** in version control

## Measuring Impact

```python title="Performance Comparison"
# Before: 2 full dataset scans
# After:  1 dataset scan
# Improvement: 50% faster, 50% less I/O cost 💰
```

Schema inference is convenient for exploration but costly for production. Taking a few minutes to define schemas can save hours of processing time.