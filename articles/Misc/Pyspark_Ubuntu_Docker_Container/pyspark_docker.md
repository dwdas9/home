---
layout: default
title: Pyspark Ubuntu Docker Setup
nav_exclude: true
---

## Table of contents

- [Setting Up a Dockerized Spark Environment on Ubuntu for Windows](#setting-up-a-dockerized-spark-environment-on-ubuntu-for-windows)
  - [Background](#background)
  - [Steps](#steps)
    - [Create the Dockerfile](#create-the-dockerfile)
    - [Build the Docker Image](#build-the-docker-image)
    - [Run the Docker Container](#run-the-docker-container)
  - [Connect to the remote container](#connect-to-the-remote-container)
  - [Enable Jupyter notebook support extension](#enable-jupyter-notebook-support-extension)
  - [Running Jupyter notebooks](#running-jupyter-notebooks)
  - [For Python files](#for-python-files)
  - [For Jupyter Notebooks:](#for-jupyter-notebooks)



# Setting Up a Dockerized Spark Environment on Ubuntu for Windows

![Image of setup process](images/image7.jpg)

## Background

I'll demonstrate how to use Docker files, and how to integrate a Pyspark environment with VS Code, by setting up a functional Pyspark environment on Ubuntu. Typically, you would opt for a pre-built image with these components, such as apache/spark.             

## Steps

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
 - After building the image, you can start a container with it.
 - Using Command Prompt:
   - Open the Command Prompt as an administrator.
   - Enter the command: `docker run -it --name my_pyspark_ubuntu_cont pyspark-ubuntu-image /bin/bash`

1. If successful, you'll enter the container's shell.
   ![Container Shell](images/image6.png)

2. In Docker Desktop's container window, you'll see `my_pyspark_ubuntu_cont` listed as running.
   ![Docker Desktop Container Window](images/image8.png)

Using Docker Desktop:

3. Launch Docker Desktop from the system tray.

4. In the Images tab, locate and hit Run for `pyspark-ubuntu-image`.

5. Name your container and keep other settings default.

6. In the Containers tab, find the container using the name you provided.
   ![Container Tab](images/image1.png)

Configure VS Code and connect with the remote container:

7. Install Visual Studio Code Dev Containers Extension.

8. Open Visual Studio Code.

9. Go to Extensions (or press Ctrl+Shift+X).

10. Search for Dev Containers.

11. Click Install on the relevant result.
    ![VS Code Dev Containers Extension](images/image5.png)

Certainly! Here's a cleaned-up version of the markdown you provided:

## Connect to the remote container

1. In the bottom-left of VS Code, click the "Open Remote Window" icon.
2. At the top search window, a menu will appear.
3. Choose "Attach to Running Container".

![](images/image3.png)

4. Locate and click on your active container in the list.

![](images/image2.png)

5. VS Code will launch a new window connected to that container.

## Enable Jupyter notebook support extension

While VS code is connected with the container, enable/install Jupyter notebook support extension.

![](images/image4.png)

## Running Jupyter notebooks

The environment is ready to handle Python scripts, Jupyter notebooks (.ipynb files), and execute big data operations, analytics, and machine learning processes using Spark in Python.

## For Python files

Simply open any `.py` file and run it directly within VS Code.

## For Jupyter Notebooks:

**Note:**

- When executing a notebook, you'll need to select the appropriate kernel.
- You might be prompted to install the `ipykernel` package, especially when you try to run a Python cell for the first time.

![](images/image10.png)

To preemptively install `ipykernel`, open a terminal in VS Code and enter:

```
pip install ipykernel
```

---

*For any questions or further assistance, please contact D Das at das.d@hotmail.com.*