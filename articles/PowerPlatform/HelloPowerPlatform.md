---
layout: default
title: PowerPlatform Ecosystem
parent: Power Platform
nav_order: 1
---

![alt text](images\image-5.png)

# <span style="color: #003366;">Microsoft Power Platform</span>

## <span style="color: #4C9A2A;">Key Products</span>

- <span style="color: #FF8C00;">Power Apps</span> - For web and mobile apps. PowerApps is a low-code/no-code platform to create apps quickly. Its data can live in SharePoint, Dynamics, M365, or anywhere. Its language is PowerFX (like Excel formulas). Power apps are canvas apps (any data) and model-driven apps (Dataverse only).
- <span style="color: #008080;">Power Automate</span> - Workflows to automate work tasks.
- <span style="color: #800080;">Power BI</span> - Data dashboards and reports.
- <span style="color: #4169E1;">Power Pages</span> - For websites.

## <span style="color: #4C9A2A;">Supporting Tools</span>

- <span style="color: #FF8C00;">Copilot Studio [Power Virtual Agents]</span> - Tool to automate the automation.
- <span style="color: #008080;">Connectors</span> - Connect to Dropbox, Twitter, etc. Approx 900.
- <span style="color: #800080;">AI Builder</span> - Add AI functionality to Power Automate and Power Apps.
- <span style="color: #4169E1;">Dataverse</span> - Backend data for Power Platform.
- <span style="color: #B22222;">Power FX</span> - Programming language for Power Platform.

## A typical power platform project

<span style="color: #FF8C00;">Receive invoice emails from vendors (Office 365 Outlook)</span> -> 
<span style="color: #008080;">Store attachments in SharePoint (Microsoft SharePoint)</span> -> 
<span style="color: #800080;">Send for approval in Teams (Microsoft Teams)</span> -> 
<span style="color: #4169E1;">Enter approved invoices in ERP (Oracle)</span> -> 
<span style="color: #B22222;">Send confirmation email to vendors (Office 365 Outlook)</span>

## Dataverse

- Dataverse ~ Power Platform DB.
- Tables: Standard (OOTB), managed (part of a solution, read-only), custom.
- 4TB storage limit.
- You can apply business logic to tables! E.g., If country is US, then postal code mandatory.

![alt text](images\image-15.png)

## Copilot

Copilot was earlier called Power Virtual Agents. This is like GPT-4/Bing. Here, you just say in plain English what you want. CoPilot will create the power automate/app for you!

![alt text](images\image-6.png)

## Power FX

This is the language of Power Platform. It's like Excel formulas. It's used in PowerApps, Dataverse, and Copilot Studio.

![alt text](images\image-9.png)

## Power Platform and Microsoft Teams

All Power Platform components can be used from within MS Teams.

![alt text](images\image-10.png)
![alt text](images\image-12.png)
![alt text](images\image-11.png)

## Power Platform & Dynamics 365

- **Power Apps:** All Dynamics 365 customer engagement apps are model-driven apps (built in PowerApps). The data for such apps is in Dataverse.
- **Power BI:** Can create reports from Dynamics 365.
- **Power Automate:** Business process flows are created using Power Automate.
- **Copilot Studio:** Call/SMS/Facebook Msgs -> Dynamics 365 Customer Service App -> Copilot -> Live agent.
- **Power Pages:** Self-support websites.

## Power Platform and Azure

Power Platform and Azure offer countless ways to create end-to-end solutions. For instance, an airline project where:

- Azure API Management hosts a custom API for airline system communication.
- A coordinator handles notifications, assigns flights to Teams channels, and sends them to Power Apps.
- Azure Functions process Graph API calls from a storage queue, sending notifications to Teams and streaming events to Azure Event Hubs.
- Azure Bot Service powers a custom bot messaging service for flight updates in Teams.
- Azure Data Lake stores event data from Event Hubs for long-term retention and analytics with Power BI.

![alt text](images\image-13.png)

## Dataverse OOTB features

Here is a picture showing OOTB features of Dataverse.

![alt text](images\image-14.png)

## Dataflows

- ETL tool for Power Platform Ecosystem.
- Uses very little code.
- Uses Power Query (like Excel).
- No infra required, fully on cloud.
- No separate license, use Power BI / Power Apps license.

![alt text](images\image-16.png)

## Common Data Model

Common Data Model is a ready-made collection of tables. For healthcare, you have a patient table and an admission table. With this, you don't have to design tables and choose columns. Microsoft has partnered with industries like healthcare, automobile, and banking to create CDM.

Long story short: Use Common Data Model. Save yourself from complex data modeling tasks.

## Data Sources | Triggers & Actions | Connector Types 

**Data Sources:** 
- **Tabular:** SharePoint, SQL Server, Dataverse
- **Function Based:** 365 Users, Azure Blobs

**Connectors:** 
- Simply put, they link data sources to the Power Platform.
- Types: standard, premium, custom

![alt text](images\connectortype.png)

**Triggers and Actions:**
- **Triggers:** Start the flow in Power Automate, like a spark!
- **Actions:** Perform tasks or operations.

![alt text](images\TriggerAndAction.gif)

## Dataverse Table Creation AKA Dataverse Model

"Does 'Build a Dataverse model' sound intimidating? Don't worry, it's simply about creating tables in the Dataverse database."

![alt text](images\CreateDataverseTable.gif)

## Dataverse vs. MSSQL

| Feature | Dataverse | MSSQL |
|---|---|---|
|**Focus** | Business Applications | Data Management |
|**Schema** | Flexible | Fixed |
|**Data Types** | Limited | Complete |
|**Relationships** | Built-in | Foreign Keys |
|**Data Manipulation** | User-friendly interface, low-code | T-SQL, Programming Languages |
|**Security** | Role-Based Access Control | Manual Setup |
|**Table Types** | Standard, Custom, Virtual, Elastic | Base, Temporary, Views, Table-Valued Functions |
|**Views** | Limited (Virtual Tables) | Traditional Views |
|**Business Logic (Table Level)** | Power Automate Workflows | Stored Procedures, Triggers |
|**Business Logic (Column Level)** | Validation Rules, Workflows | Constraints, Triggers |

