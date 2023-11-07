---
layout: default
title: Confluent Kafka All-in-one Docker
nav_exclude: true
---

## Table of Contents

- [Setting Up a Local Kafka Development Environment with Docker Compose](#setting-up-a-local-kafka-development-environment-with-docker-compose)
  - [Prerequisites](#prerequisites)
  - [Download the Docker Compose file](#download-the-docker-compose-file)
  - [Steps to Launch the Kafka Environment](#steps-to-launch-the-kafka-environment)
  - [Open the Confluent Control Center](#open-the-confluent-control-center)
  - [Appendix](#appendix)
    - [Error: no matching manifest for linux/arm64/v8](#error-no-matching-manifest-for-linuxarm64v8)
    - [About the docker-compose.yml](#about-the-docker-composeyml)
    - [Conclusion](#conclusion)
    - [Further reading](#further-reading)


# Setting Up a Local Kafka Development Environment with Docker Compose

<p style="color: #006600; font-family: 'Trebuchet MS', Helvetica, sans-serif; background-color: #e6ffe6; padding: 15px; border-left: 5px solid #00cc66;">
In this guide, I'll walk through setting up a local Kafka development environment using Docker Compose. The provided `docker-compose` file sets up all the necessary components, including Kafka broker, Schema Registry, Kafka Connect, Control Center, ksqlDB, and a REST Proxy. I have tested the installation in both Windows and Mac machines with M1 chip.
</p>

## Prerequisites
- Docker and Docker Compose installed on your local machine.

## Download the Docker Compose file

To get started with setting up Confluent Platform, you'll need the `docker-compose.yml` file. This file contains all the necessary configurations to run Confluent Platform services using Docker.

Here's what you need to do:

1. Click this [link](https://github.com/confluentinc/cp-all-in-one/blob/7.5.1-post/cp-all-in-one-kraft/docker-compose.yml) to access KRaft version of the `docker-compose.yml` file on GitHub.

Note: When choosing between KRaft and ZooKeeper as the metadata service for your Apache Kafka cluster, KRaft is the recommended option.
   
2. Once you're on the GitHub page, you might not be able to directly copy the file content using the "Raw" button or download it with `wget`.

3. Instead, you should click on the "Code" button near the top of the file content. This will display the full `docker-compose.yml` file in an editable text box.

4. Manually select all the text in the file (you can use `Ctrl/Cmd+A` to select everything), then copy it (`Ctrl/Cmd+C`).

5. Open a text editor on your computer, paste the content (`Ctrl/Cmd+V`, and save the file as `docker-compose.yml`.

With the `docker-compose.yml` file saved on your computer, you can proceed with deploying the Confluent Platform services using Docker Compose.

Remember: The container group will be named after the folder containing the docker-compose. I.e. If it is inside David/docker-compose.yml then the container group in docker will be David.

## Steps to Launch the Kafka Environment

1. Open a terminal and navigate to the directory where the file is saved.

2. Run the following command to start all services:

```bash
docker-compose up -d
```

4. The Docker Compose will start all the necessary services in the background.

5. To check the status of the services, use:

```bash
docker-compose ps
```

6. To view logs for a specific service (e.g., broker), use:

```bash
docker-compose logs broker
```

7. Once you're finished with the environment, you can stop and remove the services by running:

```bash
docker-compose down
```

## Open the Confluent Control Center

You can access the Control Center at http://localhost:9021 once the container is operational. For guidance, consult this quickstart guide: https://docs.confluent.io/platform/current/platform-quickstart.html#cp-quickstart-step-1.

## Appendix

### Error: no matching manifest for linux/arm64/v8

We might run into an error like no matching manifest for linux/arm65/v8 this error error indicates that the Docker images specified in the `docker-compose.yml` file do not have a version compatible with the architecture of our Mac's processor. Since late 2020, Apple has been transitioning to its own ARM-based M1 and M2 chips, and not all Docker images have been updated to include support for this `linux/arm64/v8` architecture.

1. **Update `docker-compose.yml`**: At the time of writing this article I couldn't find any ARM-compatible imageges. However, in future if you find ARM64-compatible images, update the `docker-compose.yml` file to use those images instead of the default ones.

2. **Use Platform Emulation (if available)**: Docker Desktop for Mac with Apple Silicon has the ability to emulate AMD64 architecture images. To enable this, add the `platform: linux/amd64` directive under the service in the `docker-compose.yml` file. However, note, this is still like a workaround and doesn't guarantee error-free future. Here's an example for one service:

   ```yaml
   services:
     zookeeper:
       image: confluentinc/cp-zookeeper:latest
       platform: linux/amd64
       # ... rest of the configuration ...
   ```

   Repeat this for each service defined in your Docker Compose file.


### About the docker-compose.yml

Here is an explanation of the differnet services in the docker-compose.yml

- **broker**: A Kafka broker service with custom environment configurations for topics, listeners, ports, IDs, etc.
- **schema-registry**: This service provides a serving layer for your metadata. It is configured to communicate with the Kafka broker and expose port 8081.
- **connect**: Kafka Connect with dependencies on the broker and schema-registry, configured to run connectors.
- **control-center**: Confluent's web-based tool for managing and monitoring the Kafka ecosystem.
- **ksqldb-server**: The server for ksqlDB, streaming SQL engine that enables real-time data processing against Apache Kafka.
- **ksqldb-cli**: A command-line interface for interacting with ksqlDB Server.
- **ksql-datagen**: A tool for generating sample data for Kafka topics and provides a source of continuously flowing data.
- **rest-proxy**: Provides a RESTful interface to Kafka clusters.

Each service is configured with specific environment variables necessary for its operation, ports for external access, and volume mounts where applicable. Some services depend on others, which is defined by the `depends_on` attribute ensuring that dependent services are started first.

The setup may be sufficient for a dev environment as it has a single replica for Kafka and the use of local hostnames. The `KAFKA_ADVERTISED_LISTENERS` and other network-related configurations are set up to allow the services to communicate both internally and with the host machine.

I have included a [commented docker-compose](docker-compose-commented.html) file which may help you understand the steps better.

### Conclusion

You now have a fully functional local Kafka development environment that includes a broker, Schema Registry, Kafka Connect, Control Center, ksqlDB, and a REST Proxy. This step has been tested in both WIndows and Mac M1 machines. The performance in Mac M1 might not be fuss-free.

### Further reading

[Confluent Documentation. Quick Start. Docker Container](https://docs.confluent.io/platform/current/platform-quickstart.html#cp-quickstart-step-1)

[Confluent Documentation. Quick Start using CLI](https://developer.confluent.io/quickstart/kafka-local/?_gl=1*1hbigt8*_ga*MzYyMDI3ODc1LjE2OTkyODY3MTE.*_ga_D2D3EGKSGD*MTY5OTMzMTY0Ni41LjEuMTY5OTM0MDk0MS40MC4wLjA.)

