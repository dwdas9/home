### Step 1: Create the MongoDB Container

#### 1.1: Prepare the Project Directory

1. **Create Project Directory**:
   - Create a directory named `mongo-cms`.
   - Inside `mongo-cms`, create the following subdirectories: `data/db`, `uploads`, and `processed`.

#### 1.2: Create the Dockerfile

1. **Create and Edit `Dockerfile`**:
   - In the `mongo-cms` directory, create a file named `Dockerfile` with the following content:

    ```Dockerfile
    # Use the official MongoDB image as the base
    FROM mongo:latest

    # Install Python and required packages
    RUN apt-get update && \
        apt-get install -y python3 python3-pip && \
        pip3 install pymongo gridfs watchdog xmltodict && \
        apt-get clean && \
        rm -rf /var/lib/apt/lists/*

    # Create directories for uploads and processed files
    RUN mkdir -p /uploads /processed

    # Expose MongoDB port
    EXPOSE 27017

    # Run MongoDB and keep container running
    CMD ["mongod"]
    ```

#### 1.3: Create the `docker-compose.yml` File

1. **Create and Edit `docker-compose.yml`**:
   - In the `mongo-cms` directory, create a file named `docker-compose.yml` with the following content:

    ```yaml
    version: '3.8'

    services:
      mongo-cms:
        build: .
        container_name: mongo-cms
        ports:
          - "27017:27017" # Map port 27017 on host to port 27017 in container
        volumes:
          - ./data/db:/data/db # MongoDB data directory
          - ./uploads:/uploads # Directory for new uploads
          - ./processed:/processed # Directory for processed files
        networks:
          - cms-network # Custom network for the CMS

    networks:
      cms-network:
    ```

#### 1.4: Build and Run the Docker Container

1. **Open Command Prompt**:
   - Navigate to the `mongo-cms` directory.

2. **Build and Run the Container**:
   - Execute the following command to build and start the container:

    ```sh
    docker-compose up --build
    ```