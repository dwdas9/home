## **Step 1: Updated `entrypoint.sh`**

```bash
#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Function to start SSH service
start_ssh() {
    echo "Starting SSH service..."
    service ssh start
}

# Function to start MySQL service and initialize metastore
start_mysql() {
    echo "Starting MySQL service..."
    service mysql start

    echo "Configuring MySQL for Hive Metastore..."
    mysql -uroot -pPassw0rd <<EOF
CREATE DATABASE IF NOT EXISTS metastore;
CREATE USER IF NOT EXISTS 'hive'@'localhost' IDENTIFIED BY 'Passw0rd';
GRANT ALL PRIVILEGES ON metastore.* TO 'hive'@'localhost';
FLUSH PRIVILEGES;
EOF
}

# Function to format HDFS namenode
format_namenode() {
    if [ ! -d "/usr/local/hadoop/tmp/hdfs/namenode/current" ]; then
        echo "Formatting HDFS namenode..."
        hdfs namenode -format -force -nonInteractive
    else
        echo "HDFS namenode already formatted."
    fi
}

# Function to start HDFS services
start_hdfs() {
    echo "Starting HDFS services..."
    start-dfs.sh
}

# Function to start YARN services
start_yarn() {
    echo "Starting YARN services..."
    start-yarn.sh
}

# Function to start MapReduce JobHistory Server
start_historyserver() {
    echo "Starting MapReduce JobHistory Server..."
    mr-jobhistory-daemon.sh start historyserver
}

# Function to start Hive services
start_hive() {
    echo "Starting Hive Metastore..."
    nohup hive --service metastore > /tmp/hive-metastore.log 2>&1 &

    echo "Starting HiveServer2..."
    nohup hive --service hiveserver2 > /tmp/hive-server2.log 2>&1 &
}

# Function to keep the container running
keep_container_alive() {
    echo "All services started. Tail logs to keep the container running..."
    tail -f /dev/null
}

# Execute functions in order
start_ssh
start_mysql
format_namenode
start_hdfs
start_yarn
start_historyserver
start_hive
keep_container_alive
```

**Explanation of the Script:**

- **`set -e`**: Ensures that the script exits immediately if any command fails.
- **`start_ssh`**: Starts the SSH service required by Hadoop.
- **`start_mysql`**: Starts MySQL service and configures the Hive metastore database with user `hive` and password `Passw0rd`.
- **`format_namenode`**: Checks if the namenode is already formatted; if not, formats it.
- **`start_hdfs`**: Starts HDFS services including namenode and datanode.
- **`start_yarn`**: Starts YARN services including resourcemanager and nodemanager.
- **`start_historyserver`**: Starts the MapReduce JobHistory Server.
- **`start_hive`**: Starts Hive Metastore and HiveServer2 services in the background and redirects logs to `/tmp/`.
- **`keep_container_alive`**: Keeps the container running by tailing `/dev/null`.

---

## **Step 2: Update `Dockerfile`**

Ensure your `Dockerfile` correctly copies the `entrypoint.sh` script and sets appropriate permissions.

