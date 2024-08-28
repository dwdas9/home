2. **Directory Already Exists Error**:
   - **Error**: `ERROR XBM0J: Directory /metastore_db already exists.`
   - **Solution**: This error occurs because the Hive metastore directory already exists. The Dockerfile has been updated to remove and recreate this directory before starting Hive services:
     ```Dockerfile
     CMD rm -rf /metastore_db && \
         mkdir -p /metastore_db && \
         chown -R dwdas:dwdas /metastore_db && \
         $HADOOP_HOME/sbin/start-dfs.sh && \
         $HADOOP_HOME/sbin/start-yarn.sh && \
         $HIVE_HOME/bin/hive --service metastore & \
         $HIVE_HOME/bin/hive --service hiveserver2 & \
         /bin/bash
     ```

## Log file locations

- **Hadoop Logs:** `/usr/local/hadoop/logs/`
- **Hive Logs:** `  /tmp/dwdas/hive.log`

### **1. Hadoop Logs:**

- **Location:** Hadoop logs are generally found in the `logs` directory within the Hadoop installation directory. Based on your Dockerfile, the Hadoop logs should be in:
  
  ```bash
  /usr/local/hadoop/logs/
  ```

  You can check the logs for different Hadoop components like `NameNode`, `DataNode`, `ResourceManager`, and `NodeManager`.

  Example files you might find:
  - `hadoop-hdfs-namenode-<hostname>.log`
  - `hadoop-hdfs-datanode-<hostname>.log`
  - `yarn-resourcemanager-<hostname>.log`
  - `yarn-nodemanager-<hostname>.log`

### **2. Hive Logs:**

- **Location:** Hive logs are typically stored in a `logs` directory within the Hive installation directory. In your setup, the Hive logs should be in:

  ```bash
  /tmp/dwdas/hive.log
  ```

  You can check the logs for HiveServer2 and other Hive-related processes.

  Example files you might find:
  - `hiveserver2.log`
  - `hive.log`


### **Truncate the Log File:**

You can truncate the log file to zero size without stopping Hive by using the `>` redirection operator. This will effectively clear the contents of the log file while keeping it open for Hive to continue writing to it.

Run the following command inside your Docker container or on your host machine if the file is accessible:

```bash
> /tmp/dwdas/hive.log
```

After running the truncation command, you can check the size of the log file to ensure it has been cleared:

```bash
ls -lh /tmp/dwdas/hive.log
```

The file size should be 0 bytes.
