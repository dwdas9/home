---
layout: default
title: Blob Copy
parent: DE-Projects
nav_order: 3
---

## Project Overview: Automating Data Integration for an Insurance Company

### Client Background
Our client was a major insurance company with many branch offices and third-party vendors. They needed a workflow to process data received in XML format from various sources and load it into MSSQL Server for reporting.

### Project Requirements
The main task was to create ETL workflows that would automatically take data from XML files in dedicated network folders and put it into a backend SQL Server 2008 database. We used SQL Server Integration Services (SSIS) as our ETL tool.

### Solution Design and Implementation

1. **Data Source Setup**:
   - XML files containing insurance data were received from branch offices and third-party vendors.
   - These files were received in a dedicated shared folder.

2. **ETL Workflow Creation**:
   - **Development Environment**: We used Business Intelligence Development Studio (BIDS) to design and develop SSIS packages.
   - **Control Flow Setup**: We created a new SSIS package to manage the ETL process. Key components included:
     - **File System Task**: This moved processed XML files to an archive folder to ensure each file was processed only once.
     - **Foreach Loop Container**: This iterated over each XML file in the network folder.
     - **Execute SQL Task**: Used as a placeholder for any necessary SQL commands, such as staging the data or performing initial data checks.

3. **Data Flow Configuration**:
   - **XML Source**: This was configured to read and parse XML files. An XSD file defined the structure of the XML data.
   - **Transformations**: We used components like "Derived Column" and "Data Conversion" to manipulate and convert data as needed.
   - **Data Loading**: Data was directed to an "OLE DB Destination" which connected to the SQL Server 2008 database and inserted data into the appropriate tables.

4. **Scheduling and Automation**:
   - The SSIS package was deployed to the SSIS catalog on the SQL Server.
   - **SQL Server Agent** was used to schedule the SSIS package to run at specific intervals, ensuring timely and regular data integration.
     - We created a new SQL Server Agent Job with steps to execute the SSIS package.
     - A schedule was set up to run the job at a particular time of night, ensuring data was processed and loaded into the SQL Server database consistently.

### Challenges and Solutions
- We had to spend a lot of effort on the design of XSD files. We had to make sure the schema stayed intact and was finalized as it came from multiple sources.
- Ensuring that each XML file was processed only once was crucial. The File System Task within SSIS helped move processed files to an archive folder, preventing reprocessing and maintaining data integrity.
- As there were a large number of files at each intake, we made sure that the data transformation didn't take excessive memory during processing.

### Outcome
With this solution, the client was able to incrementally load data from the control files into the MSSQL server. Since we used SSIS for the ETL process, it required minimal customization compared to other projects where we used custom C#.NET coding. This made the solution easier to support and maintain.

**Tech Stack Used**: SQL Server 2008, SQL Server Integration Services (SSIS), Business Intelligence Development Studio (BIDS), XML, XSD, C#.NET for custom development.