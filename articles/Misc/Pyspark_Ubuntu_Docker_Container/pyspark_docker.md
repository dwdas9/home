---
layout: default
title: Pyspark Ubuntu Docker Setup
nav_exclude: true
---

## Table of contents

- [Setting Up a Dockerized Spark Environment on Ubuntu for Windows](#setting-up-a-dockerized-spark-environment-on-ubuntu-for-windows)
  - [Background](#background)
  - [Quickstart](#quickstart)
    - [Create the Dockerfile](#create-the-dockerfile)
    - [Build the Docker Image](#build-the-docker-image)
    - [Run the Docker Container](#run-the-docker-container)
    - [Work with the docker container from a local VS Code](#work-with-the-docker-container-from-a-local-vs-code)
  - [Enable Jupyter notebook support extension](#enable-jupyter-notebook-support-extension)



# Setting Up a Dockerized Spark Environment on Ubuntu for Windows

![Image of setup process](images/image7.jpg)

## Background

I'll demonstrate how to use Docker files, and how to integrate a Pyspark environment with VS Code, by setting up a functional Pyspark environment on Ubuntu. Typically, you would opt for a pre-built image with these components, such as apache/spark.             

## Quickstart

### Create the Dockerfile

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

### Build the Docker Image
- Go to the project directory with the Dockerfile in your terminal.
- Execute the command: `docker build -t pyspark-ubuntu-image .`
  - `pyspark-ubuntu-image` is the name you choose for your Docker image.
  - The period `.` signifies that the Dockerfile is located in the current directory.

![Placeholder for the Docker build process image](images/image9.png)

### Run the Docker Container
Certainly! Here’s the integrated instruction set with the images included:

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

### Work with the docker container from a local VS Code

1. Install the Visual Studio Code Dev Containers Extension by searching for "Dev Containers" in the Extensions view (Ctrl+Shift+X) and clicking 'Install'.
   ![VS Code Dev Containers Extension](images/image5.png)

2. Click the "Open Remote Window" button in the bottom-left corner of VS Code.

3. Select "Attach to Running Container" from the command palette that appears.

   ![Attach to Running Container](images/image3.png)

4. Pick your active container from the presented list.

   ![Active Container List](images/image2.png)

5. A new VS Code window will open, connected to your container.

## Enable Jupyter notebook support extension

Integrate Jupyter notebook support in VS Code while connected to the container by enabling or installing the Jupyter notebook support extension.

![Jupyter Support Extension](images/image4.png)

Once set up, you can manage Python scripts, Jupyter notebooks, and leverage Spark for data operations and machine learning within VS Code.

**For Python (.py) files:**
- Open and execute the `.py` file directly in VS Code.

**For Jupyter Notebooks (.ipynb):**
- Ensure you select the correct kernel when executing a notebook.
- If prompted, install the `ipykernel` package. To do this before you're prompted, run `pip install ipykernel` in the VS Code terminal.

![Jupyter Notebook Kernel](images/image10.png)

---

*For any questions or further assistance, please contact D Das at das.d@hotmail.com.*