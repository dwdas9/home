---
layout: default
title: Debian_PySpark_venv
parent: Docker
nav_order: 6
---
- [Building a Debian-based Container with Python, PySpark, and Virtual Environment](#building-a-debian-based-container-with-python-pyspark-and-virtual-environment)
  - [Steps to Create the Image and Container](#steps-to-create-the-image-and-container)
    - [**Create a Dockerfile**:](#create-a-dockerfile)
    - [**Build the Docker Image**:](#build-the-docker-image)
    - [**Run the Docker Container**:](#run-the-docker-container)
  - [Details of the Container](#details-of-the-container)

# Building a Debian-based Container with Python, PySpark, and Virtual Environment

## Steps to Create the Image and Container

### **Create a Dockerfile**:
   - Create a Dockerfile with the following content:

     ```dockerfile
     # Use the latest version of Debian as the base image
     FROM debian:latest

     # Set environment variable to avoid interactive prompts during package installation
     ENV DEBIAN_FRONTEND=noninteractive

     # Update the package lists and install essential packages
     RUN apt-get update && \
         apt-get install -y curl wget tar bash ca-certificates sudo gnupg

     # Install Python 3.11, venv, pip, and OpenJDK 17
     RUN apt-get install -y python3.11 python3.11-venv python3.11-dev python3-pip openjdk-17-jdk-headless

     # Create a virtual environment
     RUN python3.11 -m venv /opt/venv

     # Activate the virtual environment and install PySpark
     RUN /opt/venv/bin/python -m pip install pyspark

     # Set environment variables
     ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
     ENV PYTHONPATH=/opt/venv/lib/python3.11/site-packages
     ENV PYSPARK_PYTHON=/opt/venv/bin/python
     ENV PATH=$PATH:$JAVA_HOME/bin:/opt/venv/bin

     # Clean up the package lists to reduce the image size
     RUN apt-get clean && rm -rf /var/lib/apt/lists/*

     # Create a root user and set its password
     RUN echo 'root:Passw0rd' | chpasswd

     # Create a new user 'dwdas', set a password, and add this user to the sudo group
     RUN useradd -ms /bin/bash dwdas && echo 'dwdas:Passw0rd' | chpasswd && adduser dwdas sudo

     # Allow the 'dwdas' user to run sudo commands without a password
     RUN echo 'dwdas ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers

     # Set the working directory to the home directory of the new user
     WORKDIR /home/dwdas

     # Switch to the new user 'dwdas'
     USER dwdas

     # Expose port 8888, commonly used for Jupyter Notebook, if needed
     EXPOSE 8888

     # Set the default command to start a bash shell
     CMD ["bash"]
     ```

### **Build the Docker Image**:
   - Open a terminal and navigate to the directory containing the Dockerfile.
   - Run the following command to build the Docker image:

     ```bash
     docker build -t my-debian-pyspark-venv .
     ```

### **Run the Docker Container**:
   - Once the image is built, run the container using the command:

     ```bash
     docker run -it --name my-debian-pyspark-venv-container my-debian-pyspark-venv
     ```

## Details of the Container

- **Base Image**: Debian (latest version at the time of build)
- **Python Version**: Python 3.11.9
- **Java Version**: OpenJDK 17
- **PySpark Version**: Installed via pip in a virtual environment
- **Virtual Environment**: Created using `python3.11 -m venv /opt/venv`
- **Environment Variables**:
  - `JAVA_HOME`: `/usr/lib/jvm/java-17-openjdk-amd64`
  - `PYTHONPATH`: `/opt/venv/lib/python3.11/site-packages`
  - `PYSPARK_PYTHON`: `/opt/venv/bin/python`
  - `PATH`: `$PATH:$JAVA_HOME/bin:/opt/venv/bin`

- **Installed Packages**:
  - Essential tools (`curl`, `wget`, `tar`, `bash`, `ca-certificates`, `sudo`, `gnupg`)
  - Python 3.11, venv, pip, and OpenJDK 17
  - PySpark installed in the virtual environment

- **User Configuration**:
  - Root user with password `Passw0rd`
  - New user `dwdas` with password `Passw0rd`, added to the sudo group with passwordless sudo privileges

- **Exposed Port**: 8888 (commonly used for Jupyter Notebook)

- **Default Command**: The container starts with a bash shell