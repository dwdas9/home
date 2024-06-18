---
layout: default
title: Debian Container With Pyspark
parent: Docker
nav_order: 5
---
- [Create a Container with Debian and Pyspark Installed](#create-a-container-with-debian-and-pyspark-installed)
  - [Steps to Create the Image and Container](#steps-to-create-the-image-and-container)
    - [**Create a Dockerfile**:](#create-a-dockerfile)
    - [**Build the Docker Image**:](#build-the-docker-image)
    - [**Run the Docker Container**:](#run-the-docker-container)
  - [Details of the Container](#details-of-the-container)

# Create a Container with Debian and Pyspark Installed

Debian is highly stable, making it ideal for servers. In this article, I will guide you on creating a container with the latest version of Debian, Python 3.11, OpenJDK 17, and PySpark installed. The container will include both a root user and a named user, with essential environment variables configured. We will use a Dockerfile + docker-compose.yml approach.

## Steps to Create the Image and Container

### **Create a Dockerfile**:
   - Create a **Dockerfile.txt** with the contents below and **remove the .txt** extension

     ```dockerfile
     # Use Debian as the base image
     FROM debian:latest

     # Set environment variable to avoid interactive prompts during package installation
     ENV DEBIAN_FRONTEND=noninteractive

     # Update the package lists and install essential packages
     RUN apt-get update && apt-get install -y --no-install-recommends \
       curl \
       wget \
       tar \
       bash \
       ca-certificates \
       sudo \
       build-essential \
       libssl-dev \
       zlib1g-dev \
       libbz2-dev \
       libreadline-dev \
       libsqlite3-dev \
       libffi-dev

     # Copy the Python source tarball into the image
     COPY Python-3.11.9.tgz /tmp/

     # Extract, build, and install Python 3.11.9
     RUN cd /tmp && \
         tar -xvf Python-3.11.9.tgz && \
         cd Python-3.11.9 && \
         ./configure --enable-optimizations && \
         make -j 8 && \
         make altinstall && \
         cd .. && \
         rm -rf Python-3.11.9 Python-3.11.9.tgz

     # Create symbolic links for python, python3, pip, and pip3
     RUN ln -s /usr/local/bin/python3.11 /usr/bin/python && \
         ln -s /usr/local/bin/python3.11 /usr/bin/python3 && \
         ln -s /usr/local/bin/pip3.11 /usr/bin/pip && \
         ln -s /usr/local/bin/pip3.11 /usr/bin/pip3

     # Install OpenJDK 17
     RUN apt-get install -y openjdk-17-jdk-headless

     # Install the PySpark library using pip
     RUN python3.11 -m pip install pyspark

     # Set environment variables
     ENV JAVA_HOME=/usr/lib/jvm/java-17-openjdk-amd64
     ENV PYTHONPATH=/usr/local/lib/python3.11/dist-packages
     ENV PYSPARK_PYTHON=/usr/local/bin/python3.11
     ENV PATH=$PATH:$JAVA_HOME/bin

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
     docker build -t my-debian-pyspark .
     ```

### **Run the Docker Container**:
   - Once the image is built, run the container using the command:

     ```bash
     docker run -it --name my-debian-pyspark-container my-debian-pyspark
     ```

## Details of the Container

- **Base Image**: Debian (latest version at the time of build)
- **Python Version**: Python 3.11.9
- **Java Version**: OpenJDK 17
- **PySpark Version**: The latest version available via pip at the time of installation
- **Environment Variables**:
  - `JAVA_HOME`: `/usr/lib/jvm/java-17-openjdk-amd64`
  - `PYTHONPATH`: `/usr/local/lib/python3.11/dist-packages`
  - `PYSPARK_PYTHON`: `/usr/local/bin/python3.11`
  - `PATH`: `$PATH:$JAVA_HOME/bin`

- **Installed Packages**:
  - Essential build and development tools (`curl`, `wget`, `tar`, `bash`, `ca-certificates`, `sudo`, `build-essential`, `libssl-dev`, `zlib1g-dev`, `libbz2-dev`, `libreadline-dev`, `libsqlite3-dev`, `libffi-dev`)
  - Python 3.11.9, built and installed from source
  - OpenJDK 17 for Java runtime
  - PySpark installed via pip

- **User Configuration**:
  - Root user with password `Passw0rd`
  - New user `dwdas` with password `Passw0rd`, added to the sudo group with passwordless sudo privileges

- **Exposed Port**: 8888 (commonly used for Jupyter Notebook)

- **Default Command**: The container starts with a bash shell