```Dockerfile
# Use a base image with Java
FROM openjdk:8-jdk

# Set environment variables
ENV HADOOP_VERSION=3.4.0
ENV HIVE_VERSION=4.0.0
ENV MYSQL_ROOT_PASSWORD=Passw0rd
ENV HADOOP_HOME=/usr/local/hadoop
ENV HIVE_HOME=/usr/local/hive
ENV PATH=$PATH:$HADOOP_HOME/bin:$HADOOP_HOME/sbin:$HIVE_HOME/bin

# Install necessary packages
RUN apt-get update && \
    apt-get install -y ssh rsync mysql-server wget && \
    apt-get clean

# Create a user
RUN useradd -ms /bin/bash dwdas

# Switch to user
USER dwdas
WORKDIR /home/dwdas

# Download and extract Hadoop
RUN wget https://downloads.apache.org/hadoop/common/hadoop-${HADOOP_VERSION}/hadoop-${HADOOP_VERSION}.tar.gz && \
    tar -xzf hadoop-${HADOOP_VERSION}.tar.gz && \
    mv hadoop-${HADOOP_VERSION} $HADOOP_HOME && \
    rm hadoop-${HADOOP_VERSION}.tar.gz

# Download and extract Hive
RUN wget https://downloads.apache.org/hive/hive-${HIVE_VERSION}/apache-hive-${HIVE_VERSION}-bin.tar.gz && \
    tar -xzf apache-hive-${HIVE_VERSION}-bin.tar.gz && \
    mv apache-hive-${HIVE_VERSION}-bin $HIVE_HOME && \
    rm apache-hive-${HIVE_VERSION}-bin.tar.gz

# Copy configuration files
COPY --chown=dwdas:dwdas core-site.xml $HADOOP_HOME/etc/hadoop/
COPY --chown=dwdas:dwdas hdfs-site.xml $HADOOP_HOME/etc/hadoop/
COPY --chown=dwdas:dwdas mapred-site.xml $HADOOP_HOME/etc/hadoop/
COPY --chown=dwdas:dwdas yarn-site.xml $HADOOP_HOME/etc/hadoop/
COPY --chown=dwdas:dwdas hive-site.xml $HIVE_HOME/conf/

# Copy MySQL JDBC driver
RUN wget https://dev.mysql.com/get/Downloads/Connector-J/mysql-connector-java-8.0.31.tar.gz && \
    tar -xzf mysql-connector-java-8.0.31.tar.gz && \
    cp mysql-connector-java-8.0.31/mysql-connector-java-8.0.31.jar $HIVE_HOME/lib/ && \
    cp mysql-connector-java-8.0.31/mysql-connector-java-8.0.31.jar $HADOOP_HOME/share/hadoop/common/lib/ && \
    rm -rf mysql-connector-java-8.0.31* 

# Set permissions
RUN chmod +x $HADOOP_HOME/bin/* && \
    chmod +x $HADOOP_HOME/sbin/* && \
    chmod +x $HIVE_HOME/bin/*

# Switch back to root to start services
USER root

# Copy and set permissions for entrypoint.sh
COPY entrypoint.sh /entrypoint.sh
RUN chmod +x /entrypoint.sh

# Expose necessary ports
EXPOSE 50070 8088 10000 10002 19888 3306

# Start services
CMD ["/entrypoint.sh"]
```

**Explanation of the Dockerfile:**

- **Base Image**: Uses `openjdk:8-jdk` as the base image.
- **Environment Variables**: Sets necessary environment variables for Hadoop and Hive.
- **Package Installation**: Installs SSH, rsync, MySQL server, and wget.
- **User Creation**: Creates a user `dwdas` and sets the working directory.
- **Downloading Hadoop and Hive**: Downloads and extracts Hadoop and Hive binaries.
- **Configuration Files**: Copies necessary configuration files into their respective directories.
- **MySQL JDBC Driver**: Downloads and places the MySQL JDBC driver in Hive and Hadoop lib directories.
- **Permissions**: Ensures all binaries and scripts have the correct execution permissions.
- **Entrypoint Script**: Copies the updated `entrypoint.sh` into the image and sets execution permission.
- **Exposed Ports**: Exposes all necessary ports for accessing services.
- **CMD**: Sets the default command to execute `entrypoint.sh` when the container starts.

---

## **Step 3: Configuration Files**

Ensure that your configuration files (`core-site.xml`, `hdfs-site.xml`, `mapred-site.xml`, `yarn-site.xml`, and `hive-site.xml`) are correctly set up.

### **Example `hive-site.xml`**

