---
layout: default
title: DatabricksMagicCmds
parent: PythonSQL
nav_order: 2
---

# <span style="color:#005f73;">Useful Databricks Magic Commands</span>

<img src="images/custom-image-2024-07-03-20-48-41.png" alt="alt text" style="
    border: 2px solid gray;
    border-radius: 6px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    margin: 20px;
    padding: 10px;
    width: 500px; /* Maintain aspect ratio */
    height: auto; /* Maintain aspect ratio */
    transition: transform 0.2s;
"/>


<h2>Some frequently used magic commands in Databricks</h2>

| <span style="color:#005f73;">**Magic Command**</span> | <span style="color:#005f73;">**Description**</span>                             | <span style="color:#005f73;">**Example**</span>                                          |
|-------------------------------|---------------------------------------------|-------------------------------------------------------------|
| <span style="color:#0a9396;">**%run**</span>          | Runs a Python file or a notebook.               | <span style="color:#0a9396;">`%run ./path/to/notebook`</span>                              |
| <span style="color:#0a9396;">**%sh**</span>           | Executes shell commands on the cluster nodes.   | <span style="color:#0a9396;">`%sh ls /dbfs`</span>                                        |
| <span style="color:#0a9396;">**%fs**</span>           | Interacts with the Databricks file system.      | <span style="color:#0a9396;">`%fs ls /mnt/data`</span>                                    |
| <span style="color:#0a9396;">**%sql**</span>          | Runs SQL queries.                              | <span style="color:#0a9396;">`%sql SELECT * FROM table_name`</span>                       |
| <span style="color:#0a9396;">**%scala**</span>        | Switches the notebook context to Scala.        | <span style="color:#0a9396;">`%scala val x = 10`</span>                                   |
| <span style="color:#0a9396;">**%python**</span>       | Switches the notebook context to Python.       | <span style="color:#0a9396;">`%python print("Hello, Databricks!")`</span>                 |
| <span style="color:#0a9396;">**%md**</span>           | Writes markdown text.                          | <span style="color:#0a9396;">`%md # This is a Markdown Header`</span>                     |
| <span style="color:#0a9396;">**%r**</span>            | Switches the notebook context to R.            | <span style="color:#0a9396;">`%r summary(data_frame)`</span>                              |
| <span style="color:#0a9396;">**%lsmagic**</span>      | Lists all the available magic commands.        | <span style="color:#0a9396;">`%lsmagic`</span>                                            |
| <span style="color:#0a9396;">**%jobs**</span>         | Lists all the running jobs.                    | <span style="color:#0a9396;">`%jobs`</span>                                               |
| <span style="color:#0a9396;">**%config**</span>       | Sets configuration options for the notebook.   | <span style="color:#0a9396;">`%config notebook.display.max_rows=1000`</span>              |
| <span style="color:#0a9396;">**%reload**</span>       | Reloads the contents of a module.              | <span style="color:#0a9396;">`%reload module_name`</span>                                 |
| <span style="color:#0a9396;">**%pip**</span>          | Installs Python packages.                      | <span style="color:#0a9396;">`%pip install pandas`</span>                                 |
| <span style="color:#0a9396;">**%load**</span>         | Loads the contents of a file into a cell.      | <span style="color:#0a9396;">`%load ./path/to/file.py`</span>                             |
| <span style="color:#0a9396;">**%matplotlib**</span>   | Sets up the matplotlib backend.                | <span style="color:#0a9396;">`%matplotlib inline`</span>                                  |
| <span style="color:#0a9396;">**%who**</span>          | Lists all the variables in the current scope.  | <span style="color:#0a9396;">`%who`</span>                                                |
| <span style="color:#0a9396;">**%env**</span>          | Sets environment variables.                    | <span style="color:#0a9396;">`%env MY_VARIABLE=my_value`</span>                            |

## Mounting and Unmounting Storage

| <span style="color:#005f73;">**Command**</span>       | <span style="color:#005f73;">**Example**</span>                                                                                                                                       |
|------------------------|---------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <span style="color:#0a9396;">**Mount ADLS**</span>    | <span style="color:navy;">dbutils.fs.mount(<br>&nbsp;&nbsp;source = "adl://<storage-account-name>.azuredatalakestore.net/<filesystem-name>",<br>&nbsp;&nbsp;mount_point = "/mnt/<mount-name>",<br>&nbsp;&nbsp;extra_configs = {<br>&nbsp;&nbsp;&nbsp;&nbsp;"dfs.adls.oauth2.access.token.provider.type": "ClientCredential",<br>&nbsp;&nbsp;&nbsp;&nbsp;"dfs.adls.oauth2.client.id": dbutils.secrets.get(scope = "<scope-name>", key = "client-id"),<br>&nbsp;&nbsp;&nbsp;&nbsp;"dfs.adls.oauth2.credential": dbutils.secrets.get(scope = "<scope-name>", key = "client-secret"),<br>&nbsp;&nbsp;&nbsp;&nbsp;"dfs.adls.oauth2.refresh.url": "https://login.microsoftonline.com/<directory-id>/oauth2/token"}<br>)</span> |
| <span style="color:#0a9396;">**Unmount Storage**</span> | <span style="color:#navy;">dbutils.fs.unmount("/mnt/<mount-name>")</span>                                                                                                                                  |
| <span style="color:#0a9396;">**List Mount Points**</span> | <span style="color:#0a9396;">display(dbutils.fs.mounts())</span>                                                                                                                                               |

