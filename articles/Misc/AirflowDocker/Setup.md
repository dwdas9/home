---
layout: default
title: Apache Airflow | Container | Windows
nav_exclude: true
---

## Table of Contents

- [Setting Up Apache Airflow with Docker on Windows](#setting-up-apache-airflow-with-docker-on-windows)
  - [Method 1 - With Bind Mounts in Docker on Windows](#method-1---with-bind-mounts-in-docker-on-windows)
    - [Prerequisites](#prerequisites)
    - [Create Required Folders](#create-required-folders)
    - [Download the Docker Compose File](#download-the-docker-compose-file)
      - [Note](#note)
    - [Initialize and Run Airflow](#initialize-and-run-airflow)
    - [Verify the Installation](#verify-the-installation)
  - [Method 2 - Using a Docker volume for data persistence](#method-2---using-a-docker-volume-for-data-persistence)
    - [Prerequisites](#prerequisites-1)
    - [Download Airflow Docker Image](#download-airflow-docker-image)
    - [Create a Docker Volume](#create-a-docker-volume)
    - [Initialize Airflow Database](#initialize-airflow-database)
    - [Start the Airflow Webserver](#start-the-airflow-webserver)
    - [Additional Tips](#additional-tips)
    - [Cleaning Up](#cleaning-up)

# Setting Up Apache Airflow with Docker on Windows

In this article, I'll show two approaches to setting up Apache Airflow using Docker on Windows. The first method, more suitable for production environments, involves a few additional steps. The second method is quicker, ideal for development settings.

## Method 1 - With Bind Mounts in Docker on Windows

<p style="color: #006600; font-family: 'Trebuchet MS', Helvetica, sans-serif; background-color: #e6ffe6; padding: 15px; border-left: 5px solid #00cc66;">
This section describes the installation of the latest version of Apache Airflow in Docker on Windows, focusing on the use of bind mounts for data persistence and easy management.
</p>

### <span style="color: #7e0041;">Prerequisites</span>
- Ensure [Docker Desktop](https://www.docker.com/products/docker-desktop/) is installed on your Windows machine.

### <span style="color: #3333cc;">Create Required Folders</span>
- Create a base directory, anywhere, for Airflow, e.g., `C:\Airflow_Das`.
- Within this directory, create three subdirectories: `dags`, `plugins`, and `logs`.

### <span style="color: #b35900;">Download the Docker Compose File</span>

- To get our `docker-compose.yaml`, open the [link](https://airflow.apache.org/docs/apache-airflow/2.7.2/docker-compose.yaml) in a web browser, right-click, and choose **Save As** and download it directly into your `Airflow_Das` directory. Ensure you remove the `.txt` extension if it's added automatically.

    ![Alt text](image-1.png)

#### Note
- The `docker-compose.yaml` file is crucial for our setup. Finding it on the [official Apache Airflow site](https://airflow.apache.org) can be a bit tricky. - A simple search for "docker-compose.yaml" should lead you to it quickly.
- At the time of writing this article, the latest version of the file could be found [here](https://airflow.apache.org/docs/apache-airflow/2.7.2/docker-compose.yaml).


### <span style="color: #804000;">Initialize and Run Airflow</span>
- Open PowerShell(with admin priv) and **cd** to `Airflow_Das`
- Execute:
   ```powershell
   docker-compose up airflow-init
   ```
   ![Alt text](image-2.png)
- Follow it with:
   ```powershell
   docker-compose up
   ```
   ![Alt text](image-3.png)
   You can see the logs cascading down your PowerShell window. Wait a few seconds and then you can safely close the window.

### <span style="color: #333399;">Verify the Installation</span>
- On Docker Desktop, look for a container named `Airflow_Das`, containing seven subcontainers.

    ![Alt text](image-4.png)

- Open `localhost:8080` in a web browser.
- Log in with the username and password: `airflow`.
  ![Alt text](image-5.png)

<p style="color: #cc3300; font-family: 'Trebuchet MS', Helvetica, sans-serif; background-color: #ffcccc; padding: 15px; border-left: 5px solid #ff6666;">
Now, your Apache Airflow container is set up and ready to process DAGs. This Docker-based installation ensures your workflows are executed in an isolated and controlled environment.
</p>

---
## Method 2 - Using a Docker volume for data persistence

<p style="color: #004d99; font-family: 'Trebuchet MS', Helvetica, sans-serif; background-color: #e6f7ff; padding: 15px; border-left: 5px solid #3399ff;">
This guide sets up Apache Airflow in a Docker container on Windows, using a Docker volume for data persistence. This setup is great for development and testing purposes.
</p>

### <span style="color: #9e0059;">Prerequisites</span>
Ensure Docker Desktop is installed and active on your Windows machine.

### <span style="color: #003366;">Download Airflow Docker Image</span>
Run the following command in your command prompt or power shell to pull the latest Airflow Docker image:
```bash
docker pull apache/airflow:latest
```
![Alt text](image.png)

### <span style="color: #cc0066;">Create a Docker Volume</span>
Execute this command to create a Docker volume named `airflow-volume` for data persistence:
```bash
docker volume create airflow-volume
```

### <span style="color: #006600;">Initialize Airflow Database</span>
Initialize the Airflow database using the following command:
```bash
docker run --rm -v airflow-volume:/opt/airflow apache/airflow:latest db init
```

### <span style="color: #333399;">Start the Airflow Webserver</span>
To start the Airflow webserver, use this command:

```bash
docker run -d --name airflow -p 8080:8080 -e AIRFLOW_UID=50000 -v airflow-volume:/opt/airflow apache/airflow:latest webserver
```
Access the Airflow UI at(UID/Pwd: airflow) [http://localhost:8080](http://localhost:8080).

### <span style="color: #333399;">Additional Tips</span>
- **<span style="color: #b35900;">Checking Logs:</span>** Use `docker logs airflow` to view logs.
- **<span style="color: #b35900;">Stopping the Container:</span>** Execute `docker stop airflow` to stop the server.
- **<span style="color: #b35900;">Restarting Airflow:</span>** After stopping, run `docker start airflow` to resume.
- **<span style="color: #b35900;">Data Safety:</span>** Information within `airflow-volume` is preserved across container restarts.

### <span style="color: #804000;">Cleaning Up</span>
- **<span style="color: #cc3300;">Remove Container:</span>** `docker rm -f airflow` erases the Airflow container.
- **<span style="color: #cc3300;">Delete Volume:</span>** Use `docker volume rm airflow-volume` to remove the volume. **Warning:** This deletes all your saved data!

<p style="color: #004d99; font-family: 'Lucida Grande', 'Lucida Sans Unicode', Geneva, Verdana, sans-serif; background-color: #e6f7ff; padding: 15px; border-left: 5px solid #66cdaa;">
<strong>Conclusion:</strong> The method describe here is good for development purpose but, for production environment, we will choose another method</p>

---