Brain DUMP! DONT PUBLISH!

Yes, that's correct. In your setup, you will primarily need two directories:

1. **hive-metastore**: This directory is used for logs or temporary metadata storage. Even though the main metadata is stored in the MSSQL database, having this directory helps in maintaining local configurations and logs.

2. **hive-warehouse**: This is the primary directory used for storing the actual data of managed tables. Both Hive and Spark (when configured to use Hive's metastore) will use this directory to store table data.

When Spark is configured to use Hive's metastore, Spark can directly interact with Hive's metastore and warehouse directory to create and manage tables. This means Spark will handle the creation and placement of data in the Hive warehouse directory. Therefore, both Spark and Hive need to have access to the `hive-warehouse` directory to ensure seamless interaction and data consistency.

### Key Points:
- **Hive Metastore**: The metadata about tables, including the location of table data, is stored in the Hive metastore, which in your case is backed by MSSQL.
- **Hive Warehouse**: The actual data of managed tables (internal tables) is stored in the Hive warehouse directory.
- **Spark Integration**: When Spark is configured to use Hive's metastore, it will directly create and manage tables in the Hive warehouse directory.

### Updated Docker Compose Configuration

Ensure both Hive and Spark services have access to the `hive-warehouse` volume.

```yaml
version: '3'

services:
  # Hive Metastore service
  hive-metastore:
    build:
      context: .
      dockerfile: Dockerfile
    container_name: hive-metastore
    environment:
      - SERVICE_NAME=metastore
      - IS_RESUME=true
    ports:
      - "9083:9083"
    networks:
      - spark-network
    volumes:
      - hive-metastore:/opt/hive/metastore
      - hive-warehouse:/user/hive/warehouse  # Mount shared volume for Hive warehouse


  # Spark service
  spark:
    image: your_spark_image  # Replace with your Spark image
    container_name: spark
    environment:
      - SPARK_MASTER=spark://spark-master:7077
      - SPARK_WORKER_CORES=2
      - SPARK_WORKER_MEMORY=1G
      - SPARK_DRIVER_MEMORY=1G
    networks:
      - spark-network
    volumes:
      - hive-warehouse:/user/hive/warehouse  # Mount shared volume for Hive warehouse

networks:
  spark-network:
    external: true
    name: spark-network
    driver: bridge

volumes:
  hive-metastore:
    driver: local  # Use local driver for Hive metastore logs and local metadata storage
  hive-warehouse:
    driver: local  # Use local driver for Hive warehouse
```

### Explanation

- **hive-metastore**: This volume is used for Hive metastore logs and local metadata storage.
- **hive-warehouse**: This shared volume is mounted in all relevant services (Hive Metastore, Hive Server2, and Spark) to ensure that all services can read and write data to the same directory.

### Configuration for Hive and Spark

1. **`hive-site.xml` Configuration**: Ensure your `hive-site.xml` has the correct settings for the Hive warehouse directory and metastore connection.

   ```xml
   <configuration>
     <property>
       <name>javax.jdo.option.ConnectionURL</name>
       <value>jdbc:sqlserver://<MSSQL_SERVER>:<PORT>;databaseName=<DATABASE_NAME></value>
     </property>
     <property>
       <name>javax.jdo.option.ConnectionDriverName</name>
       <value>com.microsoft.sqlserver.jdbc.SQLServerDriver</value>
     </property>
     <property>
       <name>javax.jdo.option.ConnectionUserName</name>
       <value><DATABASE_USER></value>
     </property>
     <property>
       <name>javax.jdo.option.ConnectionPassword</name>
       <value><DATABASE_PASSWORD></value>
     </property>
     <property>
       <name>hive.metastore.warehouse.dir</name>
       <value>/user/hive/warehouse</value>
       <description>Location of Hive warehouse directory</description>
     </property>
   </configuration>
   ```

2. **`spark-defaults.conf` Configuration**: Add the following to your Spark configuration (`spark-defaults.conf`):

   ```properties
   spark.sql.warehouse.dir=/user/hive/warehouse
   spark.sql.catalogImplementation=hive
   spark.hadoop.hive.metastore.uris=thrift://hive-metastore:9083
   ```

### Creating and Querying Tables

With this setup, when you create tables using Spark, they will be managed through Hive's metastore and stored in the Hive warehouse directory.

1. **Start Spark Shell or Submit a Job**:

   ```sh
   spark-shell --master local[*] --conf spark.sql.catalogImplementation=hive
   ```

2. **Create a DataFrame and Save it as a Hive Table**:

   ```scala
   import spark.implicits._
   import org.apache.spark.sql._

   // Sample data
   val data = Seq(
     (1, "Alice", 29),
     (2, "Bob", 32),
     (3, "Cathy", 28)
   )

   // Create DataFrame
   val df = data.toDF("id", "name", "age")

   // Save DataFrame as a Hive table
   df.write.saveAsTable("default.people")

   // Verify the table creation
   spark.sql("SELECT * FROM default.people").show()
   ```

3. **Verify the Table in Hive**:
   - Use the Hive shell to verify that the table has been created:

     ```sh
     hive
     ```

   - Run the following commands in the Hive shell:

     ```sql
     SHOW TABLES;
     SELECT * FROM default.people;
     ```

These are the folders you should have in your setup with both Spark and Hive

1. Hive Warehouse:
   - This is the default location where Hive stores table data.
   - Typically located at `/user/hive/warehouse` in HDFS, or a specified local path if you're not using HDFS.
   - Defined by the `hive.metastore.warehouse.dir` property in `hive-site.xml`.

2. Spark Warehouse:
   - This is the default location where Spark SQL stores table data when not using Hive.
   - By default, it's a directory named `spark-warehouse` in the current working directory.
   - Can be configured using the `spark.sql.warehouse.dir` property.

In your setup with both Spark and Hive, you have a few options:

Option 1: Use Hive Warehouse for both Spark and Hive
1. Configure Spark to use the Hive metastore:
   - Set `spark.sql.hive.metastore.version` and `spark.sql.hive.metastore.jars` in Spark configuration.
2. Use the same warehouse directory for both:
   - In `hive-site.xml`:
     ```xml
     <property>
       <name>hive.metastore.warehouse.dir</name>
       <value>/path/to/warehouse</value>
     </property>
     ```
   - In Spark configuration:
     ```
     spark.sql.warehouse.dir=/path/to/warehouse
     ```

Option 2: Separate warehouses for Spark and Hive
1. Keep Hive warehouse as is:
   - In `hive-site.xml`:
     ```xml
     <property>
       <name>hive.metastore.warehouse.dir</name>
       <value>/path/to/hive/warehouse</value>
     </property>
     ```
2. Set a different warehouse for Spark:
   - In Spark configuration:
     ```
     spark.sql.warehouse.dir=/path/to/spark/warehouse
     ```

Recommended Folder Structure:
```
/path/to/data/
├── hive-warehouse/
│   └── (Hive-managed tables)
├── spark-warehouse/
│   └── (Spark-managed tables, if using separate warehouses)
└── external-tables/
    └── (External table data for both Spark and Hive)
```

Key Points:
1. If you're using Spark with Hive integration, it's often simplest to use the same warehouse directory for both.
2. External tables can be stored anywhere; their location is specified when creating the table.
3. The actual paths will depend on your specific setup (HDFS, local filesystem, cloud storage, etc.).
4. Ensure both Spark and Hive have proper access permissions to these directories.


### How to test

From the spark serer command line enter:

spark-shell --conf spark.sql.catalogImplementation=hive --conf spark.hadoop.hive.metastore.uris=thrift://hive-metastore:9083

### 3. Verify Spark Configuration

Make sure the Spark configuration is correctly pointing to the Hive Metastore URI. Here’s a step-by-step guide to ensure the configuration is correct:

#### Option 1: Using `spark-defaults.conf`

Edit the `spark-defaults.conf` file, usually located in the `conf` directory of your Spark installation:

```conf
spark.sql.catalogImplementation=hive
spark.hadoop.hive.metastore.uris=thrift://hive-metastore:9083
```

#### Option 2: Command-Line Options

When starting the Spark shell or submitting a Spark job, ensure the configurations are passed correctly:

```sh
spark-shell --conf spark.sql.catalogImplementation=hive --conf spark.hadoop.hive.metastore.uris=thrift://hive-metastore:9083
```

or

```sh
spark-sql --conf spark.sql.catalogImplementation=hive --conf spark.hadoop.hive.metastore.uris=thrift://hive-metastore:9083
```

### 4. Check Hive and Hadoop Configuration Files

Ensure that the necessary Hive and Hadoop configuration files (`hive-site.xml` and `core-site.xml`) are available and correctly configured. These files should be placed in the `conf` directory of your Spark installation or referenced correctly.

#### Example `hive-site.xml`

Ensure that your `hive-site.xml` includes the correct metastore URI:

```xml
<configuration>
  <property>
    <name>hive.metastore.uris</name>
    <value>thrift://hive-metastore:9083</value>
  </property>
</configuration>
```

