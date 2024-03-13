---
layout: default
title: Docker Commands
parent: Misc Articles
nav_order: 1
---

![alt text](DockerCommandImages.png)

# Common docker commands

| Icon               | Command                                  |
|--------------------|------------------------------------------|
| 🏃 (Run)            | `docker run <image>`                     |
| ⏹️ (Stop)          | `docker stop <container>`                |
| ▶️ (Start)          | `docker start <container>`               |
| 🗑️ (Remove Ctr)    | `docker rm <container>`                  |
| 🖼️ (Remove Img)    | `docker rmi <image>`                     |
| 📃 (List Ctrs)      | `docker ps`                              |
| 🖼️ (List Imgs)      | `docker images`                          |
| ⬇️ (Pull)           | `docker pull <image>`                    |
| ⌨️ (Exec)           | `docker exec <container>`                |
| 🏗️ (Build)          | `docker build -t <tag> .`                |
| 🔊 (Logs)           | `docker logs <container>`                |
| 🔍 (Inspect)        | `docker inspect <container_or_image>`    |
| 📊 (Stats)          | `docker stats <container>`               |
| 📁 (Volume List)    | `docker volume ls`                       |
| 🆕 (Volume Create) | `docker volume create <volume_name>`    |
| 🚮 (Volume Remove) | `docker volume rm <volume_name>`        |
| 🌐 (Network List)  | `docker network ls`                      |
| 🌉 (Network Create)| `docker network create <network>`       |


<div style="font-size:18px;">
    <p><strong>🏃 (Run)</strong>: <code>docker run &lt;image&gt;</code></p>
    <p><strong>⏹️ (Stop)</strong>: <code>docker stop &lt;container&gt;</code></p>
    <p><strong>▶️ (Start)</strong>: <code>docker start &lt;container&gt;</code></p>
    <p><strong>🗑️ (Remove Ctr)</strong>: <code>docker rm &lt;container&gt;</code></p>
    <p><strong>🖼️ (Remove Img)</strong>: <code>docker rmi &lt;image&gt;</code></p>
    <p><strong>📃 (List Ctrs)</strong>: <code>docker ps</code></p>
    <p><strong>🖼️ (List Imgs)</strong>: <code>docker images</code></p>
    <p><strong>⬇️ (Pull)</strong>: <code>docker pull &lt;image&gt;</code></p>
    <p><strong>⌨️ (Exec)</strong>: <code>docker exec &lt;container&gt;</code></p>
    <p><strong>🏗️ (Build)</strong>: <code>docker build -t &lt;tag&gt; .</code></p>
</div>


---