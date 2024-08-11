---
layout: default
title: Connect VS Code To Docker
parent: Docker
nav_order: 2
---

- [Connect to docker container from Visual Studio Code](#connect-to-docker-container-from-visual-studio-code)
    - [Summary of Steps](#summary-of-steps)
  - [Install Dev Containers Extension](#install-dev-containers-extension)
  - [Attach to the running container](#attach-to-the-running-container)
  - [Install Jupyter notebook support extension in conatiner](#install-jupyter-notebook-support-extension-in-conatiner)
  - [Install Python Support Extension in Container](#install-python-support-extension-in-container)
  - [Install ipykernel](#install-ipykernel)
  - [Install py4j(if required)](#install-py4jif-required)
  - [Errors](#errors)
    - [failed: mkdir -p /.vscode-server](#failed-mkdir--p-vscode-server)
      - [Correct Method](#correct-method)
      - [Wrong Resolution](#wrong-resolution)
        - [Add user:root method](#add-userroot-method)
        - [docker run -u root method](#docker-run--u-root-method)
    - [No Kernel Visible](#no-kernel-visible)
    - [Py4J Error](#py4j-error)


# <span style="color: teal;">Connect to docker container from Visual Studio Code</span>

Here, I will show you how to connect to a container using VS Code to run Python code, create Jupyter notebooks, and more. This setup is very helpful. Containers are essentially Linux OS environments, and you can't log into them directly to install VS Code.

The connection is mainly done using the VS Code Dev Containers extension, which is the key component for connectivity. The following sections provide detailed steps to guide you through the process.

### Summary of Steps

1. **Install VS Code Dev Containers Extension** on your local machine.

2. Open a terminal and run the following commands in the container:
   ```bash
   sudo su
   mkdir -p /.vscode-server
   chmod -R 777 /.vscode-server
   ```

3. **Attach to the Running Container:**
   Open a remote window from the bottom left corner in VS Code.

4. **Install Jupyter & Python extensions** in the container.

5. **Install Required Python Packages:**
   Open a terminal and run the following commands in the container:
   ```bash
   sudo su
   pip install ipykernel
   pip install py4j
   ```

## <span style="color: Purple;">Install Dev Containers Extension</span>

In **Visual Studio Code** press **Ctrl+Shift+X**, search  **Dev Containers** and **install**.
<img src="images/image5.png" alt="Description of the image" style="max-width: 100%; height: auto; border: 1px solid #ddd; border-radius: 4px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">

## <span style="color: Purple;">Attach to the running container</span>

- Click the **Open Remote Window** button in the bottom-left corner of VS Code and select **Attach to Running Container** from the command palette that appears.
<img src="images/image3.png" alt="Description of the image" style="max-width: 100%; height: auto; border: 1px solid #ddd; border-radius: 4px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">

- Pick your active container from the presented list.

<img src="images/image2.png" alt="Description of the image" style="max-width: 100%; height: auto; border: 1px solid #ddd; border-radius: 4px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">

Note: Here you will encounter like this, go to the errors section to resolve it



## <span style="color: Purple;">Install Jupyter notebook support extension in conatiner</span>

Go to extensions(left pane), search Jupyter, click on Install in container

<img src="images/custom-image-2024-06-18-17-25-13.png" alt="Description of the image" style="max-width: 100%; height: auto; border: 1px solid #ddd; border-radius: 4px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">

## <span style="color: Purple;">Install Python Support Extension in Container</span>

Go to extensions(left pane), search Python, click on Install in container

<img src="images/custom-image-2024-06-18-17-15-37.png" alt="Description of the image" style="max-width: 100%; height: auto; border: 1px solid #ddd; border-radius: 4px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">


## <span style="color: Purple;">Install ipykernel</span>

Connect to the container from terminal(or EXEC in Docker container) and run this command:

```bash
sudo su
pip install ipykernel
```

Also, if you try to run a jupyter notebook, using the steps below

<img src="images/image10.png" alt="Installation in progress" style="max-width: 100%; height: auto; border: 1px solid #ddd; border-radius: 4px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">

You may be prompted to isntall the extension:

<img src="images/custom-image-2024-06-16-16-42-05.png" alt="Prompt to install ipykernel" style="max-width: 100%; height: auto; border: 1px solid #ddd; border-radius: 4px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">



## <span style="color: Red;">Install py4j(if required)</span>

<img src="images/custom-image-2024-06-16-16-44-45.png" alt="Running pip install ipykernel" style="max-width: 100%; height: auto; border: 1px solid #ddd; border-radius: 4px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1);">


## <span style="color: Red;">Errors</span>

### <span style="color: Chocolate;">failed: mkdir -p /.vscode-server</span>

When trying to attach to a Docker container using the VSCode Dev extension, you may encounter an error during the **Installing VS Code Server step**:

<img src="images/custom-image-2024-06-15-13-45-34.png" alt="Description of the image" style="border: 1px solid #ddd; border-radius: 4px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); max-width: 100%; height: auto;">

**Reason:** Insufficient permissions for VSCode to create a folder **.vscode-server** inside the root folder. It cannot create this folder: **/.vscode-server**.

For example, when it runs this command:

```sh
mkdir -p /root/.vscode-server/bin/
```
**Note:**  
When you attach to a running container, the Dev Container extension installs a remote server in the `.vscode-server` folder, defaulting to the root location. You can change this property by using:

**User Settings (JSON):** Press `Ctrl+Shift+P` > "Preferences: Open User Settings (JSON)". Add:
```json
"remote.SSH.serverInstallPath": {
    "<host>": "/test/location"
}
```
<img src="images/custom-image-2024-06-20-16-41-41.png" alt="Custom Image">

**Settings UI:** Go to File > Preferences > Settings, filter by `@ext:ms-vscode-remote.remote-ssh install`, and under "Server Install Path" > Add Item with Item = `<host>` and Value = `/test/location`.

![](images/custom-image-2024-06-20-16-51-22.png)

#### Correct Method

The correct method is to create the folder using the root user and provide permissions to it for the normal user. This way, you can create a normal container without needing to add the root user to the container.

To achieve this run the following commands in the container and then try to connect VS code again:

```bash
sudo su
mkdir -p /.vscode-server
chmod -R 777 /.vscode-server
```
> sometimes, e.g. in debian, just su

<img src="images/custom-image-2024-06-16-02-56-43.png" alt="Description of the image" style="border: 1px solid #ddd; border-radius: 4px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); max-width: 100%; height: auto;">


> Note: You may not always have su access or password. To resolve it you may have to create a Dockerfile and users inside it with elevated permission. Refer to my BitnamiSparkCluster [article](3-BitnamiSparkClusterOnDocker.html) to create such containers.

#### Wrong Resolution

##### Add user:root method

If you use a docker-compose file to create the containers you can add `user: root` to every container. 

<img src="images/custom-image-2024-06-15-14-38-58.png" alt="Description of the image" style="border: 1px solid #ddd; border-radius: 4px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); max-width: 300; height: 500;">

##### docker run -u root method

Alternaively, you can start the container with root. This is feasible only for single containers.

`docker run -u root -it --name myCont theImageFileName /bin/bash`

### <span style="color: Chocolate;">No Kernel Visible</span>

Install the Jupyter extension in the container.

<img src="images/custom-image-2024-06-16-03-00-56.png" alt="Description of the image" style="border: 1px solid #ddd; border-radius: 4px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); max-width: 100%; height: auto;">

Also, go to the Docker container and install ipykernel:

```sh
sudo su
pip install ipykernel
```

<img src="images/custom-image-2024-06-16-03-02-43.png" alt="Description of the image" style="border: 1px solid #ddd; border-radius: 4px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); max-width: 100%; height: auto;">

Then it will detect the kernel automatically.

<img src="images/custom-image-2024-06-16-03-05-37.png" alt="Description of the image" style="border: 1px solid #ddd; border-radius: 4px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); max-width: 100%; height: auto;">

### <span style="color: Chocolate;">Py4J Error</span>

While running code, you may get this error:

<img src="images/custom-image-2024-06-16-03-07-07.png" alt="Description of the image" style="border: 1px solid #ddd; border-radius: 4px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); max-width: 100%; height: auto;">

**Install** **py4j** in the **container** to resolve it:

```sh
sudo su
pip install py4j
```

<img src="images/custom-image-2024-06-16-03-07-55.png" alt="Description of the image" style="border: 1px solid #ddd; border-radius: 4px; box-shadow: 0 4px 8px rgba(0, 0, 0, 0.1); max-width: 100%; height: auto;">

