---
layout: default
title: SPMT - SharePoint Migration
parent: SharePoint Office 365
nav_order: 9
---
- [Migrating to Microsoft 365 with the SharePoint Migration Tool (SPMT)](#migrating-to-microsoft-365-with-the-sharepoint-migration-tool-spmt)
    - [What Can Be Migrated?](#what-can-be-migrated)
    - [Let's get started](#lets-get-started)


![alt text](2.jpg)

## Migrating to Microsoft 365 with the SharePoint Migration Tool (SPMT)

<p style="color: #006600; font-family: 'Trebuchet MS', Helvetica, sans-serif; background-color: #e6ffe6; padding: 15px; border-left: 5px solid #00cc66;">
If you're looking to move your content from on-site SharePoint locations to the cloud with Microsoft 365, there's a free and user-friendly tool just for you. The SharePoint Migration Tool (SPMT) is here to simplify the process of transferring your SharePoint Server sites and content.
</p>

#### What Can Be Migrated?

The table below contains the items which can be migrated using SPMT.

| **Supported Feature**                                                                                           | **Description**                                                                                      |
|-----------------------------------------------------------------------------------------------------------------|------------------------------------------------------------------------------------------------------|
| <span style="color: blue;">**Migration Sources**</span>                                                         |                                                                                                      |
| <span style="color: blue;">On-premises fileshares</span>                                                        | Supports local and network fileshares migration.                                                     |
| <span style="color: blue;">SharePoint Server versions</span>                                                    | Migrates from SharePoint Server 2010, 2013, 2016, and 2019.                                           |
| <span style="color: green;">**Content Types**</span>                                                            |                                                                                                      |
| <span style="color: green;">File, folder, list items</span>                                                     | Migrates files, folders, and lists.                                                                  |
| <span style="color: green;">Pages</span>                                                                        | Migrates pages in the site asset library.                                                            |
| <span style="color: Chocolate;">**Permissions & Security**</span>                                                  |                                                                                                      |
| <span style="color: Chocolate;">Permissions</span>                                                                 | Sets file share and SharePoint permissions separately.                                               |
| <span style="color: purple;">**Site Features & Components**</span>                                              |                                                                                                      |
| <span style="color: purple;">Managed metadata and taxonomy</span>                                               | Supports content types and term store migration; requires admin permissions.                         |
| <span style="color: purple;">Navigation and icons</span>                                                        | Preserves and migrates site navigation for out-of-box sites.                                         |
| <span style="color: purple;">Site features</span>                                                               | Supports a wide range of site features.                                                              |
| <span style="color: purple;">SharePoint web parts</span>                                                        | Supports SharePoint web parts migration.                                                             |
| <span style="color: purple;">Site migration</span>                                                              | Migrates "out-of-the-box" SharePoint sites without coding or third-party tools.                      |
| <span style="color: purple;">Site description</span>                                                            | Migrates site descriptions.                                                                          |
| <span style="color: #3333cc;">**Workflows & Automation**</span>                                                  |                                                                                                      |
| <span style="color: #3333cc;">OOTB Workflows to Power Automate</span>                                            | Migrates SharePoint Server 2010 OOTB workflows to Power Automate.                                    |
| <span style="color: #3333cc;">SPD Workflows to Power Automate</span>                                             | Migrates SharePoint Server 2010 and 2013 Designer workflows to Power Automate.                       |
| <span style="color: #3333cc;">List, library, content-type workflows</span>                                       | Migrates list, library, and content-type workflows (excluding site workflows).                       |
| <span style="color: #3333cc;">Workflow definitions and associations</span>                                       | Migrates workflow definitions and associations, not history data.                                    |
| <span style="color: #9e0059;">**Additional Features**</span>                                                       |                                                                                                      |
| <span style="color: #9e0059;">Incremental</span>                                                                   | Supports incremental migration by rerunning tasks later.                                             |
| <span style="color: #9e0059;">Microsoft Teams</span>                                                               | Allows selection of Teams and channels for migration.                                                |
| <span style="color: #9e0059;">Taxonomy migration</span>                                                            | Manages metadata and taxonomy in incremental updates; off by default.                                |
| <span style="color: #9e0059;">Bulk migration</span>                                                                | Allows bulk migration via JSON or CSV for numerous sources.                                          |
| <span style="color: #9e0059;">Versions</span>                                                                      | Lets you choose what file history to preserve.                                                       |


#### Let's get started
