---
layout: default
title: Pyspark Ubuntu Docker Setup
nav_exclude: true
---

## <span style="color: navy;">Table of contents</span>

- [Setting Up a Dockerized Spark Environment on Ubuntu for Windows  ](#setting-up-a-dockerized-spark-environment-on-ubuntu-for-windows--)
  - [Background](#background)
  - [Quickstart](#quickstart)
    - [Create the Dockerfile](#create-the-dockerfile)
    - [Build the Docker Image](#build-the-docker-image)
    - [Run the Docker Container](#run-the-docker-container)
    - [Work with the docker container from a local VS Code](#work-with-the-docker-container-from-a-local-vs-code)
  - [Enable Jupyter notebook support extension](#enable-jupyter-notebook-support-extension)
- [Appendix](#appendix)
  - [Using pre-configured ready-to-use Spark containers](#using-pre-configured-ready-to-use-spark-containers)
    - [Setup for apache/spark-py](#setup-for-apachespark-py)
    - [Setup for bitnami/spark](#setup-for-bitnamispark)
    - [Container Popularity](#container-popularity)




# <span style="color: teal;">Setting Up a Dockerized Spark Environment on Ubuntu for Windows  </span>

![Image of setup process](images/image7.jpg)

## <span style="color: teal;">Background

I'll demonstrate how to use Docker files, and how to integrate a Pyspark environment with VS Code, by setting up a functional Pyspark environment on Ubuntu. Typically, you would opt for a pre-built image with these components, such as apache/spark.             

## <span style="color: teal;">Quickstart</span>

### <span style="color: teal;">Create the Dockerfile</span>

1. Create a text file in a desired folder and paste the Dockerfile contents in it.
2. Rename the text file DockerFile(without ANY extension)

```Dockerfile
# Base the image on Ubuntu 20.04
FROM ubuntu:20.04  

# Set non-interactive mode to prevent prompts during build
ENV DEBIAN_FRONTEND=noninteractive  

# Update the package list
RUN apt-get update  

# Install software-properties-common for repo management
RUN apt-get install software-properties-common -y  

# Add the 'deadsnakes' PPA for newer Python versions
RUN add-apt-repository ppa:deadsnakes/ppa  

# Update package list post-PPA addition
RUN apt-get update  

# Install Python 3.9 and pip3
RUN apt-get install -y python3.9 python3-pip  

# Install headless OpenJDK 11
# Choosing headless JDK for a smaller footprint without GUI libs
# Using OpenJDK for its open-source, transparent, and community-driven nature
RUN apt-get install -y openjdk-11-jdk-headless  

# Install the PySpark library
RUN pip3 install pyspark
```

### <span style="color: teal;">Build the Docker Image</span>
- Go to the project directory with the Dockerfile in your terminal.
- Execute the command: `docker build -t pyspark-ubuntu-image .`
  - `pyspark-ubuntu-image` is the name you choose for your Docker image.
  - The period `.` signifies that the Dockerfile is located in the current directory.

![Placeholder for the Docker build process image](images/image9.png)

### <span style="color: teal;">Run the Docker Container</span>

- **Using Command Prompt:**
  1. Open Command Prompt as an administrator.
  2. Run the command: `docker run -it --name my_pyspark_ubuntu_cont pyspark-ubuntu-image /bin/bash`.
  3. If successful, you'll enter the container's shell, and it should resemble the image below.
     ![Container Shell](images/image6.png)
  4. Docker Desktop will list `my_pyspark_ubuntu_cont` as running in the container window, similar to the following image.
     ![Docker Desktop Container Window](images/image8.png)

- **Using Docker Desktop:**
  1. Launch Docker Desktop.
  2. Navigate to the 'Images' tab, find `pyspark-ubuntu-image`, and click 'Run'.
  3. Name your container `my_pyspark_ubuntu_cont`, and maintain default settings otherwise..

### <span style="color: teal;">Work with the docker container from a local VS Code</span>

1. Install the Visual Studio Code Dev Containers Extension by searching for "Dev Containers" in the Extensions view (Ctrl+Shift+X) and clicking 'Install'.
   ![VS Code Dev Containers Extension](images/image5.png)

2. Click the "Open Remote Window" button in the bottom-left corner of VS Code.

3. Select "Attach to Running Container" from the command palette that appears.

   ![Attach to Running Container](images/image3.png)

4. Pick your active container from the presented list.

   ![Active Container List](images/image2.png)

5. A new VS Code window will open, connected to your container.

## <span style="color: teal;">Enable Jupyter notebook support extension</span>

Integrate Jupyter notebook support in VS Code while connected to the container by enabling or installing the Jupyter notebook support extension.

![Jupyter Support Extension](images/image4.png)

Once set up, you can manage Python scripts, Jupyter notebooks, and leverage Spark for data operations and machine learning within VS Code.

**For Python (.py) files:**
- Open and execute the `.py` file directly in VS Code.

**For Jupyter Notebooks (.ipynb):**
- Ensure you select the correct kernel when executing a notebook.
- If prompted, install the `ipykernel` package. To do this before you're prompted, run `pip install ipykernel` in the VS Code terminal.

![Jupyter Notebook Kernel](images/image10.png)

# <span style="color: #228B22;">Appendix</span>

## <span style="color: teal;">Using pre-configured ready-to-use Spark containers</span>

Previously, we detailed the process of constructing a custom Docker container with all the necessary elements for PySpark. However, in real-world applications, it's more efficient to opt for a pre-configured Spark container that comes with all the required settings pre-installed. Here's a brief guide to installing pre-made Apache Spark Docker containers like apache/spark-py and bitnami/spark.

### <span style="color: #7e0041;">Setup for apache/spark-py</span>

Apache Spark-py offers a lightweight Spark environment with Python support. To use, follow these steps:

1. **Install Docker** from [Docker's Installation Guide](https://docs.docker.com/engine/install/).

2. **Pull the apache/spark-py image:**
   ```shell
   docker pull apache/spark-py
   ```

3. **Run the container:**
   ```shell
   docker run -it --name apache-spark-py -p 8080:8080 -p 4040:4040 apache/spark-py
   ```
   This opens an interactive shell with PySpark.

### <span style="color: #333333;">Setup for bitnami/spark</span>

Bitnami Spark provides a ready-to-go Spark environment. Setup is similar:

1. **Install Docker** as mentioned above.

2. **Pull the bitnami/spark image:**
   ```shell
   docker pull bitnami/spark
   ```

3. **Run the container:**
   ```shell
   docker run -it --name bitnami-spark -p 8080:8080 -p 4040:4040 bitnami/spark
   ```
   This starts a session with the Spark shell available.

### <span style="color: #DC143C;">Container Popularity</span>

The following table outlines the popularity of different Spark Docker containers:

<p style="color: #006600; font-family: 'Trebuchet MS', Helvetica, sans-serif; background-color: #e6ffe6; padding: 15px; border-left: 5px solid #00cc66;">

| Container | Popularity |
|-----------|------------|
| apache/spark-py | 32% |
| bitnami/spark | 17% |
| Other Notable Images | 31% |
| Community Images | 1% |

</p>

---

*For any questions or further assistance, please contact D Das at das.d@hotmail.com.*