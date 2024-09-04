## Connect Hive to Spark Environment

To connect a third PySpark container to the Hive system that you've set up using Docker, you need to configure Spark so that it can communicate with the Hive metastore and HiveServer2. Here's how you can do it step by step:

### 1. **Create and Run the PySpark Container**

You need to create and run a PySpark container that is on the same Docker network (`dasnet`) as the Hive metastore and HiveServer2.

Run the following command to create and connect the PySpark container to the same network:

```bash
docker run -d --network dasnet --name spark-container -p 4040:4040 -p 8080:8080 -v /path/to/spark-conf:/opt/spark/conf bitnami/spark:latest
```

Make sure you have a volume to persist Spark configurations. You can create a folder on your local machine that holds the necessary Hive configurations.

### 2. **Set Up Hive Configuration for PySpark**

Inside the PySpark container, Spark needs to know how to talk to the Hive metastore. You'll achieve this by setting up `hive-site.xml` with the correct Hive metastore URIs. You'll also need to copy `hive-site.xml` from the HiveServer2 container or create a new one.

Here’s a sample `hive-site.xml` you need to place inside your `/path/to/spark-conf/` on your host machine (or inside the PySpark container at `/opt/spark/conf/`):

```xml
<configuration>
  <property>
    <name>hive.metastore.uris</name>
    <value>thrift://metastore:9083</value>
    <description>Thrift URI for the remote metastore.</description>
  </property>
  <property>
    <name>javax.jdo.option.ConnectionDriverName</name>
    <value>org.postgresql.Driver</value>
  </property>
  <property>
    <name>javax.jdo.option.ConnectionURL</name>
    <value>jdbc:postgresql://postgres:5432/metastore_db</value>
  </property>
  <property>
    <name>javax.jdo.option.ConnectionUserName</name>
    <value>hive</value>
  </property>
  <property>
    <name>javax.jdo.option.ConnectionPassword</name>
    <value>password</value>
  </property>
  <property>
    <name>datanucleus.schema.autoCreateTables</name>
    <value>true</value>
  </property>
</configuration>
```

Make sure the following points are covered:
- **`hive.metastore.uris`** should point to the correct location of your metastore (`thrift://metastore:9083`).
- The correct connection details for PostgreSQL are provided.

You can either mount this file when running the PySpark container, or copy it into the container like this:

```bash
docker cp /path/to/hive-site.xml spark-container:/opt/spark/conf/hive-site.xml
```

### 3. **Install the PostgreSQL JAR in PySpark Container**

Since you are using PostgreSQL as the Hive metastore database, you need to ensure that the PySpark container has the PostgreSQL driver JAR installed.

You can copy the `postgresql-42.5.1.jar` into the PySpark container as follows:

> The file .jar file should be in the folder where the cmd is running the command.
> The spark location is /opt/**bitnami**/spark

```bash
docker cp .\postgresql-42.5.1.jar bitnami-spark-single-node:/opt/bitnami/spark/jars/
```

This will allow PySpark to communicate with the Hive metastore that is backed by PostgreSQL.

### 4. **Start a PySpark Session with Hive Support**

Now, start a PySpark session from within the PySpark container and ensure that it is set to use Hive as the catalog implementation.

1. **Enter the PySpark container:**

   ```bash
   docker exec -it spark-container /bin/bash
   ```

2. **Start PySpark with Hive support:**

   ```bash
   pyspark --conf spark.sql.catalogImplementation=hive
   ```

### 5. **Create and Query Tables Using PySpark**

Once inside the PySpark session, you can interact with the Hive metastore and create Hive tables. Here’s how you can create a table and query it using PySpark:

1. **Create a table:**

   ```python
   spark.sql("""
   CREATE TABLE IF NOT EXISTS sample_table (
       id INT,
       name STRING
   )
   """)
   ```

2. **Insert some data into the table:**

   ```python
   spark.sql("INSERT INTO sample_table VALUES (1, 'Alice'), (2, 'Bob')")
   ```

3. **Query the table:**

   ```python
   result = spark.sql("SELECT * FROM sample_table")
   result.show()
   ```

### 6. **Verify the Table in Hive**

After creating the table using PySpark, you can verify that the table is present in Hive using Beeline or any Hive client connected to HiveServer2.

1. **Connect to HiveServer2 using Beeline**:

   ```bash
   docker exec -it hiveserver2 /bin/bash
   beeline -u 'jdbc:hive2://hiveserver2:10000/'
   ```

2. **Verify the table**:

   ```sql
   SHOW TABLES;
   SELECT * FROM sample_table;
   ```

### Summary

- You set up a PySpark container connected to the Hive metastore and HiveServer2.
- Configured Spark to use Hive by providing `hive-site.xml` and the necessary PostgreSQL JAR.
- Used PySpark to create and query Hive tables.
- Verified that the table was created in Hive through Beeline.