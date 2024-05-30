## Integration Runtime in Azure Synapse Analytics and Azure Data Factory

### Introduction

Moving, copying, and fetching data are the main tasks of Azure Synapse and Azure Data Factory (ADF). The most important component for these tasks is the **Integration Runtime**. Think of it as a **bridge** that connects Synapse and ADF with data from on-premises and external sources.

However, it's more than just a bridge. It provides the CPU and memory needed for copying and transforming data. It also offers an environment to run your SSIS packages. It can scale up or down if more CPU or memory is needed. Plus, it ensures that your data transfer is secure.

#### Types of Integration Runtime
There are three types of Integration Runtime:

1. **Azure Integration Runtime**:
   - **Purpose**: Primarily used for data movement and transformation in the cloud. This is cloud-based.
   - **Features**: Supports copy activities between cloud data stores, data flow activities for data transformation, and external activities like Databricks, HDInsight, and stored procedures.

2. **Self-hosted Integration Runtime**: Connects and lets you copy data from your local machine or any out-of-direct-line-of-sight location from the Azure cloud. For example, a SQL server on your laptop or an FBI database ;-) Also, lets you run SSIS packages on your laptop.

3. **Azure-SSIS Integration Runtime**:
   - **Purpose**: Facilitates the execution of SQL Server Integration Services (SSIS) packages in the Azure environment.
   - **Features**: Fully managed cluster of Azure VMs dedicated to running SSIS packages, supports Azure SQL Database, SQL Managed Instance, and SQL Server on Azure VM as SSISDB.

#### Configuring Integration Runtime

##### Azure Integration Runtime
1. **Creation**:
   - Navigate to Azure Synapse Analytics or ADF.
   - Select the Manage tab.
   - Under Integration Runtimes, click on + New.
   - Choose Azure, and follow the setup wizard.

2. **Configuration**:
   - Specify the region for optimal performance and cost.
   - Configure auto-scaling and concurrency settings as needed.

##### Self-hosted Integration Runtime
1. **Installation**:
   - Download the Self-hosted IR installer from the Azure portal.
   - Install the runtime on a machine within your network.

2. **Configuration**:
   - Register the self-hosted IR with the Azure Data Factory or Synapse workspace.
   - Configure network settings to allow secure data movement.
   - Set up high availability by adding multiple nodes.

##### Azure-SSIS Integration Runtime
1. **Creation**:
   - Navigate to the ADF or Synapse workspace.
   - Go to the Manage tab, and click on Integration Runtimes.
   - Choose Azure-SSIS and follow the creation wizard.

2. **Configuration**:
   - Select the pricing tier and node size.
   - Configure the custom setup by installing necessary components.
   - Connect to the SSISDB or create a new one in Azure SQL Database.

#### Best Practices for Using Integration Runtime

1. **Optimize Performance**:
   - Choose the appropriate IR type based on the source and destination of data.
   - Use Azure IR for cloud-to-cloud data movement to leverage Azure's high-speed backbone.
   - For on-premises data, ensure self-hosted IR is installed on machines with adequate resources and network connectivity.

2. **Ensure Security**:
   - Use private endpoints and Virtual Network (VNet) service endpoints to secure data movement.
   - Encrypt data in transit and at rest using Azure's security features.
   - Regularly update and patch self-hosted IR nodes to protect against vulnerabilities.

3. **High Availability and Scalability**:
   - Set up multiple nodes for self-hosted IR to ensure high availability.
   - Use auto-scaling features in Azure IR to handle varying data loads efficiently.
   - Monitor performance and adjust resource allocation as needed.

4. **Cost Management**:
   - Select the appropriate pricing tier for Azure-SSIS IR based on workload requirements.
   - Monitor and analyze usage patterns to optimize costs.
   - Take advantage of reserved instances and Azure Hybrid Benefit if applicable.

#### Conclusion



### Differences between Self-hosted Integration Runtime and On-premises Data Gateway

| Feature                         | Self-hosted Integration Runtime                               | On-premises Data Gateway                                   |
|---------------------------------|--------------------------------------------------------------|-----------------------------------------------------------|
| **Purpose**                     | Facilitates data integration for Azure Data Factory and Synapse Pipelines. | Connects on-premises data sources to Power BI, Power Apps, Power Automate, and Logic Apps. |
| **Supported Services**          | Azure Data Factory, Azure Synapse Analytics.                 | Power BI, Power Apps, Power Automate, Logic Apps.         |
| **Data Transfer Capabilities**  | Handles ETL (Extract, Transform, Load) processes, data movement, and SSIS execution. | Enables real-time connectivity for reporting and app development. |
| **Installation**                | Installed on-premises to access local data sources for ADF/Synapse. | Installed on-premises for secure connectivity to Power Platform services. |
| **Security**                    | Secure data transfer with encrypted communication.           | Secure data transfer with encryption and local network connectivity. |

### Use Cases

- **Self-hosted Integration Runtime**: Use for complex ETL processes, large-scale data integration, and when leveraging ADF/Synapse for data engineering tasks.
- **On-premises Data Gateway**: Use for real-time data access in Power BI reports, automating workflows with Power Automate, and connecting to on-premises data in Power Apps and Logic Apps.

### Alternatives

| **Component**                     | **Description**                                                                                           | **Use Cases**                                                                                           |
|-----------------------------------|-----------------------------------------------------------------------------------------------------------|---------------------------------------------------------------------------------------------------------|
| **Azure Integration Runtime (IR)**  | Executes data flows, data movement, and transformation activities within Synapse or with external data sources. | Connecting to cloud-based data sources, executing data integration and transformation tasks.            |
| **Self-hosted Integration Runtime** | Connects to on-premises data sources, allowing data to be securely moved to and from Azure Synapse.       | Securely transferring data between on-premises systems and Azure Synapse Analytics.                      |
| **On-Premises Data Gateway**        | Allows secure connectivity between on-premises data sources and Azure Synapse Analytics.                   | Enabling data ingestion and processing from on-premises databases and systems to Synapse.                |
| **Azure Synapse Link**              | Provides real-time data integration between operational data stores like Azure Cosmos DB and Synapse.     | Near real-time analytics by continuously replicating data from operational stores to Synapse.            |
| **PolyBase**                        | Data virtualization technology that allows querying of external data as if it were in Synapse.            | Querying data from Azure Blob Storage, ADLS, and other databases like SQL Server, Oracle, and Hadoop.    |
| **Linked Services**                 | Define the connection information needed for Synapse to connect to external resources.                    | Managing connections to storage accounts, databases, and other services.                                 |