## File Operations

| <span style="color:#005f73;">**Command**</span>             | <span style="color:#005f73;">**Example**</span>                                                                                                  |
|----------------------------|--------------------------------------------------------------------------------------------------------------------------------------------------------|
| <span style="color:#0a9396;">**Read CSV File**</span>       | <span style="color:navy;">df = spark.read.csv("/mnt/<mount-name>/data/file.csv", header=True, inferSchema=True)<br>display(df)</span>                                 |
| <span style="color:#0a9396;">**Write CSV File**</span>      | <span style="color:navy;">df.write.mode("overwrite").csv("/mnt/<mount-name>/output/")</span>                                                                         |
| <span style="color:#0a9396;">**List Files**</span>          | <span style="color:#0a9396;">display(dbutils.fs.ls("/mnt/<mount-name>"))</span>                                                                                          |

## Secret Management

| <span style="color:#005f73;">**Command**</span>       | <span style="color:#005f73;">**Example**</span>                                                                                                             |
|------------------------|-----------------------------------------------------------------------------------------------------------------------------------|
| <span style="color:#0a9396;">**Set a Secret**</span> | <span style="color:#0a9396;">databricks secrets create-scope --scope <scope-name><br>databricks secrets put --scope <scope-name> --key <key-name> --string-value <value></span> |
| <span style="color:#0a9396;">**Get a Secret**</span> | <span style="color:#0a9396;">secret = dbutils.secrets.get(scope = "<scope-name>", key = "<key-name>")</span>                                  |

## Shell Commands

| <span style="color:#005f73;">**Command**</span>        | <span style="color:#005f73;">**Example**</span>                                                                                                    |
|-------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <span style="color:#0a9396;">**Run Shell Command**</span> | <span style="color:#0a9396;">%sh ls -lh /dbfs/mnt/<mount-name>/</span>                                                                                                 |

## SQL and Context Switching

| <span style="color:#005f73;">**Command**</span>          | <span style="color:#005f73;">**Example**</span>                                                                                               |
|---------------------------|------------------------------------------------------------------------------------------------------------------------------------------------------|
| <span style="color:#0a9396;">**Run SQL Query**</span>    | <span style="color:#0a9396;">%sql SELECT * FROM table_name WHERE column = 'value'</span>                                                                                 |
| <span style="color:#0a9396;">**Switch to Scala**</span>  | <span style="color:#0a9396;">%scala val x = 10</span>                                                                                                                 |
| <span style="color:#0a9396;">**Switch to Python**</span> | <span style="color:#0a9396;">%python print("Hello, Databricks!")</span>                                                                                               |
| <span style="color:#0a9396;">**Switch to R**</span>      | <span style="color:#0a9396;">%r summary(data_frame)</span>                                                                                                                |

## Package Management

| <span style="color:#005f73;">**Command**</span>     | <span style="color:#005f73;">**Example**</span>                                                                                              |
|----------------------|----------------------------------------------------------------------------------------------------------------------------------------------------------|
| <span style="color:#0a9396;">**Install Packages**</span> | <span style="color:#0a9396;">%pip install pandas matplotlib</span>                                                                                           |

## Environment and Module Management

| <span style="color:#005f73;">**Command**</span>    | <span style="color:#005f73;">**Example**</span>                                                                                                |
|----------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <span style="color:#0a9396;">**Set Environment Variable**</span> | <span style="color:#0a9396;">%env MY_VARIABLE=my_value</span>                                                                                           |
| <span style="color:#0a9396;">**Load Python File**</span>         | <span style="color:#0a9396;">%load ./scripts/helper.py</span>                                                                                              |
| <span style="color:#0a9396;">**Reload Module**</span>            | <span style="color:#0a9396;">%reload my_module</span>                                                                                                    |

## Variable and Configuration Management

| <span style="color:#005f73;">**Command**</span>      | <span style="color:#005f73;">**Example**</span>                                                                                                |
|----------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <span style="color:#0a9396;">**List Variables**</span> | <span style="color:#0a9396;">%who</span>                                                                                                                         |
| <span style="color:#0a9396;">**Notebook Configuration**</span> | <span style="color:#0a9396;">%config notebook.display.max_rows=1000</span>                                                                                       |

## Markdown and Plotting

| <span style="color:#005f73;">**Command**</span>      | <span style="color:#005f73;">**Example**</span>                                                                                                |
|----------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <span style="color:#0a9396;">**Write Markdown**</span> | <span style="color:#0a9396;">%md # This is a Markdown Header<br>Here is some detailed description.</span>                                       |
| <span style="color:#0a9396;">**Setup Matplotlib**</span> | <span style="color:#0a9396;">%matplotlib inline<br>import matplotlib.pyplot as plt<br>plt.plot([1, 2, 3], [4, 5, 6])<br>plt.show()</span> |

## Job Management

| <span style="color:#005f73;">**Command**</span>      | <span style="color:#005f73;">**Example**</span>                                                                                                |
|----------------------|------------------------------------------------------------------------------------------------------------------------------------------------------------|
| <span style="color:#0a9396;">**List Running Jobs**</span> | <span style="color:#0a9396;">%jobs</span>                                                                                                                         |

