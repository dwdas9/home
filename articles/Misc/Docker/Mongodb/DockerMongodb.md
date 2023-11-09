---
layout: default
title: Docker Setup Mongo DB
nav_exclude: true
---

## <span style="color: navy;">Table of contents</span>
- [Setting Up MongoDB in Docker](#setting-up-mongodb-in-docker)
  - [Quickstart](#quickstart)
    - [Pull the MongoDB Image](#pull-the-mongodb-image)
    - [Run the MongoDB Container](#run-the-mongodb-container)
    - [Access the MongoDB Shell](#access-the-mongodb-shell)
  - [Connect to MongoDB from an App](#connect-to-mongodb-from-an-app)
  - [Save MongoDB Data from a Docker Container](#save-mongodb-data-from-a-docker-container)
    - [Adding a Docker Volume to a MongoDB Container](#adding-a-docker-volume-to-a-mongodb-container)
    - [Mounting a Host System Directory in a MongoDB Docker Container](#mounting-a-host-system-directory-in-a-mongodb-docker-container)
  - [Custom Configuration](#custom-configuration)
  - [Secure MongoDB](#secure-mongodb)


# <span style="color: teal;">Setting Up MongoDB in Docker</span>

## Quickstart

### <span style="color: #32CD32;">Pull the MongoDB Image</span>
To begin, pull the latest MongoDB image from Docker Hub using the following Docker CLI command:

```
docker pull mongo
```

### <span style="color: #FF4500;">Run the MongoDB Container</span>
Run a MongoDB container by issuing the following command, which includes options for naming the container, exposing the port, and setting up a volume for data persistence:

```
docker run --name my-mongo -d -p 27017:27017 -v ~/mongo-data:/data/db mongo
```

### <span style="color: #FFD700;">Access the MongoDB Shell</span>
After starting the MongoDB container, you can access the MongoDB shell with this command:

```
docker exec -it my-mongo mongo
```

## <span style="color: #9932CC;">Connect to MongoDB from an App</span>
Connect to your MongoDB container from any application using `localhost` for the hostname and `27017` for the port.

## <span style="color: forestgreen;">Save MongoDB Data from a Docker Container</span>

Ensuring that your MongoDB data persists beyond the life of the container is crucial. Docker volumes and host system directory mounts are two methods to achieve data persistence.

### <span style="color: #FF8C00;">Adding a Docker Volume to a MongoDB Container</span>
Docker volumes are the preferred mechanism for persisting data generated by and used by Docker containers. To create a volume and attach it to your MongoDB container, use the following commands:

```
docker volume create mongo-data
docker run --name my-mongo -d -p 27017:27017 -v mongo-data:/data/db mongo
```

This sequence creates a new Docker volume named `mongo-data` and starts a new MongoDB container which will use this volume for storing its data.

### <span style="color: #3CB371;">Mounting a Host System Directory in a MongoDB Docker Container</span>
Alternatively, you can mount a directory from the host system into the container to persist data. This can be useful for backups, restores, or for when you need to directly access MongoDB files:

```
docker run --name my-mongo -d -p 27017:27017 -v /path/on/host:/data/db mongo
```

Replace `/path/on/host` with the path to the directory on your host machine where you want the MongoDB data to be stored. This will link the `/data/db` directory in the container to the specified path on the host machine.

## <span style="color: #20B2AA;">Custom Configuration</span>
For custom MongoDB configurations, you can mount a configuration file from the host into the container at runtime.

## <span style="color: #DC143C;">Secure MongoDB</span>
In production, always secure MongoDB with authentication. Start by running the container with the `--auth` flag to enable authentication:

```
docker run --name my-mongo -d -p 27017:27017 -v ~/mongo-data:/data/db mongo --auth
```

Then, create an administrative user with the appropriate privileges inside the MongoDB shell.