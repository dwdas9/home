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