---
layout: default
title: Local-ADLS-SHIR-CopyData
parent: SynapseAnalytics
nav_order: 13
---

- [A Simple Synapse Pipeline. Copy files from Laptop To ADLS](#a-simple-synapse-pipeline-copy-files-from-laptop-to-adls)
  - [For the busy people](#for-the-busy-people)
  - [Create and Configure an Integration Runtime](#create-and-configure-an-integration-runtime)
  - [Create Two Linked Services (Connection Strings)](#create-two-linked-services-connection-strings)
    - [Linked Service to Laptop's Folder](#linked-service-to-laptops-folder)
      - [**A Common Error**](#a-common-error)
    - [Linked Service to ADLS](#linked-service-to-adls)
  - [Create a Pipeline with Copy Data Activity](#create-a-pipeline-with-copy-data-activity)
    - [Crate a New Pipeline in Syanpse Workspace](#crate-a-new-pipeline-in-syanpse-workspace)
    - [Add Copy Data Activity](#add-copy-data-activity)
    - [Configure the Source Dataset etc](#configure-the-source-dataset-etc)
    - [Configure the Sink Dataset](#configure-the-sink-dataset)
    - [Execute the Pipeline](#execute-the-pipeline)
  - [Appendix](#appendix)
    - [Manually Installating Integration Runtime](#manually-installating-integration-runtime)

![alt text](images\shir.png)

#  <span style="color: BlueViolet">A Simple Synapse Pipeline. Copy files from Laptop To ADLS</span>

We have a Synapse workspace and some CSV files on our **laptop** that we want to upload to **ADLS**. Here is the Microsoft recommended way to do it:

1. Install SHIR on the laptop.
2. Create a pipeline with a copy data activity.
3. Run the pipeline.

   <p style="color: white; font-family: 'Trebuchet MS', Helvetica, sans-serif; background-color: gray; padding: 15px; border-left: 5px solid navy;">
   In Power Platform, the SHIR is replaced by the on-premise gateway. Both are software installed on your local machine, but one is for Synapse and the other is for Power Platform, Fabric, etc.
   </p>

Let's get our hands dirty and see how to do it.

## For the busy people

An outline of all the activities typically involved in this process is provided in the table below. For more details, please continue reading the following sections.

| Step                                      | Action                                     | Definition                                                                                   |
|-------------------------------------------|--------------------------------------------|----------------------------------------------------------------------------------------------|
| 1: Open Synapse Workspace            | Synapse Workspace                          | Every synapse instance has a workspace. This is the central place for all synapse activities.                     |
| 2: Install SHIR on Laptop            | Self-hosted Integration Runtime (SHIR)     | A software installed on your laptop to enable data movement from on-premises to the cloud. [More details on Integration Pipelines](IntegrationRuntime.html)    |
| 3: Create Linked Services            | Linked Services                            | These are connection strings to your data sources (local file system) and destinations (ADLS).                |
| 4: Define Datasets                   | Datasets                                   | These  are like file type. In this case the source and destination datasets are .csvs |
| 5: Build the Pipeline                | Pipeline                                   | A pipline is a workflow, it contains many tasks like Copy data etc.                               |
| 6: Add a Copy Data Activity          | Copy Data Activity                         | This is a very important activity that takes care of the entire data copying. |
| 7: Set Up Triggers                   | Triggers                                   | This will tell what will trigger the pipeline |


## <span style="color: DarkCyan">Create and Configure an Integration Runtime</span>

The very first step is to install the integration runtime on the local machine. The IR is the backbone of the connection between the local folder and Synapse.

- In your synapse workspace go to **Manage** -> **Integration** -> **Integration runtime**. 
- Click on **New**, then in the settings, you will have two install options. Choose an **express setup**.
<img src="images\image-17.png" alt="alt text" style="
    border: 2px solid gray;
    border-radius: 6px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    margin: 20px;
    padding: 10px;
    width: auto; /* Maintain aspect ratio */
    height: auto; /* Maintain aspect ratio */
    transition: transform 0.2s;
" onmouseover="this.style.transform='scale(1.5)'" onmouseout="this.style.transform='scale(1)'"/>

   <p style="color: #006600; font-family: 'Trebuchet MS', Helvetica, sans-serif; background-color: #e6ffe6; padding: 15px; border-left: 5px solid #00cc66;">
   Express setup is a quicker option as it both installs and links the local IR environment with the synapse setup. If you prefer to do a manual setup, refer to to appenxis.
   </p>

## <span style="color: DarkCyan">Create Two Linked Services (Connection Strings)</span>

Next, we need to create two connection strings (also known as Linked Services): one to the local laptop's folder (source) and another to the ADLS (destination).

### <span style="color: ForestGreen">Linked Service to Laptop's Folder</span>

1. In Synapse workspace, go to **Manage** -> **Linked Services** -> **New**.
2. Select **File System** and provide a name for the linked service.
<img src="images\image-18.png" alt="alt text" style="
    border: 2px solid gray;
    border-radius: 6px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    margin: 20px;
    padding: 10px;
    width: auto; /* Maintain aspect ratio */
    height: auto; /* Maintain aspect ratio */
    transition: transform 0.2s;
" onmouseover="this.style.transform='scale(1.5)'" onmouseout="this.style.transform='scale(1)'"/>
3. Select the Integration Runtime we created earlier.
4. Specify the path to the CSV files on your laptop and provide a user name and password which has read/write access to the folder.
<img src="images\image-19.png" alt="alt text" style="
    border: 2px solid gray;
    border-radius: 6px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    margin: 20px;
    padding: 10px;
    width: auto; /* Maintain aspect ratio */
    height: auto; /* Maintain aspect ratio */
    transition: transform 0.2s;
" onmouseover="this.style.transform='scale(1.5)'" onmouseout="this.style.transform='scale(1)'"/>


   <p style="color: #006600; font-family: 'Trebuchet MS', Helvetica, sans-serif; background-color: #e6ffe6; padding: 15px; border-left: 5px solid #00cc66;">
   Here, sa is a local user which  has read/write access to the folder. 
   </p>

   <img src="images\image-12.png" alt="alt text" style="
    border: 2px solid gray;
    border-radius: 6px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    margin: 20px;
    padding: 10px;
    width: auto; /* Maintain aspect ratio */
    height: auto; /* Maintain aspect ratio */
    transition: transform 0.2s;
" onmouseover="this.style.transform='scale(1.5)'" onmouseout="this.style.transform='scale(1)'"/>

Go to the properties of the source folder and navigate to the security tab to check if the user has the appropriate permissions for the folder.

   <img src="images\image-31.png" alt="alt text" style="
    border: 2px solid gray;
    border-radius: 6px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    margin: 20px;
    padding: 10px;
    width: auto; /* Maintain aspect ratio */
    height: auto; /* Maintain aspect ratio */
    transition: transform 0.2s;
" onmouseover="this.style.transform='scale(1.5)'" onmouseout="this.style.transform='scale(1)'"/>

#### <span style="color: Red">**A Common Error**</span>

After setting up the linked service when you Test connection it may  fail. 
   <img src="images\image-13.png" alt="alt text" style="
    border: 2px solid gray;
    border-radius: 6px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    margin: 20px;
    padding: 10px;
    width: auto; /* Maintain aspect ratio */
    height: auto; /* Maintain aspect ratio */
    transition: transform 0.2s;
" onmouseover="this.style.transform='scale(1.5)'" onmouseout="this.style.transform='scale(1)'"/>

This has nothing to do with the setup but a windows security feature which causes the issue. To resolve this, open **Command Prompt** as **Administrator** and run the following commands:

   ```shell
   cd C:\Program Files\Microsoft Integration Runtime\5.0\Shared
   .\dmgcmd.exe -DisableLocalFolderPathValidation
   ```

This will disable local folder path validation, and Test connection will pass this time.
   <img src="images\image-15.png" alt="alt text" style="
    border: 2px solid gray;
    border-radius: 6px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    margin: 20px;
    padding: 10px;
    width: auto; /* Maintain aspect ratio */
    height: auto; /* Maintain aspect ratio */
    transition: transform 0.2s;
" onmouseover="this.style.transform='scale(1.5)'" onmouseout="this.style.transform='scale(1)'"/>

### <span style="color: ForestGreen">Linked Service to ADLS</span>

1. Navigate to **Manage** -> **Linked Services** -> **New**.
2. Select **Azure Data Lake Storage Gen2**.
<img src="images\image-14.png" alt="alt text" style="
    border: 2px solid gray;
    border-radius: 6px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    margin: 20px;
    padding: 10px;
    width: auto; /* Maintain aspect ratio */
    height: auto; /* Maintain aspect ratio */
    transition: transform 0.2s;
" onmouseover="this.style.transform='scale(1.5)'" onmouseout="this.style.transform='scale(1)'"/>

3. In Our case we will use **AutoResolveIntegrationRuntime**. Sometimes its a good choice. 
<img src="images\image-21.png" alt="alt text" style="
    border: 2px solid gray;
    border-radius: 6px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    margin: 20px;
    padding: 10px;
    width: auto; /* Maintain aspect ratio */
    height: auto; /* Maintain aspect ratio */
    transition: transform 0.2s;
" onmouseover="this.style.transform='scale(1.5)'" onmouseout="this.style.transform='scale(1)'"/>


## <span style="color: DarkCyan">Create a Pipeline with Copy Data Activity</span>

Now that the linked services are configured, create a pipeline to copy data:

### <span style="color: RoyalBlue">Crate a New Pipeline in Syanpse Workspace</span>

In Synapse workspace, go to **Integrate** -> **Pipelines** -> **New Pipeline**.
<img src="images\image-20.png" alt="alt text" style="
    border: 2px solid gray;
    border-radius: 6px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    margin: 20px;
    padding: 1px;
    width: auto; /* Maintain aspect ratio */
    height: auto; /* Maintain aspect ratio */
    transition: transform 0.2s;
" onmouseover="this.style.transform='scale(1.5)'" onmouseout="this.style.transform='scale(1)'"/>

### <span style="color: RoyalBlue">Add Copy Data Activity</span>

Drag and drop the **Copy Data** activity onto the pipeline canvas.
<img src="images\image-22.png" alt="alt text" style="
    border: 2px solid gray;
    border-radius: 6px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    margin: 20px;
    padding: 1px;
    width: auto; /* Maintain aspect ratio */
    height: auto; /* Maintain aspect ratio */
    transition: transform 0.2s;
" onmouseover="this.style.transform='scale(1.5)'" onmouseout="this.style.transform='scale(1)'"/>

### <span style="color: RoyalBlue">Configure the Source Dataset etc</span>

1. **Choose dataset:** Go to the Source tab, then Files, select File System, and click Continue.
<img src="images\image-23.png" alt="alt text" style="
    border: 2px solid gray;
    border-radius: 6px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    margin: 20px;
    padding: 1px;
    width: auto; /* Maintain aspect ratio */
    height: auto; /* Maintain aspect ratio */
    transition: transform 0.2s;
" onmouseover="this.style.transform='scale(1.5)'" onmouseout="this.style.transform='scale(1)'"/>


2. **Choose File Format:** Now, you have to select the format of the source files. We have CSV, so we will select Delimited Text.
<img src="images\image-24.png" alt="alt text" style="
    border: 2px solid gray;
    border-radius: 6px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    margin: 20px;
    padding: 1px;
    width: auto; /* Maintain aspect ratio */
    height: auto; /* Maintain aspect ratio */
    transition: transform 0.2s;
" onmouseover="this.style.transform='scale(1.5)'" onmouseout="this.style.transform='scale(1)'"/>


3. **Select Linked Service:** Next, select the Linked Service which we created earlier. This is the connection string that connects to the Laptops folder. You will see the File path and other details appear. Choose First row as header, which is usually the case for all CSVs.
<img src="images\image-25.png" alt="alt text" style="
    border: 2px solid gray;
    border-radius: 6px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    margin: 20px;
    padding: 1px;
    width: auto; /* Maintain aspect ratio */
    height: auto; /* Maintain aspect ratio */
    transition: transform 0.2s;
" onmouseover="this.style.transform='scale(1.5)'" onmouseout="this.style.transform='scale(1)'"/>


4. **Preview data:** If successful, you can preview the data. It will load one of the files to show you how the data looks, displaying a well-formatted table. Note, how we have seleccted *.csv to load all the csv files in the folder.
<img src="images\image-26.png" alt="alt text" style="
    border: 2px solid gray;
    border-radius: 6px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    margin: 20px;
    padding: 1px;
    width: auto; /* Maintain aspect ratio */
    height: auto; /* Maintain aspect ratio */
    transition: transform 0.2s;
" onmouseover="this.style.transform='scale(1.5)'" onmouseout="this.style.transform='scale(1)'"/>


### <span style="color: RoyalBlue">Configure the Sink Dataset</span>

1. **Select Integration Dataset:** Go to the Sink tab, then select Azure Data Lake Storage Gen2.
<img src="images\image-27.png" alt="alt text" style="
    border: 2px solid gray;
    border-radius: 6px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    margin: 20px;
    padding: 1px;
    width: auto; /* Maintain aspect ratio */
    height: auto; /* Maintain aspect ratio */
    transition: transform 0.2s;
" onmouseover="this.style.transform='scale(1.5)'" onmouseout="this.style.transform='scale(1)'"/>

2. **Selct File Format:** Now, we need to provide the format in which the data will be copied to the destination. For this, select **DelimitedText**.
<img src="images\image-28.png" alt="alt text" style="
    border: 2px solid gray;
    border-radius: 6px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    margin: 20px;
    padding: 1px;
    width: auto; /* Maintain aspect ratio */
    height: auto; /* Maintain aspect ratio */
    transition: transform 0.2s;
" onmouseover="this.style.transform='scale(1.5)'" onmouseout="this.style.transform='scale(1)'"/>


3. **Select Linked Service & IR:** Next, select the linked service which has the connection information to the container in ADLS where your data will be stored. You can choose any integration runtime. Here, I have chosen the default AutoResolveIntegrationRuntime as it is the simplest and comes factory-shipped with the Synapse workspace.
<img src="images\image-29.png" alt="alt text" style="
    border: 2px solid gray;
    border-radius: 6px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    margin: 20px;
    padding: 1px;
    width: auto; /* Maintain aspect ratio */
    height: auto; /* Maintain aspect ratio */
    transition: transform 0.2s;
" onmouseover="this.style.transform='scale(1.5)'" onmouseout="this.style.transform='scale(1)'"/>


4. **Choose other properties:** Once the sink dataset is configured, you can choose other properties like Copy behavior, etc.
<img src="images\image-30.png" alt="alt text" style="
    border: 2px solid gray;
    border-radius: 6px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    margin: 20px;
    padding: 1px;
    width: auto; /* Maintain aspect ratio */
    height: auto; /* Maintain aspect ratio */
    transition: transform 0.2s;
" onmouseover="this.style.transform='scale(1.5)'" onmouseout="this.style.transform='scale(1)'"/>

### <span style="color: RoyalBlue">Execute the Pipeline</span>

1. **Validate the Pipeline**: Ensure all configurations are correct and validate the pipeline.
2. **Run the Pipeline**: Execute the pipeline to start the data transfer from your laptop to ADLS. If it runs successfully you will see the data copied to your desired ADLS container.
<img src="images\image-32.png" alt="alt text" style="
    border: 2px solid gray;
    border-radius: 6px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    margin: 20px;
    padding: 1px;
    width: auto; /* Maintain aspect ratio */
    height: auto; /* Maintain aspect ratio */
    transition: transform 0.2s;
" onmouseover="this.style.transform='scale(1.5)'" onmouseout="this.style.transform='scale(1)'"/>

## <span style="color: Gray">Appendix</span>

### <span style="color: CadetBlue">Manually Installating Integration Runtime

The integration runtime can also be downloaded and installed separately from the Microsoft software store.
<img src="images\image-5.png" alt="Integration runtime download screen" style="
    border: 2px solid gray;
    border-radius: 6px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    margin: 20px;
    padding: 10px;
    width: auto; /* Maintain aspect ratio */
    height: auto; /* Maintain aspect ratio */
    transition: transform 0.2s;
" onmouseover="this.style.transform='scale(1.5)'" onmouseout="this.style.transform='scale(1)'"/>

Install it on your local machine. The steps are straightforward. Just click through the installation process.

<img src="images\image-6.png" alt="Integration runtime installation steps" style="
    border: 2px solid gray;
    border-radius: 6px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    margin: 20px;
    padding: 1px;
    width: auto; /* Maintain aspect ratio */
    height: auto; /* Maintain aspect ratio */
    transition: transform 0.2s;
" onmouseover="this.style.transform='scale(1.5)'" onmouseout="this.style.transform='scale(1)'"/>

In the final step, you will need to register the Runtime by copying and pasting the authentication key from the Synapse portal.
<img src="images\image-16.png" alt="Integration runtime registration" style="
    border: 2px solid gray;
    border-radius: 6px;
    box-shadow: 0px 4px 8px rgba(0, 0, 0, 0.2);
    margin: 20px;
    padding: 1px;
    width: auto; /* Maintain aspect ratio */
    height: auto; /* Maintain aspect ratio */
    transition: transform 0.2s;
" onmouseover="this.style.transform='scale(2)'" onmouseout="this.style.transform='scale(1)'"/>

