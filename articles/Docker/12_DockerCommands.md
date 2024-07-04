---
layout: default
title: Docker Commands
parent: Docker
nav_order: 12
---

![alt text](images\DockerCommandImages.png)

# Common docker commands

| Icon               | Command                                           |
|--------------------|---------------------------------------------------|
| 🏃 **Run**          | **`docker run <image>`**                          |
| ⏹️ **Stop**        | **`docker stop <container>`**                     |
| ▶️ **Start**        | **`docker start <container>`**                    |
| 🗑️ **Remove Ctr**  | **`docker rm <container>`**                       |
| 🖼️ **Remove Img**  | **`docker rmi <image>`**                          |
| 📃 **List Ctrs**    | **`docker ps`**                                   |
| 🖼️ **List Imgs**    | **`docker images`**                               |
| ⬇️ **Pull**         | **`docker pull <image>`**                         |
| ⌨️ **Exec**         | **`docker exec <container>`**                     |
| 🏗️ **Build**        | **`docker build -t <tag> .`**                     |
| 🔊 **Logs**         | **`docker logs <container>`**                     |
| 🔍 **Inspect**      | **`docker inspect <container_or_image>`**         |
| 📊 **Stats**        | **`docker stats <container>`**                    |
| 📁 **Volume List**  | **`docker volume ls`**                            |
| 🆕 **Volume Create**| **`docker volume create <volume_name>`**          |
| 🚮 **Volume Remove**| **`docker volume rm <volume_name>`**              |
| 🌐 **Network List** | **`docker network ls`**                           |
| 🌉 **Network Create**| **`docker network create <network>`**            |
| 📡 **Network Connect**| **`docker network connect <network> <container>`**|
| 🔌 **Network Disconnect**| **`docker network disconnect <network> <container>`**|
| 🔄 **Pull Latest**  | **`docker pull <image>:latest`**                  |
| 🚫 **Build No Cache**| **`docker build --no-cache -t <tag> .`**         |
---