```xml
<configuration>
    <property>
        <name>javax.jdo.option.ConnectionURL</name>
        <value>jdbc:mysql://localhost:3306/metastore?useSSL=false&amp;createDatabaseIfNotExist=true</value>
    </property>
    <property>
        <name>javax.jdo.option.ConnectionDriverName</name>
        <value>com.mysql.cj.jdbc.Driver</value>
    </property>
    <property>
        <name>javax.jdo.option.ConnectionUserName</name>
        <value>hive</value>
    </property>
    <property>
        <name>javax.jdo.option.ConnectionPassword</name>
        <value>Passw0rd</value>
    </property>
    <property>
        <name>hive.metastore.warehouse.dir</name>
        <value>/user/hive/warehouse</value>
    </property>
    <property>
        <name>datanucleus.autoCreateSchema</name>
        <value>true</value>
    </property>
    <property>
        <name>datanucleus.autoCreateTables</name>
        <value>true</value>
    </property>
    <property>
        <name>datanucleus.fixedDatastore</name>
        <value>false</value>
    </property>
    <property>
        <name>hive.server2.thrift.port</name>
        <value>10000</value>
    </property>
</configuration>
```

**Note**: Ensure all other Hadoop configuration files are correctly set according to your environment and requirements.

---

## **Step 4: Update `docker-compose.yml`**

```yaml
version: '3.8'

services:
  hadoop-hive-mysql:
    build: .
    container_name: hadoop-hive-mysql
    hostname: hadoop-hive-mysql
    environment:
      - MYSQL_ROOT_PASSWORD=Passw0rd
    volumes:
      - namenode_data:/usr/local/hadoop/tmp/hdfs/namenode
      - datanode_data:/usr/local/hadoop/tmp/hdfs/datanode
      - hive_warehouse:/user/hive/warehouse
      - mysql_data:/var/lib/mysql
    ports:
      - "29070:50070"    # HDFS NameNode Web UI
      - "28088:8088"     # YARN ResourceManager Web UI
      - "21000:10000"    # HiveServer2
      - "21002:10002"    # HiveServer2 Thrift HTTP
      - "21988:19888"    # MapReduce JobHistory
      - "23306:3306"     # MySQL
    networks:
      - dasnet

volumes:
  namenode_data:
  datanode_data:
  hive_warehouse:
  mysql_data:

networks:
  dasnet:
    external: true
```

**Explanation of `docker-compose.yml`:**

- **Services**: Defines a single service `hadoop-hive-mysql`.
- **Volumes**: Uses Docker volumes for persistent storage of HDFS namenode, datanode, Hive warehouse, and MySQL data.
- **Ports**: Maps container ports to host ports using rare ports to avoid conflicts.
- **Networks**: Connects to an external network `dasnet`. Ensure this network exists or remove `external: true` to let Docker create it.

---

## **Step 5: Building and Running the Container**

1. **Build the Docker Image**:

   ```bash
   docker-compose build
   ```

2. **Start the Container**:

   ```bash
   docker-compose up -d
   ```

3. **Check Running Services**:

   - **HDFS NameNode Web UI**: [http://localhost:29070](http://localhost:29070)
   - **YARN ResourceManager Web UI**: [http://localhost:28088](http://localhost:28088)
   - **MapReduce JobHistory Web UI**: [http://localhost:21988](http://localhost:21988)

4. **Connecting to Hive**:

   - **Using Beeline**:

     ```bash
     beeline -u jdbc:hive2://localhost:21000 -n hive -p Passw0rd
     ```

   - **Using JDBC**:

     ```
     jdbc:hive2://localhost:21000/default
     ```

5. **Connecting to MySQL**:

   - **From Host Machine**:

     ```bash
     mysql -h 127.0.0.1 -P 23306 -u root -pPassw0rd
     ```

6. **Inspect Logs**:

   - **Hive Logs**:

     ```bash
     docker exec -it hadoop-hive-mysql bash
     tail -f /tmp/hive-metastore.log
     tail -f /tmp/hive-server2.log
     ```

   - **Hadoop Logs**:

     ```bash
     docker exec -it hadoop-hive-mysql bash
     hdfs dfsadmin -report
     yarn node -list
     ```

---

## **Troubleshooting**

- **Ports Already in Use**: If any of the mapped ports are already in use on your host machine, modify them in the `docker-compose.yml` file.
- **Service Failures**: Check respective logs inside the container for detailed error messages.
- **Network Issues**: Ensure that the Docker network `dasnet` exists or remove the `external` specification to let Docker manage it.