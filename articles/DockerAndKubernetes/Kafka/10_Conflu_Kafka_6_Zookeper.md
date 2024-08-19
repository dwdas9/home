---
layout: default
title: Confluent Kafka With Zookeeper
parent: Docker
nav_order: 9
---
![](images/2024-08-19-14-15-27.png)

# <span style="color: FireBrick; font-family: Segoe UI, sans-serif;">Setting Up Kafka 6 with Zookeeper on Docker in Windows</span>

In this article, I will show you how to set up Confluent Kafka on Docker in Windows. We will be using a total of 9 containers, and this setup is very stable. You will only need one `docker-compose.yml` file, and there is no need for a Dockerfile. The setup will install the following Confluent Kafka components:

- confluentinc/cp-zookeeper:6.0.1
- confluentinc/cp-server:6.0.1
- confluentinc/cp-schema-registry:6.0.1
- confluentinc/cp-kafka-connect-base:6.0.1
- confluentinc/cp-enterprise-control-center:6.0.1
- confluentinc/cp-ksqldb-server:6.0.1
- confluentinc/cp-ksqldb-cli:6.0.1
- confluentinc/ksqldb-examples:6.0.1
- confluentinc/cp-kafka-rest:6.0.1

<div style="border: 2px solid #7A3DAA; border-radius: 10px; padding: 20px; background-color: MediumSlateBlue; font-family: 'Segoe UI, sans-serif'; color: white;">
    <p><strong>For the busy people</strong></p>
    <ol style="margin-left: 20px;">
        <li>Download and unzip the <a href="Docker-Compose.zip" style="color: #260A42; text-decoration: none;"><strong>file</strong></a> to any folder on your local machine.</li>
        <li>Open Command Prompt and <code>cd</code> to this folder using .</li>
        <li>Run <code>docker-compose up -d</code>.</li>
    </ol>
    <p>That's all! You will see 9 containers ready to serve you!</p>
</div>


## <span style="color: #7F3585; font-family: Segoe UI, sans-serif;">Overview</span>

Many people struggle with setting up Confluent Kafka on their local machines. While it's easier to use 'templates' on AWS or Azure, setting it up locally can be quite complicated. That’s why I’m sharing this method—it helps you create a stable, fully-working, production-like environment on your local system.

