---
layout: default
title: Project - ETL and Reporting Lending Org
parent: DE-Projects
nav_order: 4
---

# Setting Up SSRS Reports in SharePoint for a Client with 100+ Field Offices

## Background

The company has over 100 field offices, from which data is collected daily using different ETL workflows. Each workflow represents a specific lending process.

The data includes both documents and metadata. The operational documents are stored in a Document warehouse, while the related metadata is kept in MSSQL tables.

The analytical data for reporting is stored in MSSQL tables. At the end of each month, the company generates reports to ensure they include the latest data.

## Goal

Create an end-to-end workflow using SSRS and SharePoint to automate the report generation process using the latest data from the MSSQL Server.

## Step-by-Step Guide

### MSSQL Database Design

First, the tables for storing the analytical data were created. Each table represented one process like:
- `CustomerApplication`
- `CreditEvaluation`
- `LoanApproval`
- `Disbursement`
- `RepaymentTracking`

There were over 15 such processes.

### Creation of ETL Processes

Field office staff captured data at their office and pushed it to a shared network folder. For each batch, one JSON file was created. This contained the metadata which needed to be flattened and stored in MSSQL. For this, SSIS was used.

### Configuring SharePoint

Under the root site for Loan Origination and Processing, a subsite was created for managing the reports: `https://<root_site_for_Loan_Accounting>/sites/MonthlyReports`.

### Setting Up SSRS in SharePoint

SQL Server Reporting Services (SSRS) was installed in SharePoint integrated mode on the SharePoint farm. SSRS was configured to run with our SharePoint instance.

### Creation of Report Libraries in SharePoint

Report libraries were created in the SharePoint site's Site Contents. Following is an overview of the steps:

- Go to your SharePoint site.
- Click on the Settings symbol (gear icon) and select "Site Contents."
- Click "Add an app" and search for "Report Library."
- Name the app (e.g., "MonthlyReport1_LAC") and click "Create."
- Click on the three dots (...) next to your Report Library and select "App Settings."
- Click "Add from existing site content types" and add the "SQL Server Reporting Service" content type.

### Setting Up Data Sources and Datasets in SSRS

After creating the report libraries, we created the required data sources. Following is an overview of the steps:

1. **Create Data Source**
   - In your Report Library, create a new data source.
   - Enter the connection string to your MSSQL database, including server name, database name, and authentication details.
   - Example: `Server=myServerAddress;Database=myDataBase;User Id=myUsername;Password=myPassword;`

2. **Create Datasets**
   - Use the created data source to define datasets that will pull the required data from your MSSQL tables.
   - Example query for dataset:
     ```sql
     SELECT * FROM Disbursement WHERE Date BETWEEN @StartDate AND @EndDate
     ```
   - Set parameters (`@StartDate`, `@EndDate`) to filter data for the month.

### Designing and Deploying Reports

Once the setup was done, we collaborated with higher management for the report designing. SSDT was used for designing.

Here is an overview of the steps:

1. **Design Reports Using Report Builder or SSDT**
   - Open Report Builder or SQL Server Data Tools (SSDT).
   - Create a new report, connect it to the data source and dataset created earlier.
   - Design the layout of the report (tables, charts, etc.).

2. **Deploy Reports to SharePoint**
   - Save the report as an RDL file.
   - Upload the RDL file to the Report Library in SharePoint.

### Scheduling and Automation

After designing and creating the reports, we scheduled them so that they automatically reach the designated recipients every month.

Following is an overview of the steps:

**Set Up Report Subscriptions**
   - In SharePoint, go to the Report Library and find the uploaded report.
   - Set up a subscription to automatically generate the report at the end of each month.
   - Configure the subscription to deliver the report to specific users via email or save it to a document library.

### Access and Permissions

We provided necessary permissions to the libraries and subsites so that the reports are not accessible to everyone, only to the people maintaining or upgrading them in the future. Also, some users were given rights to navigate to the SharePoint site and go to the Report Library to view the latest reports directly.