## <span style="color: #7F3585; font-family: Segoe UI, sans-serif;">Prerequisites</span>
Before you start, ensure that you have the following installed:
- **Docker Desktop**: Install it from the [Docker website](https://www.docker.com/products/docker-desktop). **Docker Compose**: It usually comes with Docker Desktop, so you don’t need to install it separately.
- Run the command `docker network create dasnet` in **CMD**. 

> Note: I use a network so that all my containers are part of the same network. But, this is not necessary. Also, using external network makes it a better setup.

## <span style="color: #7F3585; font-family: Segoe UI, sans-serif;">Steps to create the setup</span>
The steps are simple. Just follow these two steps and your setup will be up and running.

### <span style="color: #DimGray; font-family: Segoe UI, sans-serif;">1. Create the `docker-compose.yaml`</span>

Create a `docker-compose.yaml` file with the content below inside any folder. Alternatively download the file from the link given at the start of the article.

> I have verbosely commented the file. Hope you will find it useful.

```yaml
# Docker Compose file for setting up a Confluent Platform environment with various services.
# Author: DDas

version: '2'  # Specifies the Docker Compose version. Version 2 is stable and compatible with most setups.

services:  # This section defines all the services (containers) that will be created as part of this setup.

  zookeeper:  # Zookeeper service - essential for managing and coordinating Kafka brokers.
    image: confluentinc/cp-zookeeper:6.0.1  # Zookeeper version 6.0.1 from Confluent.
    hostname: zookeeper  # Internal hostname used within the Docker network.
    container_name: zookeeper  # Name of the container as it will appear in Docker.
    ports:
      - "2181:2181"  # laptop:container
    environment:  # Environment variables that configure Zookeeper.
      ZOOKEEPER_CLIENT_PORT: 2181  # Port where Zookeeper listens for client connections.
      ZOOKEEPER_TICK_TIME: 2000  # Basic time unit in milliseconds used by Zookeeper.
      ZOOKEEPER_SERVER_ID: 1
      ZOOKEEPER_INIT_LIMIT: 5
      ZOOKEEPER_SYNC_LIMIT: 2
      ZOOKEEPER_CLIENT_CNXNS: 60
    networks:
      - dasnet  # Connecting Zookeeper to the custom network 'dasnet'.

  broker:  # Kafka broker service - handles message publishing and subscribing.
    image: confluentinc/cp-server:6.0.1  # Kafka broker version 6.0.1 from Confluent.
    hostname: broker  # Internal hostname used within the Docker network.
    container_name: broker  # Name of the container as it will appear in Docker.
    depends_on:  # Ensures Zookeeper is started before the broker.
      - zookeeper
    ports:
      - "9192:9092"  # laptop:container
      - "9111:9101"  # laptop:container
    environment:  # Environment variables that configure the Kafka broker.
      KAFKA_BROKER_ID: 1  # Unique identifier for the broker.
      KAFKA_ZOOKEEPER_CONNECT: 'zookeeper:2181'  # Address of the Zookeeper service.
      KAFKA_LISTENER_SECURITY_PROTOCOL_MAP: PLAINTEXT:PLAINTEXT,PLAINTEXT_HOST:PLAINTEXT  # Protocol mapping.
      KAFKA_ADVERTISED_LISTENERS: PLAINTEXT://broker:29092,PLAINTEXT_HOST://localhost:9092  # Advertised listeners.
      KAFKA_METRIC_REPORTERS: io.confluent.metrics.reporter.ConfluentMetricsReporter  # Metrics reporter.
      KAFKA_OFFSETS_TOPIC_REPLICATION_FACTOR: 1  # Replication factor for the offsets topic.
      KAFKA_GROUP_INITIAL_REBALANCE_DELAY_MS: 0  # Delay in rebalancing consumer groups.
      KAFKA_CONFLUENT_LICENSE_TOPIC_REPLICATION_FACTOR: 1  # Replication factor for the license topic.
      KAFKA_CONFLUENT_BALANCER_TOPIC_REPLICATION_FACTOR: 1  # Replication factor for the balancer topic.
      KAFKA_TRANSACTION_STATE_LOG_MIN_ISR: 1  # Minimum in-sync replicas for transaction state log.
      KAFKA_TRANSACTION_STATE_LOG_REPLICATION_FACTOR: 1  # Replication factor for the transaction state log.
      KAFKA_JMX_PORT: 9101  # Port for JMX monitoring.
      KAFKA_JMX_HOSTNAME: localhost  # Hostname for JMX monitoring.
      KAFKA_CONFLUENT_SCHEMA_REGISTRY_URL: http://schema-registry:8081  # Schema Registry URL.
      CONFLUENT_METRICS_REPORTER_BOOTSTRAP_SERVERS: broker:29092  # Bootstrap servers for metrics reporter.
      CONFLUENT_METRICS_REPORTER_TOPIC_REPLICAS: 1  # Replication factor for metrics topics.
      CONFLUENT_METRICS_ENABLE: 'true'  # Enable Confluent metrics.
      CONFLUENT_SUPPORT_CUSTOMER_ID: 'anonymous'  # Customer ID for support.
      KAFKA_SASL_JAAS_CONFIG: "org.apache.kafka.common.security.plain.PlainLoginModule required username=\"admin\" password=\"Passw0rd\";"

    networks:
      - dasnet  # Connecting the Kafka broker to the custom network 'dasnet'.

  schema-registry:  # Schema Registry service - manages Avro schemas for Kafka topics.
    image: confluentinc/cp-schema-registry:6.0.1  # Schema Registry version 6.0.1 from Confluent.
    hostname: schema-registry  # Internal hostname used within the Docker network.
    container_name: schema-registry  # Name of the container as it will appear in Docker.
    depends_on:  # Ensures the broker is started before the Schema Registry.
      - broker
    ports:
      - "8181:8081"  # laptop:container
    environment:  # Environment variables that configure the Schema Registry.
      SCHEMA_REGISTRY_HOST_NAME: schema-registry  # Internal hostname for Schema Registry.
      SCHEMA_REGISTRY_KAFKASTORE_BOOTSTRAP_SERVERS: 'broker:29092'  # Kafka broker address for Schema Registry.
      SCHEMA_REGISTRY_LISTENERS: http://0.0.0.0:8081  # Listeners for Schema Registry.
      SCHEMA_REGISTRY_AUTH: "admin:Passw0rd"

    networks:
      - dasnet  # Connecting the Schema Registry to the custom network 'dasnet'.

  connect:  # Kafka Connect service - facilitates integration with external systems.
    image: confluentinc/cp-kafka-connect-base:6.0.1  # Kafka Connect version 6.0.1 from Confluent.
    hostname: connect  # Internal hostname used within the Docker network.
    container_name: kafka-connect  # Name of the container as it will appear in Docker.
    depends_on:  # Ensures the broker and Schema Registry are started before Kafka Connect.
      - broker
      - schema-registry
    ports:
      - "8183:8083"  # laptop:container
    environment:  # Environment variables that configure Kafka Connect.
      CONNECT_BOOTSTRAP_SERVERS: 'broker:29092'  # Kafka broker address for Kafka Connect.
      CONNECT_REST_ADVERTISED_HOST_NAME: connect  # Hostname for the Kafka Connect REST API.
      CONNECT_REST_PORT: 8083  # Port for the Kafka Connect REST API.
      CONNECT_GROUP_ID: kafka-connect  # Group ID for Kafka Connect.
      CONNECT_CONFIG_STORAGE_TOPIC: docker-connect-configs  # Topic for storing connector configs.
      CONNECT_CONFIG_STORAGE_REPLICATION_FACTOR: 1  # Replication factor for the config storage topic.
      CONNECT_OFFSET_FLUSH_INTERVAL_MS: 10000  # Interval for flushing offsets.
      CONNECT_OFFSET_STORAGE_TOPIC: docker-connect-offsets  # Topic for storing connector offsets.
      CONNECT_OFFSET_STORAGE_REPLICATION_FACTOR: 1  # Replication factor for the offset storage topic.
      CONNECT_STATUS_STORAGE_TOPIC: docker-connect-status  # Topic for storing connector statuses.
      CONNECT_STATUS_STORAGE_REPLICATION_FACTOR: 1  # Replication factor for the status storage topic.
      CONNECT_KEY_CONVERTER: org.apache.kafka.connect.storage.StringConverter  # Converter for Kafka Connect keys.
      CONNECT_VALUE_CONVERTER: io.confluent.connect.avro.AvroConverter  # Converter for Kafka Connect values.
      CONNECT_VALUE_CONVERTER_SCHEMA_REGISTRY_URL: http://schema-registry:8081  # Schema Registry URL.
      CLASSPATH: /usr/share/java/monitoring-interceptors/monitoring-interceptors-6.0.1.jar  # Additional classpath for interceptors.
      CONNECT_PRODUCER_INTERCEPTOR_CLASSES: "io.confluent.monitoring.clients.interceptor.MonitoringProducerInterceptor"  # Producer interceptor.
      CONNECT_CONSUMER_INTERCEPTOR_CLASSES: "io.confluent.monitoring.clients.interceptor.MonitoringConsumerInterceptor"  # Consumer interceptor.
      CONNECT_LOG4J_LOGGERS: org.apache.zookeeper=ERROR,org.I0Itec.zkclient=ERROR,org.reflections=ERROR  # Logging configuration.
      CONNECT_PLUGIN_PATH: "/usr/share/java,/usr/share/confluent-hub-components,/data/connect-jars"  # Plugin paths.
      CONNECT_SASL_JAAS_CONFIG: "org.apache.kafka.common.security.plain.PlainLoginModule required username=\"admin\" password=\"Passw0rd\";"

    volumes:  # Mounting a volume for persistent storage.
        - ${PWD}/data:/data
            
    networks:
      - dasnet  # Connecting Kafka Connect to the custom network 'dasnet'.

  control-center:  # Confluent Control Center service - web interface for managing and monitoring Kafka.
    image: confluentinc/cp-enterprise-control-center:6.0.1  # Control Center version 6.0.1 from Confluent.
    hostname: control-center  # Internal hostname used within the Docker network.
    container_name: control-center  # Name of the container as it will appear in Docker.
    depends_on:  # Ensures the broker, Schema Registry, and Kafka Connect are started before Control Center.
      - broker
      - schema-registry
      - connect
      - ksqldb-server
    ports:
      - "9121:9021"  # laptop:container
    environment:  # Environment variables that configure the Control Center.
      CONTROL_CENTER_BOOTSTRAP_SERVERS: 'broker:29092'  # Kafka broker address for Control Center.
      CONTROL_CENTER_CONNECT_CLUSTER: 'connect:8083'  # Kafka Connect cluster address for Control Center.
      CONTROL_CENTER_KSQL_KSQLDB1_URL: "http://ksqldb-server:8088"  # KSQL server URL for Control Center.
      CONTROL_CENTER_KSQL_KSQLDB1_ADVERTISED_URL: "http://localhost:8088"  # Advertised KSQL server URL.
      CONTROL_CENTER_SCHEMA_REGISTRY_URL: "http://schema-registry:8081"  # Schema Registry URL for Control Center.
      CONTROL_CENTER_REPLICATION_FACTOR: 1  # Replication factor for Control Center's internal topics.
      CONTROL_CENTER_INTERNAL_TOPICS_PARTITIONS: 1  # Number of partitions for Control Center's internal topics.
      CONTROL_CENTER_MONITORING_INTERCEPTOR_TOPIC_PARTITIONS: 1  # Partitions for monitoring interceptor topic.
      CONFLUENT_METRICS_TOPIC_REPLICATION: 1  # Replication factor for metrics topics.
      PORT: 9021  # Internal port for Control Center.

    networks:
      - dasnet  # Connecting Control Center to the custom network 'dasnet'.

  ksqldb-server:  # KSQL server service - SQL engine for processing real-time streams.
    image: confluentinc/cp-ksqldb-server:6.0.1  # KSQL server version 6.0.1 from Confluent.
    hostname: ksqldb-server  # Internal hostname used within the Docker network.
    container_name: ksqldb-server  # Name of the container as it will appear in Docker.
    depends_on:  # Ensures the broker and Kafka Connect are started before KSQL server.
      - broker
      - connect
    ports:
      - "8188:8088"  # laptop:container
    environment:  # Environment variables that configure KSQL server.
      KSQL_CONFIG_DIR: "/etc/ksql"  # Directory for KSQL configuration files.
      KSQL_BOOTSTRAP_SERVERS: "broker:29092"  # Kafka broker address for KSQL server.
      KSQL_HOST_NAME: ksqldb-server  # Internal hostname for KSQL server.
      KSQL_LISTENERS: "http://0.0.0.0:8088"  # Listeners for KSQL server.
      KSQL_CACHE_MAX_BYTES_BUFFERING: 0  # Disables caching in KSQL.
      KSQL_KSQL_SCHEMA_REGISTRY_URL: "http://schema-registry:8081"  # Schema Registry URL for KSQL server.
      KSQL_PRODUCER_INTERCEPTOR_CLASSES: "io.confluent.monitoring.clients.interceptor.MonitoringProducerInterceptor"  # Producer interceptor.
      KSQL_CONSUMER_INTERCEPTOR_CLASSES: "io.confluent.monitoring.clients.interceptor.MonitoringConsumerInterceptor"  # Consumer interceptor.
      KSQL_KSQL_CONNECT_URL: "http://connect:8083"  # Kafka Connect URL for KSQL server.
      KSQL_KSQL_LOGGING_PROCESSING_TOPIC_REPLICATION_FACTOR: 1  # Replication factor for logging processing topics.
      KSQL_KSQL_LOGGING_PROCESSING_TOPIC_AUTO_CREATE: 'true'  # Auto-create logging processing topics.
      KSQL_KSQL_LOGGING_PROCESSING_STREAM_AUTO_CREATE: 'true'  # Auto-create logging processing streams.

    networks:
      - dasnet  # Connecting KSQL server to the custom network 'dasnet'.

  ksqldb-cli:  # KSQL CLI service - command-line interface for interacting with KSQL server.
    image: confluentinc/cp-ksqldb-cli:6.0.1  # KSQL CLI version 6.0.1 from Confluent.
    container_name: ksqldb-cli  # Name of the container as it will appear in Docker.
    depends_on:  # Ensures the broker, Kafka Connect, and KSQL server are started before KSQL CLI.
      - broker
      - connect
      - ksqldb-server
    entrypoint: /bin/sh  # Entry point for the container to start a shell.
    tty: true  # Allocate a pseudo-TTY for interactive use.

    networks:
      - dasnet  # Connecting KSQL CLI to the custom network 'dasnet'.

  ksql-datagen:  # KSQL DataGen service - generates sample data for KSQL.
    image: confluentinc/ksqldb-examples:6.0.1  # KSQL DataGen version 6.0.1 from Confluent.
    hostname: ksql-datagen  # Internal hostname used within the Docker network.
    container_name: ksql-datagen  # Name of the container as it will appear in Docker.
    depends_on:  # Ensures KSQL server, broker, Schema Registry, and Kafka Connect are started before KSQL DataGen.
      - ksqldb-server
      - broker
      - schema-registry
      - connect
    command: "bash -c 'echo Waiting for Kafka to be ready... && \
                       cub kafka-ready -b broker:29092 1 40 && \
                       echo Waiting for Confluent Schema Registry to be ready... && \
                       cub sr-ready schema-registry 8081 40 && \
                       echo Waiting a few seconds for topic creation to finish... && \
                       sleep 11 && \
                       tail -f /dev/null'"  # Command to ensure services are ready before starting data generation.
    environment:  # Environment variables that configure KSQL DataGen.
      KSQL_CONFIG_DIR: "/etc/ksql"  # Directory for KSQL configuration files.
      STREAMS_BOOTSTRAP_SERVERS: broker:29092  # Kafka broker address for KSQL DataGen.
      STREAMS_SCHEMA_REGISTRY_HOST: schema-registry  # Schema Registry host for KSQL DataGen.
      STREAMS_SCHEMA_REGISTRY_PORT: 8081  # Schema Registry port for KSQL DataGen.

    networks:
      - dasnet  # Connecting KSQL DataGen to the custom network 'dasnet'.

  rest-proxy:  # Kafka REST Proxy service - provides a RESTful interface to Kafka.
    image: confluentinc/cp-kafka-rest:6.0.1  # Kafka REST Proxy version 6.0.1 from Confluent.
    hostname: rest-proxy  # Internal hostname used within the Docker network.
    container_name: rest-proxy  # Name of the container as it will appear in Docker.
    depends_on:  # Ensures the broker and Schema Registry are started before REST Proxy.
      - broker
      - schema-registry
    ports:
      - "8182:8082"  # laptop:container
    environment:  # Environment variables that configure the REST Proxy.
      KAFKA_REST_HOST_NAME: rest-proxy  # Internal hostname for REST Proxy.
      KAFKA_REST_BOOTSTRAP_SERVERS: 'broker:29092'  # Kafka broker address for REST Proxy.
      KAFKA_REST_LISTENERS: "http://0.0.0.0:8082"  # Listeners for REST Proxy.
      KAFKA_REST_SCHEMA_REGISTRY_URL: 'http://schema-registry:8081'  # Schema Registry URL for REST Proxy.

    networks:
      - dasnet  # Connecting REST Proxy to the custom network 'dasnet'.

networks:  # Network configuration for Docker containers.
  dasnet:  # Defines the custom network 'dasnet'.
    external: true  # Indicates that 'dasnet' is a pre-existing external network.

```

### <span style="color: #DimGray; font-family: Segoe UI, sans-serif;">2. Start the Services</span>

- **CD** to `docker-compose.yml` folder. Run the command  `docker-compose up -d`

### <span style="color: #DimGray; font-family: Segoe UI, sans-serif;">3. Check the setup</span>

- Open Docker Desktop. You should see all the containres up and running

![](images/2024-08-19-13-50-24.png)

- Open the [control centre](http://localhost:9121/clusters) to see the actual working.
![](images/2024-08-19-13-54-24.png)

- Go through the tabs to see all the functionalities

![alt text](Animation.gif)

## <span style="color: #7F3585; font-family: Segoe UI, sans-serif;">Component Details</span>

Refer to the table for quick info on the the setup:

| **Component**       | **Purpose**                                                | **Host Name**       | **Ports (Laptop:Container)** | **Key Environment Variables**                                                                                               | **Network** |
|---------------------|------------------------------------------------------------|---------------------|------------------------------|-----------------------------------------------------------------------------------------------------------------------------|-------------|
| **Zookeeper**       | Coordinates and manages Kafka brokers.                     | `zookeeper`         | 2181:2181                    | `ZOOKEEPER_CLIENT_PORT=2181`<br>`ZOOKEEPER_TICK_TIME=2000`                                                                  | `dasnet`    |
| **Kafka Broker**    | Handles message publishing and subscribing.                | `broker`            | 9192:9092<br>9111:9101       | `KAFKA_BROKER_ID=1`<br>`KAFKA_ZOOKEEPER_CONNECT=zookeeper:2181`<br>`KAFKA_ADVERTISED_LISTENERS=PLAINTEXT://broker:29092`    | `dasnet`    |
| **Schema Registry** | Manages Avro schemas for Kafka topics.                     | `schema-registry`   | 8181:8081                    | `SCHEMA_REGISTRY_KAFKASTORE_BOOTSTRAP_SERVERS=broker:29092`<br>`SCHEMA_REGISTRY_LISTENERS=http://0.0.0.0:8081`             | `dasnet`    |
| **Kafka Connect**   | Integrates Kafka with external systems (e.g., databases).  | `connect`           | 8183:8083                    | `CONNECT_BOOTSTRAP_SERVERS=broker:29092`<br>`CONNECT_REST_PORT=8083`<br>`CONNECT_GROUP_ID=kafka-connect`                  | `dasnet`    |
| **Control Center**  | Web interface for managing and monitoring Kafka.           | `control-center`    | 9121:9021                    | `CONTROL_CENTER_BOOTSTRAP_SERVERS=broker:29092`<br>`CONTROL_CENTER_CONNECT_CLUSTER=connect:8083`                           | `dasnet`    |
| **KSQL Server**     | SQL engine for processing real-time data streams.          | `ksqldb-server`     | 8188:8088                    | `KSQL_BOOTSTRAP_SERVERS=broker:29092`<br>`KSQL_LISTENERS=http://0.0.0.0:8088`<br>`KSQL_KSQL_SCHEMA_REGISTRY_URL=http://schema-registry:8081` | `dasnet`    |
| **REST Proxy**      | Provides a RESTful interface to Kafka.                     | `rest-proxy`        | 8182:8082                    | `KAFKA_REST_BOOTSTRAP_SERVERS=broker:29092`<br>`KAFKA_REST_LISTENERS=http://0.0.0.0:8082`                                  | `dasnet`    |
| **KSQL DataGen**    | Generates sample data for KSQL testing (optional).         | `ksql-datagen`      | N/A                          | `STREAMS_BOOTSTRAP_SERVERS=broker:29092`<br>`STREAMS_SCHEMA_REGISTRY_HOST=schema-registry`                                 | `dasnet`    |

> All components are connected via the `dasnet` custom Docker network.
